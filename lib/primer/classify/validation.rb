# frozen_string_literal: true

require_relative "utilities"

module Primer
  class Classify
    # :nodoc:
    class Validation
      INVALID_CLASS_NAME_PREFIXES = /text-|box-shadow-|box_shadow-/.freeze

      class << self
        def invalid?(class_name)
          class_name.start_with?(INVALID_CLASS_NAME_PREFIXES) || Primer::Classify::Utilities.supported_selector?(class_name)
        end
      end
    end
  end
end
