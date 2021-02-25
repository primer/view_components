# frozen_string_literal: true

module Primer
  # Use IssueLabel to add labels for issues and pull requests.
  class IssueLabelComponent < Primer::Component
    DEFAULT_VARIANT = :default
    VARIANT_MAPPINGS = {
      DEFAULT_VARIANT => "",
      :big => "IssueLabel--big"
    }.freeze

    # @example auto|Schemes
    #   <%= render(Primer::IssueLabelComponent.new(text: :white, bg: :blue)) { "Primer" } %>
    #   <%= render(Primer::IssueLabelComponent.new(text: :white, bg: :red)) { "bug 🐛<" } %>
    #   <%= render(Primer::IssueLabelComponent.new(text: :white, bg: :pink)) { "help wanted" } %>
    #   <%= render(Primer::IssueLabelComponent.new(text: :white, bg: :yellow)) { "🚂 deploy: train" } %>
    #
    # @example auto|Big variant
    #   <%= render(Primer::IssueLabelComponent.new(text: :white, bg: :blue, variant: :big)) { "Primer" } %>
    #   <%= render(Primer::IssueLabelComponent.new(text: :white, bg: :red, variant: :big)) { "bug 🐛<" } %>
    #   <%= render(Primer::IssueLabelComponent.new(text: :white, bg: :pink, variant: :big)) { "help wanted" } %>
    #   <%= render(Primer::IssueLabelComponent.new(text: :white, bg: :yellow, variant: :big)) { "🚂 deploy: train" } %>
    #
    # @param variant [Symbol] <%= one_of(Primer::IssueLabelComponent::VARIANT_MAPPINGS.keys) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(variant: DEFAULT_VARIANT, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] ||= :span
      @system_arguments[:classes] = class_names(
        "IssueLabel",
        VARIANT_MAPPINGS[fetch_or_fallback(VARIANT_MAPPINGS.keys, variant, DEFAULT_VARIANT)],
        system_arguments[:classes]
      )
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
