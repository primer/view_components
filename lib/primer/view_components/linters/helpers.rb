# frozen_string_literal: true

require "json"
require "openssl"

module Primer
  module ViewComponents
    module Linters
      # Helper methods for linting ERB.
      module Helpers
        def self.included(base)
          base.include(ERBLint::LinterRegistry)

          define_method "run" do |processed_source|
            tags(processed_source).each do |tag|
              next if tag.closing?
              next unless self.class::TAGS&.include?(tag.name)

              classes = tag.attributes["class"]&.value&.split(" ")

              next unless !self.class::CLASS || classes&.include?(self.class::CLASS)

              generate_offense(self.class, processed_source, tag, self.class::MESSAGE)
            end

            counter_correct?(processed_source)
          end

          define_method "autocorrect" do |processed_source, offense|
            return unless offense.context

            lambda do |corrector|
              if processed_source.file_content.include?("erblint:counter #{self.class.name.demodulize}")
                # update the counter if exists
                corrector.replace(offense.source_range, offense.context)
              else
                # add comment with counter if none
                corrector.insert_before(processed_source.source_buffer.source_range, "#{offense.context}\n")
              end
            end
          end
        end

        private

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
              comment_node = code_node
              expected_count = comment.match(/\s(\d+)\s?$/)[1].to_i
            end
          end

          if offenses_count.zero?
            add_offense(processed_source.to_source_range(comment_node.loc), "Unused erblint:count comment for #{rule_name}") if comment_node
            return
          end

          first_offense = @offenses[0]

          if comment_node.nil?
            add_offense(processed_source.to_source_range(first_offense.source_range), "#{rule_name}: If you must, add <%# erblint:counter #{rule_name} #{offenses_count} %> to bypass this check.", "<%# erblint:counter #{rule_name} #{offenses_count} %>")
          else
            clear_offenses
            add_offense(processed_source.to_source_range(comment_node.loc), "Incorrect erblint:counter number for #{rule_name}. Expected: #{expected_count}, actual: #{offenses_count}.", " erblint:counter #{rule_name} #{offenses_count} ") if expected_count != offenses_count
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
end
