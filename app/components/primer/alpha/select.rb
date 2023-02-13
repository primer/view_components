# frozen_string_literal: true

module Primer
  module Alpha
    Select = Primer::FormComponents.from_input(Primer::Forms::Dsl::SelectInput)

    # Select lists are single-line text inputs rendered as `<select>` tags in HTML.
    #
    # @form_usage
    #   class ExampleForm < ApplicationForm
    #     form do |example_form|
    #       example_form.select_list(attributes) do |list|
    #         list.option(option_attributes)
    #       end
    #     end
    #   end
    class Select < Primer::Component
      status :alpha

      # @!method initialize
      #
      # @macro form_size_arguments
      # @macro form_input_arguments
      #
      # @param multiple [Boolean] If set to true, the selection will allow multiple choices.
      # @param include_blank [Boolean, String] If set to true, an empty option will be created. If set to a string, the string will be used as the option's content and the value will be empty.
      # @param prompt [String] Create a prompt option with blank value and the text asking user to select something.

      # @!method option
      #
      # Adds an option to the list.
      #
      # @param label [String] The user-facing label for the option.
      # @param value [String] The value sent to the server on form submission.
    end
  end
end
