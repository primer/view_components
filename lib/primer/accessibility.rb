# frozen_string_literal: true

# :nocov:
module Primer
  # :nodoc:
  module Accessibility
    # Skip axe checks for components that should be tested as part of a larger component.
    # Do not add to this list for any other reason!
    IGNORED_PREVIEWS = [
      Primer::Beta::MarkdownPreview,
      Primer::Beta::AutoCompleteItemPreview,
      Primer::Alpha::RadioButtonPreview,
      Primer::Alpha::CheckBoxPreview
    ].freeze

    # Skip `:region` which relates to preview page structure rather than individual component.
    # Skip `:color-contrast` which requires primer design-level change.
    AXE_RULES_TO_SKIP = {
      # these will be skipped in CI but will still be tracked in Datadog
      will_fix: {
        global: %i[
          color-contrast
        ],

        per_component: {}
      },

      # these will always be skipped
      wont_fix: {
        global: %i[
          region
        ],

        per_component: {
          Primer::Alpha::ToggleSwitch => {
            all_scenarios: %i[button-name]
          }
        }
      }
    }.freeze

    class << self
      def ignore_preview?(preview_class)
        IGNORED_PREVIEWS.include?(preview_class)
      end

      def axe_rules_to_skip(component: nil, scenario_name: nil, flatten: false)
        to_skip = {
          wont_fix: Set.new(AXE_RULES_TO_SKIP.dig(:wont_fix, :global) || []),
          will_fix: Set.new(AXE_RULES_TO_SKIP.dig(:will_fix, :global) || [])
        }

        if component
          to_skip[:wont_fix].merge(AXE_RULES_TO_SKIP.dig(:wont_fix, :per_component, component, :all_scenarios) || [])
          to_skip[:will_fix].merge(AXE_RULES_TO_SKIP.dig(:will_fix, :per_component, component, :all_scenarios) || [])

          if scenario_name
            to_skip[:wont_fix].merge(AXE_RULES_TO_SKIP.dig(:wont_fix, :per_component, component, scenario_name) || [])
            to_skip[:will_fix].merge(AXE_RULES_TO_SKIP.dig(:will_fix, :per_component, component, scenario_name) || [])
          end
        end

        if flatten
          flattened = to_skip.each_with_object(Set.new) do |(_, rule_set), memo|
            memo.merge(rule_set)
          end

          return flattened.to_a
        end

        to_skip.transform_values(&:to_a)
      end
    end
  end
end
# :nocov:
