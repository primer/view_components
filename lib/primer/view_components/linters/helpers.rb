# frozen_string_literal: true

require "json"
require "openssl"

module ERBLint
  module Linters
    # Helper methods for linting ERB.
    module Helpers
      # from https://github.com/Shopify/erb-lint/blob/6179ee2d9d681a6ec4dd02351a1e30eefa748d3d/lib/erb_lint/linters/self_closing_tag.rb
      SELF_CLOSING_TAGS = %w[
        area base br col command embed hr input keygen
        link menuitem meta param source track wbr img
      ].freeze

      def self.included(base)
        base.include(ERBLint::LinterRegistry)

        define_method "run" do |processed_source|
          @offenses_not_corrected = 0
          tags = tags(processed_source)
          tag_tree = build_tag_tree(tags)

          tags.each do |tag|
            next if tag.closing?
            next unless self.class::TAGS&.include?(tag.name)

            classes = tag.attributes["class"]&.value&.split(" ") || []

            tag_tree[tag][:offense] = false

            next unless self.class::CLASSES.blank? || (classes & self.class::CLASSES).any?

            args = map_arguments(tag)
            correction = correction(args)

            tag_tree[tag][:offense] = true
            tag_tree[tag][:correctable] = !correction.nil?
            tag_tree[tag][:message] = message(args)
            tag_tree[tag][:correction] = correction
          end

          tag_tree.each do |tag, h|
            next unless h[:offense]

            # We always fix the offenses using blocks. The closing tag corresponds to `<% end %>`.
            if h[:correctable]
              add_offense(tag.loc, h[:message], h[:correction])
              add_offense(h[:closing].loc, h[:message], "<% end %>")
            else
              @offenses_not_corrected += 1
              generate_offense(self.class, processed_source, tag, h[:message])
            end
          end

          counter_correct?(processed_source)
        end

        define_method "autocorrect" do |processed_source, offense|
          return unless offense.context

          lambda do |corrector|
            if offense.context.include?(counter_disable)
              correct_counter(corrector, processed_source, offense)
            else
              corrector.replace(offense.source_range, offense.context)
            end
          end
        end
      end

      private

      # Override this function to convert the HTML element attributes to argument for a component.
      #
      # @return [Hash] if possible to map all attributes to arguments.
      # @return [Nil] if cannot map to arguments.
      def map_arguments(_tag)
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
      def message(_tag)
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

      # This assumes that the AST provided represents valid HTML, where each tag has a corresponding closing tag.
      # From the tags, we build a structured tree which represents the tag hierarchy.
      # With this, we are able to know where the tags start and end.
      def build_tag_tree(tags)
        tag_tree = {}
        current_opened_tag = nil

        tags.each do |tag|
          if tag.closing?
            if current_opened_tag && tag.name == current_opened_tag.name
              tag_tree[current_opened_tag][:closing] = tag
              current_opened_tag = tag_tree[current_opened_tag][:parent]
            end

            next
          end

          self_closing = self_closing?(tag)

          tag_tree[tag] = {
            closing: self_closing ? tag : nil,
            parent: current_opened_tag
          }

          current_opened_tag = tag unless self_closing
        end

        tag_tree
      end

      def self_closing?(tag)
        tag.self_closing? || SELF_CLOSING_TAGS.include?(tag.name)
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
    end
  end
end
