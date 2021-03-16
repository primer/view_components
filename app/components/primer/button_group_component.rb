# frozen_string_literal: true

module Primer
  # Use ButtonGroupComponent to render a series of buttons.
  class ButtonGroupComponent < Primer::Component
    include ViewComponent::SlotableV2

    # Required list of buttons to be rendered.
    #
    # @param button_type [Symbol] <%= one_of(Primer::ButtonMapper::TYPES.keys) %>
    # @param kwargs [Hash] The same arguments as <%= link_to_component(Primer::ButtonComponent) %>.
    renders_many :buttons, ->(button_type: :default, **kwargs) { Primer::ButtonMapper.button_class(button_type).new(group_item: true, **kwargs) }

    # @example Default
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
        system_arguments[:classes]
      )
    end

    def render?
      buttons.any?
    end
  end
end
