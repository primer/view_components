# frozen_string_literal: true

module Primer
  module Beta
    # Use `BaseButton` to render an unstyled `<button>` tag that can be customized.
    class BaseButton < Primer::Component
      status :beta

      DEFAULT_TAG = :button
      TAG_OPTIONS = [DEFAULT_TAG, :a, :summary, :"clipboard-copy"].freeze

      DEFAULT_TYPE = :button
      TYPE_OPTIONS = [DEFAULT_TYPE, :reset, :submit].freeze

      attr_reader :disabled
      alias disabled? disabled

      # @param tag [Symbol] <%= one_of(Primer::Beta::BaseButton::TAG_OPTIONS) %>
      # @param type [Symbol] <%= one_of(Primer::Beta::BaseButton::TYPE_OPTIONS) %>
      # @param block [Boolean] Whether button is full-width with `display: block`.
      # @param disabled [Boolean] Whether or not the button is disabled. If true, this option forces `tag:` to `:button`.
      # @param inactive [Boolean] Whether the button looks visually disabled, but can still accept all the same interactions as an enabled button.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        tag: DEFAULT_TAG,
        type: DEFAULT_TYPE,
        block: false,
        disabled: false,
        inactive: false,
        **system_arguments
      )
        @system_arguments = system_arguments
        @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)

        @system_arguments[:type] = fetch_or_fallback(TYPE_OPTIONS, type, DEFAULT_TYPE) if @system_arguments[:tag] == :button

        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "btn-block" => block
        )

        @system_arguments[:"aria-disabled"] = true if inactive

        @disabled = disabled
        return unless @disabled

        @system_arguments[:tag] = :button
        @system_arguments[:disabled] = ""
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) { content }
      end
    end
  end
end
