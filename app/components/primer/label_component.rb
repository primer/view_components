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

    DEFAULT_SCHEME = :default
    SCHEME_MAPPINGS = {
      DEFAULT_SCHEME => "",
      :primary => "Label--primary",
      :secondary => "Label--secondary",
      :accent => "Label--accent",
      :success => "Label--success",
      :attention => "Label--attention",
      :danger => "Label--danger",
      :severe => "Label--severe",
      :done => "Label--done",
      :sponsors => "Label--sponsors",
      # deprecated
      :info => "Label--info",
      :warning => "Label--warning",
      :orange => "Label--orange",
      :purple => "Label--purple"
    }.freeze
    DEPRECATED_SCHEME_OPTIONS = [:info, :warning, :orange, :purple].freeze
    SCHEME_OPTIONS = (SCHEME_MAPPINGS.keys - DEPRECATED_SCHEME_OPTIONS).freeze

    VARIANT_MAPPINGS = {
      large: "Label--large",
      inline: "Label--inline"
    }.freeze
    VARIANT_OPTIONS = VARIANT_MAPPINGS.keys << nil

    # @example Schemes
    #   <%= render(Primer::LabelComponent.new) { "Default" } %>
    #   <%= render(Primer::LabelComponent.new(scheme: :primary)) { "Primary" } %>
    #   <%= render(Primer::LabelComponent.new(scheme: :secondary)) { "Secondary" } %>
    #   <%= render(Primer::LabelComponent.new(scheme: :accent)) { "Accent" } %>
    #   <%= render(Primer::LabelComponent.new(scheme: :success)) { "Success" } %>
    #   <%= render(Primer::LabelComponent.new(scheme: :attention)) { "Attention" } %>
    #   <%= render(Primer::LabelComponent.new(scheme: :danger)) { "Danger" } %>
    #   <%= render(Primer::LabelComponent.new(scheme: :severe)) { "Severe" } %>
    #   <%= render(Primer::LabelComponent.new(scheme: :done)) { "Done" } %>
    #   <%= render(Primer::LabelComponent.new(scheme: :sponsors)) { "Sponsors" } %>
    #
    # @example Variants
    #   <%= render(Primer::LabelComponent.new) { "Default" } %>
    #   <%= render(Primer::LabelComponent.new(variant: :large)) { "Large" } %>
    #
    # @param tag [Symbol] <%= one_of(Primer::LabelComponent::TAG_OPTIONS) %>
    # @param scheme [Symbol] <%= one_of(Primer::LabelComponent::SCHEME_MAPPINGS.keys) %>
    # @param variant [Symbol] <%= one_of(Primer::LabelComponent::VARIANT_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(tag: DEFAULT_TAG, scheme: DEFAULT_SCHEME, variant: nil, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)
      @system_arguments[:classes] = class_names(
        "Label",
        system_arguments[:classes],
        SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_OPTIONS, scheme, deprecated_values: DEPRECATED_SCHEME_OPTIONS)],
        VARIANT_MAPPINGS[fetch_or_fallback(VARIANT_OPTIONS, variant)]
      )
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
