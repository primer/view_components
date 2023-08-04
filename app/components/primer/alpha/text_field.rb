# frozen_string_literal: true

module Primer
  module Alpha
    TextField = Primer::FormComponents.from_input(Primer::Forms::Dsl::TextFieldInput)

    # Text fields are single-line text inputs rendered as `<input type="text">` in HTML.
    #
    # @form_usage
    #   class ExampleForm < ApplicationForm
    #     form do |example_form|
    #       example_form.text_field(attributes)
    #     end
    #   end
    class TextField < Primer::Component
      status :alpha

      # @!method initialize
      #
      # @macro form_size_arguments
      # @macro form_full_width_arguments
      # @macro form_input_arguments
      #
      # @param placeholder [String] Placeholder text.
      # @param inset [Boolean] If `true`, renders the input in a visually inset state.
      # @param monospace [Boolean] If `true`, uses a monospace font for the input field.
      # @param auto_check_src [String] When provided, makes a request to the given URL whenever the contents of the text field changes. If the server responds with a non-2xx status code, the response body is used as the validation message.
      # @param leading_visual [Hash] Renders a leading visual icon before the text field's cursor. The hash will be passed to Primer's <%= link_to_component(Primer::Beta::Octicon) %> component.
      # @param show_clear_button [Boolean] Whether or not to include a clear button inside the input that clears the input's contents when clicked.
      # @param clear_button_id [String] The HTML id attribute of the clear button.
    end
  end
end
