# frozen_string_literal: true

require_relative "utilities"

module Primer
  class Classify
    # :nodoc:
    class Validation
      INVALID_CLASS_NAME_PREFIXES = /text-|box-shadow-|box_shadow-/.freeze

      SUPPORTED_SELECTOR_EXCEPTIONS = %w[
        f6
        f5
        rounded-2
        border-bottom-0
        flex-self-baseline
        no-underline
        flex-items-center
        flex-self-end
        flex-shrink-0
      ].freeze

      class << self
        def invalid?(class_name)
          class_name.start_with?(INVALID_CLASS_NAME_PREFIXES) ||
            (Primer::Classify::Utilities.supported_selector?(class_name) && SUPPORTED_SELECTOR_EXCEPTIONS.exclude?(class_name))
        end
      end
    end
  end
end
