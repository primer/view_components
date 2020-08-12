# frozen_string_literal: true

module Primer
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

    deprecated_options_for :scheme, :outline, :green_outline

    def initialize(title:, scheme: nil, variant: nil, **kwargs)
      @scheme = scheme

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
