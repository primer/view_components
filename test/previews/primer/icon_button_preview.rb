# frozen_string_literal: true

module Primer
  # @label IconButton
  class IconButtonPreview < ViewComponent::Preview
    # @label Default Options
    #
    # @param aria_label [String]
    # @param aria_description [String]
    # @param tooltip_direction [Symbol] select [s, n, e, w, ne, nw, se, sw]
    # @param scheme [Symbol] select [[Default, default], [Danger, danger]]
    def default(aria_label: "Button", aria_description: nil, tooltip_direction: Primer::Alpha::Tooltip::DIRECTION_DEFAULT, scheme: Primer::IconButton::DEFAULT_SCHEME)
      render(Primer::IconButton.new(icon: :search, "aria-label": aria_label, "aria-description": aria_description, tooltip_direction: tooltip_direction, scheme: scheme))
    end
  end
end
