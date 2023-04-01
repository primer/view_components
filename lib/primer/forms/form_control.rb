# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class FormControl < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:, tag: :div, **system_arguments)
        @input = input
        @tag = tag
        @input.add_label_classes("FormControl-label")
        @form_group_arguments = {
          **system_arguments,
          class: class_names(
            system_arguments[:class],
            system_arguments[:classes],
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
