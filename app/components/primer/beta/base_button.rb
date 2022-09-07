# frozen_string_literal: true

module Primer
  module Beta
    # Use `BaseButton` to render an unstyled `<button>` tag that can be customized.
    class BaseButton < Primer::Component
      status :beta

      DEFAULT_TAG = :button
      TAG_OPTIONS = [DEFAULT_TAG, :a, :summary].freeze

      DEFAULT_TYPE = :button
      TYPE_OPTIONS = [DEFAULT_TYPE, :reset, :submit].freeze

      # @example Block
      #   <%= render(Primer::Beta::BaseButton.new(block: :true)) { "Block" } %>
      #   <%= render(Primer::Beta::BaseButton.new(block: :true, scheme: :primary)) { "Primary block" } %>
      #
      # @param tag [Symbol] <%= one_of(Primer::Beta::BaseButton::TAG_OPTIONS) %>
      # @param type [Symbol] <%= one_of(Primer::Beta::BaseButton::TYPE_OPTIONS) %>
      # @param block [Boolean] Whether button is full-width with `display: block`.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        tag: DEFAULT_TAG,
        type: DEFAULT_TYPE,
        block: false,
        **system_arguments
      )
        @system_arguments = system_arguments
        @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)

        @system_arguments[:type] = fetch_or_fallback(TYPE_OPTIONS, type, DEFAULT_TYPE) if @system_arguments[:tag] == :button

        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "btn-block" => block
        )
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) { content }
      end
    end
  end
end
