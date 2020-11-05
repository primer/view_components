# frozen_string_literal: true

module Primer
  # Use labels to add contextual metadata to a design.
  class LabelComponent < Primer::Component
    SCHEME_MAPPINGS = {
      # gray
      gray: "Label--gray",
      dark_gray: "Label--gray-darker",

      # colored
      yellow: "Label--yellow",
      orange: "Label--orange",
      red: "Label--red",
      green: "Label--green",
      blue: "Label--blue",
      purple: "Label--purple",
      pink: "Label--pink",

      # Deprecated
      outline: "Label--outline",
      green_outline: "Label--outline-green",
    }.freeze
    SCHEME_OPTIONS = SCHEME_MAPPINGS.keys << nil

    VARIANT_MAPPINGS = {
      large: "Label--large",
      inline: "Label--inline",
    }.freeze
    VARIANT_OPTIONS = VARIANT_MAPPINGS.keys << nil

    # @example 40|Schemes
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label")) { "default" } %>
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :gray)) { "gray" } %>
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :dark_gray)) { "dark_gray" } %>
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :yellow)) { "yellow" } %>
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :green)) { "green" } %>
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :purple)) { "purple" } %>
    #
    # @example 40|Variants
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label")) { "Default" } %>
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label", variant: :large)) { "Large" } %>
    #
    # @param title [String] `title` attribute for the component element.
    # @param scheme [Symbol] <%= one_of(Primer::LabelComponent::SCHEME_OPTIONS) %>
    # @param variant [Symbol] <%= one_of(Primer::LabelComponent::VARIANT_OPTIONS) %>
    # @param kwargs [Hash] <%= link_to_system_arguments_docs %>
    def initialize(title:, scheme: nil, variant: nil, **kwargs)
      @kwargs = kwargs
      @kwargs[:bg] = :blue if scheme.nil?
      @kwargs[:tag] ||= :span
      @kwargs[:title] = title
      @kwargs[:classes] = class_names(
        "Label",
        kwargs[:classes],
        SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_OPTIONS, scheme)],
        VARIANT_MAPPINGS[fetch_or_fallback(VARIANT_OPTIONS, variant)]
      )
    end

    def call
      render(Primer::BaseComponent.new(**@kwargs)) { content }
    end
  end
end
