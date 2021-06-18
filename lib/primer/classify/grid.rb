# frozen_string_literal: true

module Primer
  class Classify
    # Handler for PrimerCSS grid classes.
    class Grid
      extend Primer::FetchOrFallbackHelper

      CONTAINER_KEY = :container
      CONTAINER_VALUES = [:xl, :lg, :md, :sm].freeze

      CLEARFIX_KEY = :clearfix
      CLEARFIX_VALUES = [true, false].freeze

      COL_KEY = :col
      COL_VALUES = (1..12).to_a.freeze

      KEYS = [CONTAINER_KEY, CLEARFIX_KEY, COL_KEY].freeze

      class << self
        def classes(key, value, breakpoint)
          send(key, value, breakpoint)
        end

        private

        def container(value, _breakpoint)
          val = fetch_or_fallback(CONTAINER_VALUES, value)

          "container-#{val}"
        end

        def clearfix(value, _breakpoint)
          "clearfix" if fetch_or_fallback(CLEARFIX_VALUES, value)
        end

        def col(value, breakpoint)
          val = fetch_or_fallback(COL_VALUES, value.to_i)

          "col#{breakpoint}-#{val}"
        end
      end
    end
  end
end
