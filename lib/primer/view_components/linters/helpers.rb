# frozen_string_literal: true

require "json"
require "openssl"

module ERBLint
  module Linters
    # Helper methods for linting ERB.
    module Helpers
      def self.included(base)
        base.include(ERBLint::LinterRegistry)

        define_method "run" do |processed_source|
          tags = tags(processed_source)
          tag_tree = build_tag_tree(tags)

          tags.each do |tag|
            next if tag.closing?
            next unless self.class::TAGS&.include?(tag.name)

            classes = tag.attributes["class"]&.value&.split(" ") || []

            tag_tree[tag][:offense] = false

            next unless self.class::CLASSES.blank? || (classes & self.class::CLASSES).any?

            args = map_arguments(tag)

            tag_tree[tag][:offense] = true
            tag_tree[tag][:correctable] = !args.nil?
            tag_tree[tag][:message] = message(args)
            tag_tree[tag][:correction] = correction(args)
          end

          tag_tree.each do |tag, h|
            next unless h[:offense]

            if h[:correctable]
              add_offense(tag.loc, h[:message], h[:correction])
              add_offense(h[:closing].loc, h[:message], "<% end %>")
            else
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

          tag_tree[tag] = {
            closing: nil,
            parent: current_opened_tag
          }

          current_opened_tag = tag
        end

        tag_tree
      end

      def map_arguments(_tag)
        nil
      end

      def correction(_tag)
        nil
      end

      def message(_tag)
        self.class::MESSAGE
      end

      def tags(processed_source)
        processed_source.parser.nodes_with_type(:tag).map { |tag_node| BetterHtml::Tree::Tag.from_node(tag_node) }
      end

      def counter_correct?(processed_source)
        comment_node = nil
        expected_count = 0
        rule_name = self.class.name.match(/:?:?(\w+)\Z/)[1]
        offenses_count = @offenses.length

        processed_source.parser.ast.descendants(:erb).each do |node|
          indicator_node, _, code_node, = *node
          indicator = indicator_node&.loc&.source
          comment = code_node&.loc&.source&.strip

          if indicator == "#" && comment.start_with?("erblint:count") && comment.match(rule_name)
            comment_node = node
            expected_count = comment.match(/\s(\d+)\s?$/)[1].to_i
          end
        end

        if offenses_count.zero?
          # have to adjust to get `\n` so we delete the whole line
          add_offense(processed_source.to_source_range(comment_node.loc.adjust(end_pos: 1)), "Unused erblint:count comment for #{rule_name}", "") if comment_node
          return
        end

        first_offense = @offenses[0]

        if comment_node.nil?
          add_offense(processed_source.to_source_range(first_offense.source_range), "#{rule_name}: If you must, add <%# erblint:counter #{rule_name} #{offenses_count} %> to bypass this check.", "<%# erblint:counter #{rule_name} #{offenses_count} %>")
        else
          clear_offenses
          add_offense(processed_source.to_source_range(comment_node.loc), "Incorrect erblint:counter number for #{rule_name}. Expected: #{expected_count}, actual: #{offenses_count}.", "<%# erblint:counter #{rule_name} #{offenses_count} %>") if expected_count != offenses_count
        end
      end

      def generate_offense(klass, processed_source, tag, message = nil, replacement = nil)
        message ||= klass::MESSAGE
        klass_name = klass.name.split("::")[-1]
        offense = ["#{klass_name}:#{message}", tag.node.loc.source].join("\n")
        add_offense(processed_source.to_source_range(tag.loc), offense, replacement)
      end
    end
  end
end
