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
      def split_button(size: :medium)
        render(Primer::Beta::ButtonGroup.new(size: size)) do |component|
          component.with_button { "Button 1" }
          component.with_button(icon: "triangle-down", "aria-label": "menu")
        end
      end

      # @label Icon buttons
      #
      # @param size [Symbol] select [medium, small]
      def icon_buttons(size: :medium)
        render(Primer::Beta::ButtonGroup.new(size: size)) do |component|
          component.with_button(icon: "triangle-down", "aria-label": "button 1")
          component.with_button(icon: "triangle-down", "aria-label": "button 2")
          component.with_button(icon: "triangle-down", "aria-label": "button 3")
        end
      end

      # @label Split button action menu
      def action_menus
        render_with_template(locals: {})
      end
    end
  end
end
