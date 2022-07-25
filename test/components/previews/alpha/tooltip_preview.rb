# frozen_string_literal: true

module Alpha
  # @label Tooltip
  class TooltipPreview < ViewComponent::Preview
    # @param type [Symbol] select [["Description", description], ["Label", label]]
    # @param direction select [s, n, e, w, ne, nw, se, sw]
    # @param tooltip_text text
    def default(type: :description, direction: :s, tooltip_text: "Tooltip text")
      render(Primer::ButtonComponent.new(id: "button-with-tooltip")) do |c|
        c.tooltip(text: tooltip_text, type: type, direction: direction)
        "Button"
      end
    end

    # @!group Tooltip enabled elements
    def tooltip_with_button(type: :description, direction: :s, tooltip_text: "Tooltip text")
      render(Primer::ButtonComponent.new(id: "button-with-tooltip")) do |c|
        c.tooltip(text: tooltip_text, type: type, direction: direction)
        "Button"
      end
    end

    def tooltip_with_link(type: :description, direction: :s, tooltip_text: "Tooltip text")
      render(Primer::LinkComponent.new(href: "#link-with-tooltip", id: "link-with-tooltip")) do |c|
        c.tooltip(text: tooltip_text, type: type, direction: direction)
        "Button"
      end
    end
    # @!endgroup
  end
end
