# frozen_string_literal: true

module Primer
  module Beta
    # Use `ButtonGroup` to render a series of buttons.
    class ButtonGroup < Primer::Component
      status :beta

      # Required list of buttons to be rendered.
      #
      # @param kwargs [Hash] The same arguments as <%= link_to_component(Primer::Beta::Button) %>
      renders_many :buttons, lambda { |**kwargs|
                               kwargs[:size] = @size
                               kwargs[:scheme] = @scheme

                               if kwargs[:icon]
                                 Primer::Beta::IconButton.new(**kwargs)
                               else
                                 Primer::Beta::Button.new(**kwargs)
                               end
                             }

      # @example Default
      #
      #   <%= render(Primer::Beta::ButtonGroup.new) do |component| %>
      #     <% component.with_button { "Button 1" } %>
      #     <% component.with_button { "Button 2" } %>
      #     <% component.with_button { "Button 3" } %>
      #   <% end %>
      #
      # @example Sizes
      #
      #   <%= render(Primer::Beta::ButtonGroup.new(size: :small)) do |component| %>
      #     <% component.with_button { "Button 1" } %>
      #     <% component.with_button { "Button 2" } %>
      #     <% component.with_button { "Button 3" } %>
      #   <% end %>
      #
      # @param scheme [Symbol] DEPRECATED. <%= one_of(Primer::Beta::Button::SCHEME_OPTIONS) %>
      # @param size [Symbol] <%= one_of(Primer::Beta::Button::SIZE_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(scheme: Primer::Beta::Button::DEFAULT_SCHEME, size: Primer::Beta::Button::DEFAULT_SIZE, **system_arguments)
        @size = size
        @scheme = scheme
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :div

        @system_arguments[:classes] = class_names(
          "ButtonGroup",
          system_arguments[:classes]
        )
      end

      def render?
        buttons.any?
      end
    end
  end
end
