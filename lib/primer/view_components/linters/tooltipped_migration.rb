# frozen_string_literal: true

require_relative "helpers/rule_helpers"
module ERBLint
  module Linters
    module Primer
      module Accessibility
        # Flag when `.tooltipped` is being used and offer alternatives.
        class TooltippedMigration < Linter
          include LinterRegistry
          include Helpers::RuleHelpers

          MIGRATE_TO_NEWER_TOOLTIP = ".tooltipped has been deprecated. There are major accessibility concerns with using this tooltip so please take action. See https://primer.style/design/guides/development/rails/migration-guides/primer-css-tooltipped."
          TOOLTIPPED_RUBY_PATTERN = /classes:.*tooltipped|class:.*tooltipped/.freeze

          def run(processed_source)
            # HTML tags
            tags(processed_source).each do |tag|
              next if tag.closing?

              classes = tag.attributes["class"]&.value
              generate_offense(self.class, processed_source, tag, MIGRATE_TO_NEWER_TOOLTIP) if classes&.include?("tooltipped")
            end

            # ERB nodes
            erb_nodes(processed_source).each do |node|
              code = extract_ruby_from_erb_node(node)
              generate_node_offense(self.class, processed_source, node, MIGRATE_TO_NEWER_TOOLTIP) if code.match?(TOOLTIPPED_RUBY_PATTERN)
            end
          end
        end
      end
    end
  end
end
