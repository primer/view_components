# frozen_string_literal: true

module Primer
  # Use buttons for actions (e.g. in forms). Use links for destinations, or moving from one page to another.
  class ButtonMarketingComponent < Primer::Component
    DEFAULT_SCHEME = :default
    SCHEME_MAPPINGS = {
      DEFAULT_SCHEME => "",
      :primary => "btn-primary-mktg",
      :outline => "btn-outline-mktg",
      :transparent => "btn-transparent"
    }.freeze
    SCHEME_OPTIONS = SCHEME_MAPPINGS.keys

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

    # @example Schemes
    #   <%= render(Primer::ButtonMarketingComponent.new(mr: 2)) { "Default" } %>
    #   <%= render(Primer::ButtonMarketingComponent.new(scheme: :primary, mr: 2)) { "Primary" } %>
    #   <%= render(Primer::ButtonMarketingComponent.new(scheme: :outline)) { "Outline" } %>
    #   <div class="bg-gray-dark">
    #     <%= render(Primer::ButtonMarketingComponent.new(scheme: :transparent)) { "Transparent" } %>
    #   </div>
    #
    # @example Sizes
    #   <%= render(Primer::ButtonMarketingComponent.new(mr: 2)) { "Default" } %>
    #   <%= render(Primer::ButtonMarketingComponent.new(variant: :large)) { "Large" } %>
    #
    # @param scheme [Symbol] <%= one_of(Primer::ButtonMarketingComponent::SCHEME_OPTIONS) %>
    # @param variant [Symbol] <%= one_of(Primer::ButtonMarketingComponent::VARIANT_OPTIONS) %>
    # @param tag [Symbol] <%= one_of(Primer::ButtonMarketingComponent::TAG_OPTIONS) %>
    # @param type [Symbol] <%= one_of(Primer::ButtonMarketingComponent::TYPE_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(
      scheme: DEFAULT_SCHEME,
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
        SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)],
        VARIANT_MAPPINGS[fetch_or_fallback(VARIANT_OPTIONS, variant, DEFAULT_VARIANT)],
        system_arguments[:classes]
      )
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
