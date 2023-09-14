# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class ValidationMessage < BaseComponent
      attr_reader :input

      def initialize(input:)
        @input = input
      end
    end
  end
end
