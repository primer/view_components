# frozen_string_literal: true

module Primer
  module ViewComponents
    class Configuration
      attr_accessor :autoload

      def initialize
        @autoload = false
      end
    end
  end
end
