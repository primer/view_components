# frozen_string_literal: true

module Primer
  # Use `ButtonGroup` to render a series of buttons.
  class ButtonGroup < Primer::Component
    status :beta

    # Required list of buttons to be rendered.
    #
    # @param kwargs [Hash] The same arguments as <%= link_to_component(Primer::ButtonComponent) %> except for `size` and `group_item`.
    renders_many :buttons, lambda { |**kwargs|
      kwargs[:group_item] = true
      kwargs[:size] = @size

      Primer::ButtonComponent.new(**kwargs)
    }

    # @example Default
    #
    #   <%= render(Primer::ButtonGroup.new) do |component| %>
    #     <% component.button { "Default" } %>
    #     <% component.button(scheme: :primary) { "Primary" } %>
    #     <% component.button(scheme: :danger) { "Danger" } %>
    #     <% component.button(scheme: :outline) { "Outline" } %>
    #     <% component.button(classes: "custom-class") { "Custom class" } %>
    #   <% end %>
    #
    # @example Sizes
    #
    #   <%= render(Primer::ButtonGroup.new(size: :small)) do |component| %>
    #     <% component.button { "Default" } %>
    #     <% component.button(scheme: :primary) { "Primary" } %>
    #     <% component.button(scheme: :danger) { "Danger" } %>
    #     <% component.button(scheme: :outline) { "Outline" } %>
    #   <% end %>
    #
    # @param variant [Symbol] DEPRECATED. <%= one_of(Primer::ButtonComponent::SIZE_OPTIONS) %>
    # @param size [Symbol] <%= one_of(Primer::ButtonComponent::SIZE_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(variant: nil, size: Primer::ButtonComponent::DEFAULT_SIZE, **system_arguments)
      @size = variant || size
      @system_arguments = deny_tag_argument(**system_arguments)
      @system_arguments[:tag] = :div

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
