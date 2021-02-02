# frozen_string_literal: true

module Primer
  # Use ButtonGroupComponent to wrap a series of buttons.
  # They will be rounded and spaced automatically
  class ButtonGroupComponent < Primer::Component

    include ViewComponent::SlotableV2

    renders_many :buttons, ->(classes: "", **kwargs) do
      btn_classes = class_names("BtnGroup-item", classes)
      Primer::ButtonComponent.new(classes: btn_classes, **kwargs)
    end

    # @example 50|Default
    #   <%= render(Primer::ButtonGroupComponent.new) do |component|
    #     component.button { "Default" }
    #     component.button(button_type: :primary) { "Primary" }
    #     component.button(button_type: :danger) { "Danger" }
    #     component.button(button_type: :outline) { "Outline" }
    #     component.button(classes: "my-class") { "Custom class" }
    #   end %>
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] ||= :div

      @system_arguments[:classes] = class_names(
        "BtnGroup",
        system_arguments[:classes],
      )
    end
  end
end
