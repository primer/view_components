# frozen_string_literal: true

require_relative "helpers/rubocop_helpers"
require_relative "helpers/deprecated_components_helpers"

module ERBLint
  module Linters
    # Lints against deprecated components
    class DeprecatedComponentsCounter < Linter
      include ERBLint::LinterRegistry
      include Helpers::RubocopHelpers
      include Helpers::DeprecatedComponentsHelpers

      def run(processed_source)
        processed_source.ast.descendants(:erb).each do |erb_node|
          _, _, code_node = *erb_node
          code = code_node.children.first.strip
          node = erb_ast(code)

          next unless node
          next unless node.source.include?("Primer::")

          deprecated_components.each do |component|
            next unless node.source.include?(component)

            add_offense(
              erb_node.loc,
              message(component)
            )
          end
        end

        counter_correct?(processed_source)
      end

      def autocorrect(processed_source, offense)
        return unless offense.context

        lambda do |corrector|
          if processed_source.file_content.include?("erblint:counter #{self.class.name.gsub('ERBLint::Linters::', '')}")
            # update the counter if exists
            corrector.replace(offense.source_range, offense.context)
          else
            # add comment with counter if none
            corrector.insert_before(processed_source.source_buffer.source_range, "#{offense.context}\n")
          end
        end
      end

      private

      def counter_correct?(processed_source)
        comment_node = nil
        expected_count = 0
        rule_name = self.class.name.gsub("ERBLint::Linters::", "")
        offenses_count = @offenses.length
        processed_source.parser.ast.descendants(:erb).each do |node|
          indicator_node, _, code_node, = *node
          indicator = indicator_node&.loc&.source
          comment = code_node&.loc&.source&.strip
          if indicator == "#" && comment.start_with?("erblint:counter") && comment.match(rule_name)
            comment_node = node
            expected_count = comment.match(/\s(\d+)\s?$/)[1].to_i
          end
        end
        if offenses_count.zero?
          # have to adjust to get `\n` so we delete the whole line
          add_offense(processed_source.to_source_range(comment_node.loc.adjust(end_pos: 1)), "Unused erblint:counter comment for #{rule_name}", "") if comment_node
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
    end
  end
end
