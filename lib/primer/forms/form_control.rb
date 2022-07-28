# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class FormControl < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
        @input.add_label_classes("FormControl-label")
        @form_group_classes = class_names(
          "FormControl",
          "FormControl--fullWidth" => @input.full_width?
        )
      end
    end
  end
end
