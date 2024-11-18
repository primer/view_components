# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class SubmitButton < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @button = Button.new(input: input, type: :submit)
      end
    end
  end
end
