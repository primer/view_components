# frozen_string_literal: true

# :nocov:
module Primer
  module ViewComponents
    module VERSION
      MAJOR = 0
      MINOR = 1
      PATCH = 1

      STRING = [MAJOR, MINOR, PATCH].join(".")
    end
  end
end

# rubocop:disable Rails/Output
puts Primer::ViewComponents::VERSION::STRING if __FILE__ == $PROGRAM_NAME
# rubocop:enable Rails/Output
