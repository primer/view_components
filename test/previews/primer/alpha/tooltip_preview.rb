# frozen_string_literal: true

module Primer
  module Alpha
    # @label Tooltip
    class TooltipPreview < ViewComponent::Preview
      # @param type [Symbol] select [["Description", description], ["Label", label]]
      # @param direction select [s, n, e, w, ne, nw, se, sw]
      # @param tooltip_text text
      def default(type: :description, direction: :s, tooltip_text: "Tooltip text")
        render(Primer::Beta::Button.new(id: "button-with-tooltip")) do |c|
          c.tooltip(text: tooltip_text, type: type, direction: direction)
          "Button"
        end
      end

      # @!group Tooltip enabled elements
      # @label Tooltip with Primer::Beta::Button
      def tooltip_with_button(type: :description, direction: :s, tooltip_text: "Tooltip text")
        render(Primer::Beta::Button.new(id: "button-with-tooltip")) do |c|
          c.tooltip(text: tooltip_text, type: type, direction: direction)
          "Button"
        end
      end

      # @label Tooltip with Primer::LinkComponent
      def tooltip_with_link(type: :description, direction: :s, tooltip_text: "Tooltip text")
        render(Primer::LinkComponent.new(href: "#link-with-tooltip", id: "link-with-tooltip")) do |c|
          c.tooltip(text: tooltip_text, type: type, direction: direction)
          "Button"
        end
      end

      # @label Tooltip with Primer::IconButton
      def tooltip_with_icon_button(direction: :s, tooltip_text: "Tooltip text")
        render(Primer::IconButton.new(icon: :search, "aria-label": tooltip_text, tooltip_direction: direction))
      end
      # @!endgroup
    end
  end
end
