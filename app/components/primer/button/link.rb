# frozen_string_literal: true

module Primer
  module Button
    # Use Button::Link to create a button that looks like a link.
    class Link < Primer::Component
      # @example Default
      #   <%= render(Primer::Button::Link.new) { "Link" } %>
      #
      # @example Block
      #   <%= render(Primer::Button::Link.new(block: :true)) { "Block" } %>
      #
      # @param tag [Symbol] <%= one_of(Primer::Button::Base::TAG_OPTIONS) %>
      # @param type [Symbol] <%= one_of(Primer::Button::Base::TYPE_OPTIONS) %>
      # @param block [Boolean] Whether button is full-width with `display: block`.
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:variant] = :medium
        @system_arguments[:group_item] = false
        @system_arguments[:classes] = class_names(
          "btn-link",
          system_arguments[:classes]
        )
      end

      def call
        render(Primer::Button::Base.new(**@system_arguments)) { content }
      end
    end
  end
end
