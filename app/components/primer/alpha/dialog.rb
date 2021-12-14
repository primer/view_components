# frozen_string_literal: true

module Primer
  module Alpha
    # Use `Dialog` for an overlayed dialog window.
    class Dialog < Primer::Component
      # @example Default
      #   <%= render(Alpha::Primer::Dialog.new) { "Your content here" } %>
      #
      # @example Color and padding
      #   <%= render(Primer::BoxComponent.new(bg: :subtle, p: 3)) { "Hello world" } %>
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = deny_tag_argument(title:, description:, **system_arguments)

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
