# frozen_string_literal: true

# Primer::FetchOrFallbackHelper
# A mapper to get the correct button class.
module Primer
  # :nodoc:
  class ButtonMapper
    extend FetchOrFallbackHelper

    TYPES = {
      default: "Primer::ButtonComponent",
      block: "Primer::ButtonBlockComponent",
      danger: "Primer::ButtonDangerComponent",
      invisible: "Primer::ButtonInvisibleComponent",
      outline: "Primer::ButtonOutlineComponent",
      primary: "Primer::ButtonPrimaryComponent"
    }.freeze

    def self.button_class(type)
      TYPES[fetch_or_fallback(TYPES.keys, type, :default)].constantize
    end
  end
end
