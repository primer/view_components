# frozen_string_literal: true

module Primer
  module Button
    # Use Button::Base to render an unstyles `<button>` tag that can be customized.
    class Base < Primer::Component
      status :beta

      DEFAULT_TAG = :button
      TAG_OPTIONS = [DEFAULT_TAG, :a, :summary].freeze

      DEFAULT_TYPE = :button
      TYPE_OPTIONS = [DEFAULT_TYPE, :reset, :submit].freeze

      # @example Block
      #   <%= render(Primer::Button::Base.new(block: :true)) { "Block" } %>
      #   <%= render(Primer::Button::Base.new(block: :true, scheme: :primary)) { "Primary block" } %>
      #
      # @param tag [Symbol] <%= one_of(Primer::Button::Base::TAG_OPTIONS) %>
      # @param type [Symbol] <%= one_of(Primer::Button::Base::TYPE_OPTIONS) %>
      # @param block [Boolean] Whether button is full-width with `display: block`.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        tag: DEFAULT_TAG,
        type: DEFAULT_TYPE,
        group_item: false,
        block: false,
        **system_arguments
      )
        @system_arguments = system_arguments
        @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)

        if @system_arguments[:tag] == :button
          @system_arguments[:type] = fetch_or_fallback(TYPE_OPTIONS, type, DEFAULT_TYPE)
        else
          @system_arguments[:role] = :button
        end

        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "btn-block" => block,
        )
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) { content }
      end
    end
  end
end
