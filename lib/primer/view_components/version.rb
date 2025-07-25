# frozen_string_literal: true

# :nocov:
module Primer
  module ViewComponents
    module VERSION
      MAJOR = 0
      MINOR = 43
      PATCH = 6

      STRING = [MAJOR, MINOR, PATCH].join(".")
    end
  end
end

puts Primer::ViewComponents::VERSION::STRING if __FILE__ == $PROGRAM_NAME
# rubocop:enable Rails/Output
