# frozen_string_literal: true

module Primer
  module Alpha
    SubmitButton = Primer::FormComponents.from_input(Primer::Forms::Dsl::SubmitButtonInput)

    # A submit button input rendered using the HTML `<button type="submit">` tag.
    #
    # This component wraps the Primer button component and supports the same slots and arguments.
    #
    # @form_usage
    #   class ExampleForm < ApplicationForm
    #     form do |example_form|
    #       example_form.submit(attributes)
    #     end
    #   end
    class SubmitButton < Primer::Component
      status :alpha

      # @!method initialize
      #
      # @param name [String] Value for the HTML name attribute.
      # @param id [String] Value for the HTML id attribute.
      # @param class [String] CSS classes to include in the input's HTML `class` attribute. Exists for compatibility with Rails form builders.
      # @param classes [Array] CSS classes to include in the input's HTML `class` attribute. Combined with the `:class` argument. The list may contain strings, hashes, or `nil` values, and is automatically cleaned up by Primer's [`class_name` helper](https://github.com/primer/view_components/blob/c9cb95c98fee3e2e27f4a10683f555e22285e7f1/app/lib/primer/class_name_helper.rb) (`nils`, falsy entries, and blank strings are ignored).
      # @param label [String] Label text displayed above the input.
      # @param aria [Hash] Key/value pairs that represent Aria attributes and their values. Eg. `aria: { current: true }` becomes `aria-current="true"`.
      # @param data [Hash] Key/value pairs that represent data attributes and their values. Eg. `data: { foo: "bar" }` becomes `data-foo="bar"`.
      # @macro form_system_arguments
    end
  end
end
