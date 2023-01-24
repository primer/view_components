# frozen_string_literal: true

module Primer
  module Alpha
    RadioButton = Primer::FormComponents.from_input(Primer::Forms::Dsl::RadioButtonInput)

    # Radio buttons represent one of a set of options and are rendered as `<input type="radio">` in HTML.
    # **NOTE**: You probably want to use the `RadioButtonGroup` component, as it allows rendering the
    # aforementioned set of options.
    #
    # @form_usage
    #   class ExampleForm < ApplicationForm
    #     form do |example_form|
    #       example_form.radio_button(attributes)
    #     end
    #   end
    class RadioButton < Primer::Component
      status :alpha

      # @!method initialize
      #
      # @!macro form_input_arguments
    end
  end
end
