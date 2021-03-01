# frozen_string_literal: true

module Primer
  module ViewComponents
    module VERSION
      MAJOR = 0
      MINOR = 0
      PATCH = 21

      STRING = [MAJOR, MINOR, PATCH].join(".")
    end
  end
end

if __FILE__ == $0
  puts Primer::ViewComponents::VERSION::STRING
end
