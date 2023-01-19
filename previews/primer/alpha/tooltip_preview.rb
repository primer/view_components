# frozen_string_literal: true

module Primer
  module Alpha
    # @label Tooltip
    class TooltipPreview < ViewComponent::Preview
      # @param type [Symbol] select [["Description", description], ["Label", label]]
      # @param direction select [s, n, e, w, ne, nw, se, sw]
      # @param tooltip_text text
      def playground(type: :description, direction: :s, tooltip_text: "You can press a button")
        render(Primer::Beta::Button.new(id: "button-with-tooltip")) do |component|
          component.with_tooltip(text: tooltip_text, type: type, direction: direction)
          "Button"
        end
      end

      # @param type [Symbol] select [["Description", description], ["Label", label]]
      # @param direction select [s, n, e, w, ne, nw, se, sw]
      # @param tooltip_text text
      def default(type: :description, direction: :s, tooltip_text: "You can press a button")
        render(Primer::Beta::Button.new(id: "button-with-tooltip")) do |component|
          component.with_tooltip(text: tooltip_text, type: type, direction: direction)
          "Button"
        end
      end

      # @param direction select [s, n, e, w, ne, nw, se, sw]
      # @param tooltip_text text
      def label_tooltip_on_button_with_existing_labelledby(type: :label, direction: :s, tooltip_text: "You can press a button")
        render(Primer::Beta::Button.new(id: "button-with-existing-label", "aria-labelledby": "existing-label-id")) do |component|
          component.with_tooltip(text: tooltip_text, type: type, direction: direction)
          "Button"
        end
      end

      # @param direction select [s, n, e, w, ne, nw, se, sw]
      # @param tooltip_text text
      def description_tooltip_on_button_with_existing_describedby(type: :description, direction: :s, tooltip_text: "You can press a button")
        render(Primer::Beta::Button.new(id: "button-with-existing-description", "aria-describedby": "existing-description-id")) do |component|
          component.with_tooltip(text: tooltip_text, type: type, direction: direction)
          "Button"
        end
      end

      # @param direction select [s, n, e, w, ne, nw, se, sw]
      # @param tooltip_text text
      def with_right_most_position(type: :description, direction: :s, tooltip_text: "A tooltip with very very very very long description that is not very concise...")
        render_with_template(
          locals: {
            type: type,
            direction: direction,
            tooltip_text: tooltip_text
          }
        )
      end

      # @param direction select [s, n, e, w, ne, nw, se, sw]
      # @param tooltip_text text
      def with_multiple_on_a_page(type: :description, direction: :s, tooltip_text: "You can press a button")
        render_with_template(
          locals: {
            type: type,
            direction: direction,
            tooltip_text: tooltip_text
          }
        )
      end

      # @!group Tooltip enabled elements
      # @label Tooltip with Primer::Beta::Button
      def tooltip_with_button(type: :description, direction: :s, tooltip_text: "You can press a button")
        render(Primer::Beta::Button.new(id: "button-with-tooltip")) do |component|
          component.with_tooltip(text: tooltip_text, type: type, direction: direction)
          "Button"
        end
      end

      # @label Tooltip with Primer::Beta::Link
      def tooltip_with_link(type: :description, direction: :s, tooltip_text: "You can press a button")
        render(Primer::Beta::Link.new(href: "#link-with-tooltip", id: "link-with-tooltip")) do |component|
          component.with_tooltip(text: tooltip_text, type: type, direction: direction)
          "Button"
        end
      end

      # @label Tooltip with Primer::IconButton
      def tooltip_with_icon_button(direction: :s, tooltip_text: "You can press a button")
        render(Primer::Beta::IconButton.new(icon: :search, "aria-label": tooltip_text, tooltip_direction: direction))
      end
      # @!endgroup
    end
  end
end
