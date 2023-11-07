# frozen_string_literal: true

module Primer
  module Beta
    # @label ButtonGroup
    class ButtonGroupPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param size [Symbol] select [small, medium, large]
      # @param scheme [Symbol] select [default, primary, secondary, danger, invisible]
      def playground(size: :medium, scheme: :default)
        render(Primer::Beta::ButtonGroup.new(size: size, scheme: scheme)) do |component|
          component.with_button { "Button 1" }
          component.with_button { "Button 2" }
          component.with_button { "Button 3" }
        end
      end

      # @label Default options
      #
      # @param size [Symbol] select [medium, small]
      # @snapshot
      def default(size: :medium)
        render(Primer::Beta::ButtonGroup.new(size: size)) do |component|
          component.with_button { "Button 1" }
          component.with_button { "Button 2" }
          component.with_button { "Button 3" }
        end
      end

      # @label Split button
      #
      # @param size [Symbol] select [medium, small]
      # @snapshot
      def split_button(size: :medium)
        render(Primer::Beta::ButtonGroup.new(size: size)) do |component|
          component.with_button { "Button 1" }
          component.with_button(icon: "triangle-down", "aria-label": "menu")
        end
      end

      # @label Icon buttons
      #
      # @param size [Symbol] select [medium, small]
      # @snapshot
      def icon_buttons(size: :medium)
        render(Primer::Beta::ButtonGroup.new(size: size)) do |component|
          component.with_button(icon: :note, "aria-label": "button 1")
          component.with_button(icon: :rows, "aria-label": "button 2")
          component.with_button(icon: "sort-desc", "aria-label": "button 3")
        end
      end

      # @label Button group with all tags
      # @snapshot
      def all_tags
        render(Primer::Beta::ButtonGroup.new) do |component|
          component.with_button(id: "button-1", tag: :button) do |button|
            button.with_tooltip(text: "Button Tooltip")
            "Button 1"
          end
          component.with_button(id: "button-2", tag: :a) do |button|
            button.with_tooltip(text: "Button Tooltip")
            "Button 2"
          end
          component.with_button(id: "button-3", tag: :summary) do |button|
            button.with_tooltip(text: "Button Tooltip")
            "Button 3"
          end
        end
      end

      # @label With clipboard copy button
      # @snapshot
      def with_clipboard_copy_button(size: :medium, scheme: :default)
        render(Primer::Beta::ButtonGroup.new(size: size, scheme: scheme)) do |component|
          component.with_button { "Button 1" }
          component.with_clipboard_copy_button(id: "button-2", value: "Copyable value", aria: { label: "Copy some text" }) do |button|
            button.with_tooltip(text: "Copy some text")
          end
        end
      end
    end
  end
end
