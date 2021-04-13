# frozen_string_literal: true

module Primer
  # Use buttons for actions (e.g. in forms). Use links for destinations, or moving from one page to another.
  module Button
    class Base < Primer::Component
      status :beta

      DEFAULT_VARIANT = :medium
      VARIANT_MAPPINGS = {
        :small => "btn-sm",
        DEFAULT_VARIANT => "",
        :large => "btn-large"
      }.freeze
      VARIANT_OPTIONS = VARIANT_MAPPINGS.keys

      DEFAULT_TAG = :button
      TAG_OPTIONS = [DEFAULT_TAG, :a, :summary].freeze

      DEFAULT_TYPE = :button
      TYPE_OPTIONS = [DEFAULT_TYPE, :reset, :submit].freeze

      # @example Variants
      #   <%= render(Primer::Button::Base.new(variant: :small)) { "Small" } %>
      #   <%= render(Primer::Button::Base.new(variant: :medium)) { "Medium" } %>
      #   <%= render(Primer::Button::Base.new(variant: :large)) { "Large" } %>
      #
      # @example Block
      #   <%= render(Primer::Button::Base.new(block: :true)) { "Block" } %>
      #   <%= render(Primer::Button::Base.new(block: :true, scheme: :primary)) { "Primary block" } %>
      #
      # @param variant [Symbol] <%= one_of(Primer::Button::Base::VARIANT_OPTIONS) %>
      # @param tag [Symbol] <%= one_of(Primer::Button::Base::TAG_OPTIONS) %>
      # @param type [Symbol] <%= one_of(Primer::Button::Base::TYPE_OPTIONS) %>
      # @param group_item [Boolean] Whether button is part of a ButtonGroup.
      # @param block [Boolean] Whether button is full-width with `display: block`.
      def initialize(
        variant: DEFAULT_VARIANT,
        tag: DEFAULT_TAG,
        type: DEFAULT_TYPE,
        group_item: false,
        block: false,
        **system_arguments
      )
        @system_arguments = system_arguments
        @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)

        if @system_arguments[:tag] == :button
          @system_arguments[:type] = type
        else
          @system_arguments[:role] = :button
        end

        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          VARIANT_MAPPINGS[fetch_or_fallback(VARIANT_OPTIONS, variant, DEFAULT_VARIANT)],
          "btn-block" => block,
          "BtnGroup-item" => group_item
        )
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) { content }
      end
    end
  end
end
