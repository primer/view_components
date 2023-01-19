# frozen_string_literal: true

module Primer
  module Beta
    # Use `ButtonGroup` to render a series of buttons.
    class ButtonGroup < Primer::Component
      status :beta

      # Required list of buttons to be rendered.
      #
      # @param kwargs [Hash] The same arguments as <%= link_to_component(Primer::ButtonComponent) %> except for `size` and `group_item`.
      renders_many :buttons, lambda { |**kwargs|
        kwargs[:group_item] = true
        kwargs[:size] = @size

        # rubocop:disable Primer/ComponentNameMigration
        Primer::ButtonComponent.new(**kwargs)
        # rubocop:enable Primer/ComponentNameMigration
      }

      # @example Default
      #
      #   <%= render(Primer::Beta::ButtonGroup.new) do |component| %>
      #     <% component.with_button { "Default" } %>
      #     <% component.with_button(scheme: :primary) { "Primary" } %>
      #     <% component.with_button(scheme: :danger) { "Danger" } %>
      #     <% component.with_button(scheme: :outline) { "Outline" } %>
      #     <% component.with_button(classes: "custom-class") { "Custom class" } %>
      #   <% end %>
      #
      # @example Sizes
      #
      #   <%= render(Primer::Beta::ButtonGroup.new(size: :small)) do |component| %>
      #     <% component.with_button { "Default" } %>
      #     <% component.with_button(scheme: :primary) { "Primary" } %>
      #     <% component.with_button(scheme: :danger) { "Danger" } %>
      #     <% component.with_button(scheme: :outline) { "Outline" } %>
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
end
