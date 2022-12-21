# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class ToggleSwitch < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
        @input.add_label_classes("FormControl-label")

        @form_group_arguments = { class: "d-flex" }

        @form_group_arguments[:hidden] = "hidden" if @input.hidden?
      end
    end
  end
end
