# frozen_string_literal: true

module Primer
  # Use labels to add contextual metadata to a design.
  class LabelComponent < Primer::Component
    status :beta

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
    SCHEME_OPTIONS = SCHEME_MAPPINGS.keys << nil

    VARIANT_MAPPINGS = {
      large: "Label--large",
      inline: "Label--inline"
    }.freeze
    VARIANT_OPTIONS = VARIANT_MAPPINGS.keys << nil

    # @example Schemes
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label")) { "Default" } %>
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :primary)) { "Primary" } %>
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :secondary)) { "Secondary" } %>
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :info)) { "Info" } %>
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :success)) { "Success" } %>
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :warning)) { "Warning" } %>
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :danger)) { "Danger" } %>
    #
    # @example Variants
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label")) { "Default" } %>
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label", variant: :large)) { "Large" } %>
    #
    # @example Deprecated schemes
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :orange)) { "Orange" } %>
    #   <%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :purple)) { "Purple" } %>
    #
    # @param title [String] `title` attribute for the component element.
    # @param scheme [Symbol] <%= one_of(Primer::LabelComponent::SCHEME_MAPPINGS.keys) %>
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
