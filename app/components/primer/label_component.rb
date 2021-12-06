# frozen_string_literal: true

module Primer
  # Use `Label` to add contextual metadata to a design.
  #
  # @accessibility
  #   Use `aria-label` if the `Label` or the context around it don't explain the label.
  class LabelComponent < Primer::Component
    status :beta

    DEFAULT_TAG = :span
    TAG_OPTIONS = [DEFAULT_TAG, :summary, :a, :div].freeze

    SCHEME_MAPPINGS = {
      primary: "Label--primary",
      secondary: "Label--secondary",
      info: "Label--info",
      success: "Label--success",
      warning: "Label--warning",
      danger: "Label--danger",
      # deprecated
      orange: "Label--orange",
      purple: "Label--purple"
    }.freeze
    DEPRECATED_SCHEME_OPTIONS = [:orange, :purple].freeze
    SCHEME_OPTIONS = ([*SCHEME_MAPPINGS.keys, nil] - DEPRECATED_SCHEME_OPTIONS).freeze

    SIZE_MAPPINGS = {
      medium: "",
      large: "Label--large"
    }.freeze
    SIZE_OPTIONS = SIZE_MAPPINGS.keys

    VARIANT_MAPPINGS = {
      inline: "Label--inline"
    }.freeze
    VARIANT_OPTIONS = VARIANT_MAPPINGS.keys << nil

    # @example Schemes
    #   <%= render(Primer::LabelComponent.new) { "Default" } %>
    #   <%= render(Primer::LabelComponent.new(scheme: :primary)) { "Primary" } %>
    #   <%= render(Primer::LabelComponent.new(scheme: :secondary)) { "Secondary" } %>
    #   <%= render(Primer::LabelComponent.new(scheme: :info)) { "Info" } %>
    #   <%= render(Primer::LabelComponent.new(scheme: :success)) { "Success" } %>
    #   <%= render(Primer::LabelComponent.new(scheme: :warning)) { "Warning" } %>
    #   <%= render(Primer::LabelComponent.new(scheme: :danger)) { "Danger" } %>
    #
    # @example Sizes
    #   <%= render(Primer::LabelComponent.new) { "Medium" } %>
    #   <%= render(Primer::LabelComponent.new(size: :large)) { "Large" } %>
    #
    # @example Variants
    #   <%= render(Primer::LabelComponent.new) { "Default" } %>
    #   <%= render(Primer::LabelComponent.new(variant: :inline)) { "Inline" } %>
    #
    # @param tag [Symbol] <%= one_of(Primer::LabelComponent::TAG_OPTIONS) %>
    # @param scheme [Symbol] <%= one_of(Primer::LabelComponent::SCHEME_MAPPINGS.keys) %>
    # @param size [Symbol] <%= one_of(Primer::LabelComponent::SIZE_OPTIONS) %>
    # @param variant [Symbol] <%= one_of(Primer::LabelComponent::VARIANT_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(tag: DEFAULT_TAG, scheme: nil, size: :medium, variant: nil, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)
      @system_arguments[:classes] = class_names(
        "Label",
        system_arguments[:classes],
        SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_OPTIONS, scheme, deprecated_values: DEPRECATED_SCHEME_OPTIONS)],
        SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size)],
        VARIANT_MAPPINGS[fetch_or_fallback(VARIANT_OPTIONS, variant)]
      )
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
