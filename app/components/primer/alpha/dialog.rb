# frozen_string_literal: true

module Primer
  module Alpha
    # Use `Dialog` for an overlayed dialog window.
    class Dialog < Primer::Component
      # Optional list of buttons to be rendered.
      #
      # @param kwargs [Hash] The same arguments as <%= link_to_component(Primer::ButtonComponent) %> except for `size` and `group_item`.
      renders_many :buttons, lambda { |**system_arguments|
        Primer::ButtonComponent.new(**system_arguments)
      }

      # @example Default
      #   <%= render(Alpha::Primer::Dialog.new) { "Your content here" } %>
      #
      # @example Color and padding
      #   <%= render(Primer::BoxComponent.new(bg: :subtle, p: 3)) { "Hello world" } %>
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(title:, description:, **system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)

        @system_arguments[:tag] = :div
        @system_arguments[:role] = :dialog
        @title = title
        @description = description
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) { content }
      end
    end
  end
end
