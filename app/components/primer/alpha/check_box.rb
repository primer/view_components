# frozen_string_literal: true

module Primer
  module Alpha
    CheckBox = Primer::FormComponents.from_input(Primer::Forms::Dsl::CheckBoxInput)

    # Check boxes are true/false inputs rendered as `<input type="checkbox">` in HTML.
    #
    # ## Schemes
    #
    # Check boxes can submit values to the server using one of two schemes, either `:array`
    # or `:boolean` (the default). Check boxes with a scheme of `:boolean` function like normal
    # HTML check boxes. If they are checked, a value of "1" is sent to the server; if they are
    # unchecked, a value of "0" is sent to the server. The checked and unchecked values can be
    # customized via the `:value` and `:unchecked_value` arguments respectively.
    #
    # Whereas `:boolean` check boxes must have unique names, `:array` check boxes all have the
    # same name. On form submission, Rails will aggregate the values of the check boxes with the
    # same name and provide them to the controller as an array. If `:scheme:` is `:array`, the
    # `:value` argument must also be provided. The `:unchecked_value` argument is ignored. If a
    # check box is checked on submit, its corresponding value will appear in the array. If it is
    # not checked, its value will not appear in the array.
    #
    # ## Caption templates
    #
    # Caption templates for `:array`-type check boxes work a little differently than they do for
    # other input types. Because the name must be the same for all check boxes that make up an
    # array, caption template file names are comprised of both the name _and_ the value of each
    # check box. For example, a check box with the name `foo` and value `bar` must have a caption
    # template named `foo_bar_caption.html.erb`.
    #
    # ## Nested Forms
    #
    # Check boxes can have "nested" forms that are rendered below the caption. A common use-case
    # is a form that is hidden until the check box is checked. Nested forms are indented slightly
    # to align with the label and caption.
    #
    # Define a nested form via the `#nested_form` method, which is expected to return an instance
    # of a Primer form (see the usage section below).
    #
    # Any fields defined in the nested form are submitted along with the parent form's fields.
    #
    # **NOTE**: Check boxes do not automatically show or hide nested forms. If such behavior is
    # desired, it must be done by hand.
    #
    # @form_usage
    #   class ExampleForm < ApplicationForm
    #     form do |example_form|
    #       example_form.check_box(attributes) do |check_box|
    #         check_box.nested_form do |builder|
    #           AnotherPrimerForm.new(builder)
    #         end
    #       end
    #     end
    #   end
    class CheckBox < Primer::Component
      status :alpha

      # @!method initialize
      #
      # @macro form_input_arguments
      #
      # @param value [String] On form submission, this value will be sent to the server if the check box is checked. Defaults to "1".
      # @param unchecked_value [String] On form submission, this value will be sent to the server if the check box is _not_ checked. Defaults to "0".
      # @param scheme [Symbol] Controls how check box values are submitted to the server. <%= one_of(Primer::Forms::Dsl::CheckBoxInput::SCHEMES) %>.

      # @!method nested_form
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %> that will be applied to a `<div>` element that wraps the form.
      # @param block [Proc] This block is yielded the Rails `builder` object and is expected to return the nested form object, an instance of `Primer::Forms::Base`.
    end
  end
end
