# frozen_string_literal: true

require "json"
require "openssl"
require "primer/view_components/constants"

require_relative "tag_tree_helpers"

# :nocov:

module ERBLint
  module Linters
    # Provides the basic linter logic. When inherited, you should define:
    # * `TAGS` - required - The HTML tags that the component supports. It will be used by the linter to match elements.
    # * `MESSAGE` - required - The message shown when there's an offense.
    # * `CLASSES` - optional - The CSS classes that the component needs. The linter will only match elements with one of those classes.
    # * `REQUIRED_ARGUMENTS` - optional - A list of HTML attributes that are required by the component.
    class BaseLinter < Linter
      include TagTreeHelpers

      DUMP_FILE = ".erblint-counter-ignore.json"
      DISALLOWED_CLASSES = [].freeze
      CLASSES = [].freeze
      REQUIRED_ARGUMENTS = [].freeze

      class ConfigSchema < LinterConfig
        property :override_ignores_if_correctable, accepts: [true, false], default: false, reader: :override_ignores_if_correctable?
      end

      def self.inherited(base)
        super
        base.include(ERBLint::LinterRegistry)
        base.config_schema = ConfigSchema
      end

      def run(processed_source)
        @total_offenses = 0
        @offenses_not_corrected = 0
        (tags, tag_tree) = build_tag_tree(processed_source)

        tags.each do |tag|
          next if tag.closing?
          next if self.class::TAGS&.none?(tag.name)

          classes = tag.attributes["class"]&.value&.split(" ") || []
          tag_tree[tag][:offense] = false

          next if (classes & self.class::DISALLOWED_CLASSES).any?
          next unless self.class::CLASSES.blank? || (classes & self.class::CLASSES).any?

          args = map_arguments(tag, tag_tree[tag])
          correction = correction(args)

          attributes = tag.attributes.each.map(&:name).join(" ")
          matches_required_attributes = self.class::REQUIRED_ARGUMENTS.blank? || self.class::REQUIRED_ARGUMENTS.all? { |arg| attributes.match?(arg) }

          tag_tree[tag][:offense] = true
          tag_tree[tag][:correctable] = matches_required_attributes && !correction.nil?
          tag_tree[tag][:message] = message(args, processed_source)
          tag_tree[tag][:correction] = correction
        end

        tag_tree.each do |tag, h|
          next unless h[:offense]

          @total_offenses += 1
          # We always fix the offenses using blocks. The closing tag corresponds to `<% end %>`.
          if h[:correctable]
            add_correction(tag, h)
          else
            @offenses_not_corrected += 1
            generate_offense(self.class, processed_source, tag, h[:message])
          end
        end

        counter_correct?(processed_source)

        dump_data(processed_source) if ENV["DUMP_LINT_DATA"] == "1"
      end

      def autocorrect(processed_source, offense)
        return unless offense.context

        lambda do |corrector|
          if offense.context.include?(counter_disable)
            correct_counter(corrector, processed_source, offense)
          else
            corrector.replace(offense.source_range, offense.context)
          end
        end
      end

      private

      def add_correction(tag, tag_tree)
        add_offense(tag.loc, tag_tree[:message], tag_tree[:correction])
        add_offense(tag_tree[:closing].loc, tag_tree[:message], "<% end %>")
      end

      # Override this function to convert the HTML element attributes to argument for a component.
      #
      # @return [Hash] if possible to map all attributes to arguments.
      # @return [Nil] if cannot map to arguments.
      def map_arguments(_tag, _tag_tree)
        nil
      end

      # Override this function to define how to autocorrect an element to a component.
      #
      # @return [String] with the text to replace the HTML element if possible to correct.
      # @return [Nil] if cannot correct element.
      def correction(_tag)
        nil
      end

      # Override this function to customize the linter message.
      #
      # @return [String] message to show on linter error.
      def message(_tag, _processed_source)
        self.class::MESSAGE
      end

      def counter_disable
        "erblint:counter #{self.class.name.demodulize}"
      end

      def correct_counter(corrector, processed_source, offense)
        if processed_source.file_content.include?(counter_disable)
          # update the counter if exists
          corrector.replace(offense.source_range, offense.context)
        else
          # add comment with counter if none
          corrector.insert_before(processed_source.source_buffer.source_range, "#{offense.context}\n")
        end
      end

      def tags(processed_source)
        processed_source.parser.nodes_with_type(:tag).map { |tag_node| BetterHtml::Tree::Tag.from_node(tag_node) }
      end

      def counter_correct?(processed_source)
        comment_node = nil
        expected_count = 0
        rule_name = self.class.name.match(/:?:?(\w+)\Z/)[1]

        processed_source.parser.ast.descendants(:erb).each do |node|
          indicator_node, _, code_node, = *node
          indicator = indicator_node&.loc&.source
          comment = code_node&.loc&.source&.strip

          if indicator == "#" && comment.start_with?("erblint:count") && comment.match(rule_name)
            comment_node = node
            expected_count = comment.match(/\s(\d+)\s?$/)[1].to_i
          end
        end

        # Unless explicitly set, we don't want to mark correctable offenses if the counter is correct.
        if !@config.override_ignores_if_correctable? && expected_count == @total_offenses
          clear_offenses
          return
        end

        if @offenses_not_corrected.zero?
          # have to adjust to get `\n` so we delete the whole line
          add_offense(processed_source.to_source_range(comment_node.loc.adjust(end_pos: 1)), "Unused erblint:count comment for #{rule_name}", "") if comment_node
          return
        end

        first_offense = @offenses[0]

        if comment_node.nil?
          add_offense(processed_source.to_source_range(first_offense.source_range), "#{rule_name}: If you must, add <%# erblint:counter #{rule_name} #{@offenses_not_corrected} %> to bypass this check.", "<%# erblint:counter #{rule_name} #{@offenses_not_corrected} %>")
        elsif expected_count != @offenses_not_corrected
          add_offense(processed_source.to_source_range(comment_node.loc), "Incorrect erblint:counter number for #{rule_name}. Expected: #{expected_count}, actual: #{@offenses_not_corrected}.", "<%# erblint:counter #{rule_name} #{@offenses_not_corrected} %>")
        # the only offenses remaining are not autocorrectable, so we can ignore them
        elsif expected_count == @offenses_not_corrected && @offenses.size == @offenses_not_corrected
          clear_offenses
        end
      end

      def generate_offense(klass, processed_source, tag, message = nil, replacement = nil)
        message ||= klass::MESSAGE
        klass_name = klass.name.demodulize
        offense = ["#{klass_name}:#{message}", tag.node.loc.source].join("\n")
        add_offense(processed_source.to_source_range(tag.loc), offense, replacement)
      end

      def dump_data(processed_source)
        return if @total_offenses.zero?

        data = File.exist?(DUMP_FILE) ? JSON.parse(File.read(DUMP_FILE)) : {}

        data[processed_source.filename] ||= {}
        data[processed_source.filename][self.class.name.demodulize] = @total_offenses

        File.write(DUMP_FILE, JSON.pretty_generate(data))
      end
    end
  end
end
