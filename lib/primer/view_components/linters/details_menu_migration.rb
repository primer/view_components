# frozen_string_literal: true

require_relative "helpers/rule_helpers"
module ERBLint
  module Linters
    module Primer
      module Accessibility
        # Flag when `<details-menu>` is being used and offer alternatives.
        class DetailsMenuMigration < Linter
          include LinterRegistry
          include Helpers::RuleHelpers

          MIGRATE_FROM_DETAILS_MENU = "<details-menu> has been deprecated. Please instead use Primer::Alpha::ActionMenu" \
            " https://primer.style/design/components/action-menu/rails/alpha"
          DETAILS_MENU_RUBY_PATTERN = /tag:?\s+:"details-menu"/.freeze

          # Allow custom pattern matching for ERB nodes
          class ConfigSchema < LinterConfig
            property :custom_erb_pattern, accepts: array_of?(Regexp),
              default: -> { [] }
          end
          self.config_schema = ConfigSchema

          def run(processed_source)
            # HTML tags
            tags(processed_source).each do |tag|
              next if tag.closing?

              generate_offense(self.class, processed_source, tag, MIGRATE_FROM_DETAILS_MENU) if tag.name == "details-menu"
            end

            # ERB nodes
            erb_nodes(processed_source).each do |node|
              code = extract_ruby_from_erb_node(node)
              generate_node_offense(self.class, processed_source, node, MIGRATE_FROM_DETAILS_MENU) if (code.match?(DETAILS_MENU_RUBY_PATTERN) || code.match?(Regexp.new(@config.custom_erb_pattern.join("|"), true)))
            end
          end
        end
      end
    end
  end
end
