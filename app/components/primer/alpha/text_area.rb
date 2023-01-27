# frozen_string_literal: true

module Primer
  module Alpha
    TextArea = Primer::FormComponents.from_input(Primer::Forms::Dsl::TextAreaInput)

    # Text areas are multi-line text inputs rendered using the `<textarea>` tag in HTML.
    #
    # @form_usage
    #   class ExampleForm < ApplicationForm
    #     form do |example_form|
    #       example_form.text_area(attributes)
    #     end
    #   end
    class TextArea < Primer::Component
      status :alpha

      # @!method initialize
      #
      # @macro form_input_arguments
    end
  end
end
