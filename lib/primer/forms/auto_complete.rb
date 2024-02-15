# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class AutoComplete < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
      end
    end
  end
end
