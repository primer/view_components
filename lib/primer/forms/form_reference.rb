# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class FormReference < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
      end

      def builder_or_view
        @input.nested? ? builder : @view_context
      end
    end
  end
end
