# frozen_string_literal: true

module Primer
  # Use labels to add contextual metadata to a design.
  class LabelComponent < Primer::Component
    NEW_SCHEME_MAPPINGS = {
      primary: "Label--primary",
      secondary: "Label--secondary",
      info: "Label--info",
      success: "Label--success",
      warning: "Label--warning",
      danger: "Label--danger"
    }.freeze

    DEPRECATED_SCHEME_MAPPINGS = {
      gray: "Label--gray",
      dark_gray: "Label--gray-darker",
      yellow: "Label--yellow",
      orange: "Label--orange",
      red: "Label--red",
      green: "Label--green",
      blue: "Label--blue",
      purple: "Label--purple",
      pink: "Label--pink",
      outline: "Label--outline",
      green_outline: "Label--outline-green"
    }.freeze

    SCHEME_MAPPINGS = NEW_SCHEME_MAPPINGS.merge(DEPRECATED_SCHEME_MAPPINGS)
    SCHEME_OPTIONS = SCHEME_MAPPINGS.keys << nil

    VARIANT_MAPPINGS = {
      large: "Label--large",
      inline: "Label--inline"
    }.freeze
    VARIANT_OPTIONS = VARIANT_MAPPINGS.keys << nil

    # @example 20|Schemes
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label")) { "default" } %>
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :gray)) { "gray" } %>
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :dark_gray)) { "dark_gray" } %>
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :yellow)) { "yellow" } %>
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :green)) { "green" } %>
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :purple)) { "purple" } %>
    #
    # @example 20|Variants
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label")) { "Default" } %>
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label", variant: :large)) { "Large" } %>
    #
    # @param title [String] `title` attribute for the component element.
    # @param scheme [Symbol] <%= one_of(Primer::LabelComponent::DEPRECATED_SCHEME_MAPPINGS.keys) %>
    # @param variant [Symbol] <%= one_of(Primer::LabelComponent::VARIANT_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(title:, scheme: nil, variant: nil, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:bg] = :blue if scheme.nil?
      @system_arguments[:tag] ||= :span
      @system_arguments[:title] = title
      @system_arguments[:classes] = class_names(
        "Label",
        system_arguments[:classes],
        SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_OPTIONS, scheme)],
        VARIANT_MAPPINGS[fetch_or_fallback(VARIANT_OPTIONS, variant)]
      )
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
