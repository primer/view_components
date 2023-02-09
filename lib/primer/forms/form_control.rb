# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class FormControl < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
        @input.add_label_classes("FormControl-label")
        @form_group_arguments = {
          class: class_names(
            "FormControl",
            "width-full",
            "FormControl--fullWidth" => @input.full_width?
          )
        }

        @form_group_arguments[:hidden] = "hidden" if @input.hidden?
      end
    end
  end
end
