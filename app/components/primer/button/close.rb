# frozen_string_literal: true

module Primer
  # Use Button::Close to render an `×` without default button styles.
  module Button
    class Close < Primer::Component
      DEFAULT_TYPE = :button
      TYPE_OPTIONS = [DEFAULT_TYPE, :submit].freeze

      # @example Default
      #   <%= render(Primer::Button::Close.new) %>
      #
      # @param type [Symbol] <%= one_of(Primer::Button::Close::TYPE_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(type: DEFAULT_TYPE, **system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = :button
        @system_arguments[:variant] = :medium
        @system_arguments[:group_item] = false
        @system_arguments[:block] = false
        @system_arguments[:type] = fetch_or_fallback(TYPE_OPTIONS, type, DEFAULT_TYPE)
        @system_arguments[:classes] = class_names(
          "close-button",
          system_arguments[:classes]
        )
      end

      def call
        render(Primer::Button::Base.new(**@system_arguments)) do
          render(Primer::OcticonComponent.new("x"))
        end
      end
    end
  end
end
