# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class ActionMenu < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input

        @input.input_arguments[:form_arguments] = {
          name: @input.name,
          builder: builder
        }

        @input.input_arguments[:select_variant] ||= :single

        unless @input.input_arguments.include?(:dynamic_label)
          @input.input_arguments[:dynamic_label] = true
        end
      end
    end
  end
end
