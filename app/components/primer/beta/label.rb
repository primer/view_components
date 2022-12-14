# frozen_string_literal: true

module Primer
  module Beta
    # Use `Label` to add contextual metadata to a design.
    #
    # @accessibility
    #   Use `aria-label` if the `Label` or the context around it don't explain the label.
    class Label < Primer::Component
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

      DEFAULT_SIZE = :medium
      SIZE_MAPPINGS = {
        DEFAULT_SIZE => nil,
        :large => "Label--large"
      }.freeze
      SIZE_OPTIONS = SIZE_MAPPINGS.keys

      DEFAULT_VARIANT = :none
      VARIANT_OPTIONS = [DEFAULT_VARIANT].freeze
      DEPRECATED_VARIANT_OPTIONS = [:large, :inline].freeze

      INLINE_CLASS = "Label--inline"

      # @example Schemes
      #   <%= render(Primer::Beta::Label.new) { "Default" } %>
      #   <%= render(Primer::Beta::Label.new(scheme: :primary)) { "Primary" } %>
      #   <%= render(Primer::Beta::Label.new(scheme: :secondary)) { "Secondary" } %>
      #   <%= render(Primer::Beta::Label.new(scheme: :accent)) { "Accent" } %>
      #   <%= render(Primer::Beta::Label.new(scheme: :success)) { "Success" } %>
      #   <%= render(Primer::Beta::Label.new(scheme: :attention)) { "Attention" } %>
      #   <%= render(Primer::Beta::Label.new(scheme: :danger)) { "Danger" } %>
      #   <%= render(Primer::Beta::Label.new(scheme: :severe)) { "Severe" } %>
      #   <%= render(Primer::Beta::Label.new(scheme: :done)) { "Done" } %>
      #   <%= render(Primer::Beta::Label.new(scheme: :sponsors)) { "Sponsors" } %>
      #
      # @example Sizes
      #   <%= render(Primer::Beta::Label.new) { "Medium" } %>
      #   <%= render(Primer::Beta::Label.new(size: :large)) { "Large" } %>
      #
      # @example Inline
      #   <%= render(Primer::Beta::Label.new) { "Default" } %>
      #   <%= render(Primer::Beta::Label.new(inline: true)) { "Inline" } %>
      #
      # @param tag [Symbol] <%= one_of(Primer::Beta::Label::TAG_OPTIONS) %>
      # @param scheme [Symbol] <%= one_of(Primer::Beta::Label::SCHEME_MAPPINGS.keys) %>
      # @param size [Symbol] <%= one_of(Primer::Beta::Label::SIZE_OPTIONS) %>
      # @param inline [Boolean] Whether or not to render this label inline.
      # @param variant [Symbol] <%= one_of(Primer::Beta::Label::VARIANT_OPTIONS + Primer::Beta::Label::DEPRECATED_VARIANT_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>

      def initialize(tag: DEFAULT_TAG, scheme: DEFAULT_SCHEME, size: DEFAULT_SIZE, inline: false, variant: DEFAULT_VARIANT, **system_arguments)
        @system_arguments = system_arguments

        @variant = fetch_or_fallback(VARIANT_OPTIONS, variant, nil, deprecated_values: DEPRECATED_VARIANT_OPTIONS)
        @scheme = fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME, deprecated_values: DEPRECATED_SCHEME_OPTIONS)
        @size = fetch_or_fallback(SIZE_OPTIONS, size, DEFAULT_SIZE)
        @size = :large if @variant == :large
        @inline = inline || @variant == :inline

        @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)
        @system_arguments[:classes] = class_names(
          "Label",
          system_arguments[:classes],
          SCHEME_MAPPINGS[@scheme],
          SIZE_MAPPINGS[@size],
          @inline ? INLINE_CLASS : nil
        )
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) { content }
      end
    end
  end
end
