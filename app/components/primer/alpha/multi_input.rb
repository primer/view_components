# frozen_string_literal: true

module Primer
  module Alpha
    MultiInput = Primer::FormComponents.from_input(Primer::Forms::Dsl::MultiInput)

    # Multi inputs are comprised of multiple constituent fields, only one of which is visible
    # at a given time. They are designed for situations where constituent inputs are shown or
    # hidden based on the value of another field. For example, consider an address form. If
    # the user chooses the USA as the country, the region input should show a list of states
    # and US territories; if the user instead chooses Canada, the region input should show a
    # list of Canadian provinces, etc.
    #
    # Unlike everywhere else in Primer forms, constituent inputs are not directly passed a
    # `name` attribute. Instead, developers pass a `name` attribute to the multi input itself.
    # The multi input then automatically assigns each constituent input the same name. This is
    # done so that the multi input looks like a single field from the server's point of view.
    # Using the address form example from earlier, this means only one value - either a US state
    # or a Canadian provice - will be submitted to the server under the `region` key.
    #
    # Actually, that's not quite true. Constituent inputs _are_ given a `name`, but it's added to
    # the input as the `data-name` attribute as a way to identify constituent inputs, and will not
    # be sent to the server.
    #
    # @form_usage
    #   class ExampleForm < ApplicationForm
    #     form do |example_form|
    #       example_form.multi(attributes) do |multi|
    #         # can define any number of child inputs, for example:
    #         multi.text_field(text_field_attributes)
    #         multi.select_list(select_list_attributes, hidden: true) do |list|
    #           list.option(option_attributes)
    #           list.option(option_attributes)
    #         end
    #       end
    #     end
    #   end
    class MultiInput < Primer::Component
      # @!parse include Primer::Forms::Dsl::InputMethods

      status :alpha

      # @!method initialize
      #
      # @macro form_input_arguments
    end
  end
end
