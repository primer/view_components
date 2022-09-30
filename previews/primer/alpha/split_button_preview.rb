# frozen_string_literal: true

module Primer
  module Alpha
    # @label SplitButton

    class SplitButtonPreview < ViewComponent::Preview
      # @label Default
      # @param scheme select [default, danger, invisible]
      # @param size select [small, medium, large]
      # @param disabled toggle
      def default(
        scheme: :default,
        size: :medium,
        disabled: false)
        render(Primer::Alpha::SplitButton.new(scheme: scheme)) do |c|
          c.button(disabled: disabled) { "Button" }
          c.icon_button(icon: :"triangle-down", "aria-label": "test")
        end
      end

      # @label Button with tooltip
      def button_with_tooltip
        render_with_template(locals: {})
      end
    end
  end
end
