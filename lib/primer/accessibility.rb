# frozen_string_literal: true

# :nocov:
module Primer
  module Accessibility
    # Skip axe checks for components that should be tested as part of a larger component.
    # Do not add to this list for any other reason!
    IGNORED_PREVIEWS = %w[
      Primer::Beta::MarkdownPreview
      Primer::Beta::AutoCompleteItemPreview
    ].freeze

    # Skip `:region` which relates to preview page structure rather than individual component.
    # Skip `:color-contrast` which requires primer design-level change.
    # Skip `:link-in-text-block` which is new and seems broken.
    AXE_RULES_TO_SKIP = %i[
      region
      color-contrast
      color-contrast-enhanced
      link-in-text-block
    ].freeze

    AXE_RULES_TO_SKIP_PER_COMPONENT = {
      # these previews test only the component, which does not come with any labels
      Primer::Alpha::ToggleSwitch => {
        all: %i[button-name]
      }
    }.freeze

    class << self
      def axe_rules_to_skip(component: nil, preview_name: nil)
        to_skip = Set.new(AXE_RULES_TO_SKIP)

        if component
          to_skip.merge(AXE_RULES_TO_SKIP_PER_COMPONENT.dig(component, :all) || [])

          # rubocop:disable Style/IfUnlessModifier
          if preview_name
            to_skip.merge(AXE_RULES_TO_SKIP_PER_COMPONENT.dig(component, preview_name) || [])
          end
          # rubocop:enable Style/IfUnlessModifier
        end

        to_skip.to_a
      end
    end
  end
end
# :nocov:
