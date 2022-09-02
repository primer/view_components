# frozen_string_literal: true

module Primer
  module ViewComponents
    module VERSION
      MAJOR = 0
      MINOR = 0
      PATCH = 93

      STRING = [MAJOR, MINOR, PATCH].join(".")
    end
  end
end

# rubocop:disable Rails/Output
puts Primer::ViewComponents::VERSION::STRING if __FILE__ == $PROGRAM_NAME
# rubocop:enable Rails/Output
