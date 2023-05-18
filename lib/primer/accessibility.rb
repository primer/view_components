# frozen_string_literal: true

# :nocov:
module Primer
  # :nodoc:
  module Accessibility
    # Skip axe checks for components that should be tested as part of a larger component.
    # Do not add to this list for any other reason!
    IGNORED_PREVIEWS = [
      Primer::Beta::MarkdownPreview,
      Primer::Beta::AutoCompleteItemPreview
    ].freeze

    # Skip `:region` which relates to preview page structure rather than individual component.
    # Skip `:color-contrast` which requires primer design-level change.
    AXE_RULES_TO_SKIP = %i[
      region
      color-contrast
    ].freeze

    AXE_RULES_TO_SKIP_PER_COMPONENT = {
      # these previews test only the component, which does not come with any labels
      Primer::Alpha::ToggleSwitch => {
        __all__: %i[button-name]
      }
    }.freeze

    class << self
      def ignore_preview?(preview_class)
        preview_class.name.start_with?("Docs::") || IGNORED_PREVIEWS.include?(preview_class)
      end

      def axe_rules_to_skip(component: nil, scenario_name: nil)
        to_skip = Set.new(AXE_RULES_TO_SKIP)

        if component
          to_skip.merge(AXE_RULES_TO_SKIP_PER_COMPONENT.dig(component, :__all__) || [])

          # rubocop:disable Style/IfUnlessModifier
          if scenario_name
            to_skip.merge(AXE_RULES_TO_SKIP_PER_COMPONENT.dig(component, scenario_name) || [])
          end
          # rubocop:enable Style/IfUnlessModifier
        end

        to_skip.to_a
      end
    end
  end
end
# :nocov:
