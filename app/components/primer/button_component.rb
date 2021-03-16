# frozen_string_literal: true

module Primer
  # Use buttons for actions (e.g. in forms). Use links for destinations, or moving from one page to another.
  class ButtonComponent < Primer::Component
    BUTTON_TYPE_CLASS = ""
    TYPES = [:default, :block, :danger, :invisible, :outline, :primary].freeze

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

    # @example Button types
    #   <%= render(Primer::ButtonComponent.new) { "Default" } %>
    #   <%= render(Primer::ButtonPrimaryComponent.new) { "Primary" } %>
    #   <%= render(Primer::ButtonDangerComponent.new) { "Danger" } %>
    #   <%= render(Primer::ButtonOutlineComponent.new) { "Outline" } %>
    #   <%= render(Primer::ButtonInvisibleComponent.new) { "Invisible" } %>
    #   <%= render(Primer::ButtonBlockComponent.new) { "Block" } %>
    #
    # @example Variants
    #   <%= render(Primer::ButtonComponent.new(variant: :small)) { "Small" } %>
    #   <%= render(Primer::ButtonComponent.new(variant: :medium)) { "Medium" } %>
    #   <%= render(Primer::ButtonComponent.new(variant: :large)) { "Large" } %>
    #
    # @param variant [Symbol] <%= one_of(Primer::ButtonComponent::VARIANT_OPTIONS) %>
    # @param tag [Symbol] <%= one_of(Primer::ButtonComponent::TAG_OPTIONS) %>
    # @param type [Symbol] <%= one_of(Primer::ButtonComponent::TYPE_OPTIONS) %>
    # @param group_item [Boolean] Whether button is part of a ButtonGroup.
    def initialize(
      variant: DEFAULT_VARIANT,
      tag: DEFAULT_TAG,
      type: DEFAULT_TYPE,
      group_item: false,
      **system_arguments
    )
      @system_arguments = system_arguments
      @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)

      if @system_arguments[:tag] == :a
        @system_arguments[:role] = :button
      else
        @system_arguments[:type] = type
      end

      @system_arguments[:classes] = class_names(
        "btn",
        self.class::BUTTON_TYPE_CLASS,
        system_arguments[:classes],
        VARIANT_MAPPINGS[fetch_or_fallback(VARIANT_OPTIONS, variant, DEFAULT_VARIANT)],
        "BtnGroup-item" => group_item
      )
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
