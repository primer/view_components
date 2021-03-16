# frozen_string_literal: true

module Primer
  # Use ButtonGroupComponent to render a series of buttons.
  class ButtonGroupComponent < Primer::Component
    include ViewComponent::SlotableV2

    # Required list of buttons to be rendered.
    #
    # @param type [Sybol] <%= one_of(Primer::ButtonComponent::TYPES) %>
    # @param kwargs [Hash] The same arguments as <%= link_to_component(Primer::ButtonComponent) %>.
    renders_many :buttons, lambda { |type: :default, **kwargs|
      button_type = fetch_or_fallback(Primer::ButtonComponent::TYPES, type, :default)

      button_class = if button_type == :default
                       Primer::ButtonComponent
                     else
                       "Primer::Button#{button_type.to_s.capitalize}Component".constantize
                     end

      button_class.new(group_item: true, **kwargs)
    }

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
