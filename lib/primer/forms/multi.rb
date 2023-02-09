# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class Multi < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input

        Primer::Forms::Utils.classify(@input.input_arguments)
      end
    end
  end
end
