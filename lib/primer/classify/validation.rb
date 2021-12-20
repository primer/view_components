# frozen_string_literal: true

require_relative "utilities"

module Primer
  class Classify
    # :nodoc:
    class Validation
      INVALID_CLASS_NAME_PREFIXES = /text-|box-shadow-|box_shadow-/.freeze

      SUPPORTED_SELECTOR_EXCEPTIONS = %w[
        f1
        f2
        f3
        f4
        f5
        f6
        rounded-0
        rounded-1
        rounded-2
        rounded-3
        border-top-0
        border-bottom-0
        border-right-0
        border-left-0
        no-underline
        flex-column
        flex-items-center
        flex-self-baseline
        flex-self-center
        flex-self-end
        flex-self-start
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
