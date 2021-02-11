# frozen_string_literal: true

module Primer
  # Use buttons for actions (e.g. in forms). Use links for destinations, or moving from one page to another.
  class ButtonMarketingComponent < Primer::Component
    DEFAULT_BUTTON_TYPE = :default
    BUTTON_TYPE_MAPPINGS = {
      DEFAULT_BUTTON_TYPE => "",
      :primary => "btn-primary-mktg",
      :outline => "btn-outline-mktg",
      :transparent => "btn-transparent"
    }.freeze
    BUTTON_TYPE_OPTIONS = BUTTON_TYPE_MAPPINGS.keys

    DEFAULT_VARIANT = :default
    VARIANT_MAPPINGS = {
      DEFAULT_VARIANT => "",
      :large => "btn-large-mktg"
    }.freeze
    VARIANT_OPTIONS = VARIANT_MAPPINGS.keys

    DEFAULT_TAG = :button
    TAG_OPTIONS = [DEFAULT_TAG, :a].freeze

    DEFAULT_TYPE = :button
    TYPE_OPTIONS = [DEFAULT_TYPE, :submit].freeze

    # @example 110|Button types
    #   <%= render(Primer::ButtonMarketingComponent.new(mr: 2)) { "Default" } %>
    #   <%= render(Primer::ButtonMarketingComponent.new(button_type: :primary, mr: 2)) { "Primary" } %>
    #   <%= render(Primer::ButtonMarketingComponent.new(button_type: :outline)) { "Outline" } %>
    #   <div class="bg-gray-dark">
    #     <%= render(Primer::ButtonMarketingComponent.new(button_type: :transparent)) { "Transparent" } %>
    #   </div>
    #
    # @example 65|Sizes
    #   <%= render(Primer::ButtonMarketingComponent.new(mr: 2)) { "Default" } %>
    #   <%= render(Primer::ButtonMarketingComponent.new(variant: :large)) { "Large" } %>
    #
    # @param button_type [Symbol] <%= one_of(Primer::ButtonMarketingComponent::BUTTON_TYPE_OPTIONS) %>
    # @param variant [Symbol] <%= one_of(Primer::ButtonMarketingComponent::VARIANT_OPTIONS) %>
    # @param tag [Symbol] <%= one_of(Primer::ButtonMarketingComponent::TAG_OPTIONS) %>
    # @param type [Symbol] <%= one_of(Primer::ButtonMarketingComponent::TYPE_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(
      button_type: DEFAULT_BUTTON_TYPE,
      variant: DEFAULT_VARIANT,
      tag: DEFAULT_TAG,
      type: DEFAULT_TYPE,
      **system_arguments
    )
      @system_arguments = system_arguments
      @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)

      if @system_arguments[:tag] == :a
        @system_arguments[:role] = :button
      else
        @system_arguments[:type] = fetch_or_fallback(TYPE_OPTIONS, type, DEFAULT_TYPE)
      end

      @system_arguments[:classes] = class_names(
        "btn-mktg",
        BUTTON_TYPE_MAPPINGS[fetch_or_fallback(BUTTON_TYPE_OPTIONS, button_type, DEFAULT_BUTTON_TYPE)],
        VARIANT_MAPPINGS[fetch_or_fallback(VARIANT_OPTIONS, variant, DEFAULT_VARIANT)],
        system_arguments[:classes]
      )
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
