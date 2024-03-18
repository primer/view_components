# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      module InputMethods
        # Used to render another form object.
        #
        # @param args [Array] Positional arguments passed to Rails' [`fields_for` helper](https://api.rubyonrails.org/v7.0.4/classes/ActionView/Helpers/FormHelper.html#method-i-fields_for).
        # @param kwargs [Hash] The options accepted by the form reference input (see forms docs). Includes keyword arguments passed to Rails' [`fields_for` helper](https://api.rubyonrails.org/v7.0.4/classes/ActionView/Helpers/FormHelper.html#method-i-fields_for).
        def fields_for(*args, **kwargs, &block)
          add_input FormReferenceInput.new(*args, builder: builder, form: form, **kwargs, &block)
        end

        # Adds a multi input to this form.
        #
        # @param options [Hash] The options accepted by the multi input (see forms docs).
        # @param block [Proc] A block that will be yielded a reference to the input object so it can be customized.
        def multi(**options, &block)
          add_input MultiInput.new(builder: builder, form: form, **options, &block)
        end

        # Adds a hidden input to this form.
        #
        # @param options [Hash] The options accepted by the hidden input (see forms docs).
        def hidden(**options)
          add_input HiddenInput.new(builder: builder, form: form, **options)
        end

        # Adds a check box to this form.
        #
        # @param options [Hash] The options accepted by the check box input (see forms docs).
        # @param block [Proc] A block that will be yielded a reference to the input object so it can be customized.
        def check_box(**options, &block)
          add_input CheckBoxInput.new(builder: builder, form: form, **options, &block)
        end

        # Adds a radio button group to this form.
        #
        # @param options [Hash] The options accepted by the radio button group input (see forms docs).
        # @param block [Proc] A block that will be yielded a reference to the input object so it can be customized.
        def radio_button_group(**options, &block)
          add_input RadioButtonGroupInput.new(builder: builder, form: form, **options, &block)
        end

        # Adds a check box group to this form.
        #
        # @param options [Hash] The options accepted by the check box group input (see forms docs).
        # @param block [Proc] A block that will be yielded a reference to the input object so it can be customized.
        def check_box_group(**options, &block)
          add_input CheckBoxGroupInput.new(builder: builder, form: form, **options, &block)
        end

        # Adds a horizontal separator to the form.
        def separator
          add_input Separator.new
        end

        # START text input methods

        # Adds a text field to this form.
        #
        # @param options [Hash] The options accepted by the text field input (see forms docs).
        # @param block [Proc] A block that will be yielded a reference to the input object so it can be customized.
        def text_field(**options, &block)
          options = decorate_options(**options)
          add_input TextFieldInput.new(builder: builder, form: form, **options, &block)
        end

        # Adds an autocomplete text field to this form.
        #
        # @param options [Hash] The options accepted by the autocomplete input (see forms docs).
        # @param block [Proc] A block that will be yielded a reference to the input object so it can be customized.
        def auto_complete(**options, &block)
          options = decorate_options(**options)
          add_input AutoCompleteInput.new(builder: builder, form: form, **options, &block)
        end

        # Adds a text area to this form.
        #
        # @param options [Hash] The options accepted by the text area input (see forms docs).
        # @param block [Proc] A block that will be yielded a reference to the input object so it can be customized.
        def text_area(**options, &block)
          options = decorate_options(**options)
          add_input TextAreaInput.new(builder: builder, form: form, **options, &block)
        end

        # END text input methods

        # START select input methods

        # Adds a select list to this form.
        #
        # @param options [Hash] The options accepted by the select list input (see forms docs).
        # @param block [Proc] A block that will be yielded a reference to the input object so it can be customized.
        def select_list(**options, &block)
          options = decorate_options(**options)
          add_input SelectInput.new(builder: builder, form: form, **options, &block)
        end

        # Adds an <%= link_to_component(Primer::Alpha::ActionMenu) %> to this form.
        #
        # @param options [Hash] The options accepted by the <%= link_to_component(Primer::Alpha::ActionMenu) %> component.
        # @param block [Proc] The block passed to `#render` when the <%= link_to_component(Primer::Alpha::ActionMenu) %> is rendered. This block is passed an instance of <%= link_to_component(Primer::Alpha::ActionMenu) %>, which can be used to add items, dividers, etc.
        def action_menu(**options, &block)
          options = decorate_options(**options)
          add_input ActionMenuInput.new(builder: builder, form: form, **options, &block)
        end

        # END select input methods

        # START button input methods

        # Adds a submit button to this form.
        #
        # @param options [Hash] The options accepted by the submit button input (see forms docs).
        # @param block [Proc] A block that will be yielded a reference to the input object so it can be customized.
        def submit(**options, &block)
          options = decorate_options(**options)
          add_input SubmitButtonInput.new(builder: builder, form: form, **options, &block)
        end

        # Adds a (non-submit) button to this form.
        #
        # @param options [Hash] The options accepted by the button input (see forms docs).
        # @param block [Proc] A block that will be yielded a reference to the input object so it can be customized.
        def button(**options, &block)
          options = decorate_options(**options)
          add_input ButtonInput.new(builder: builder, form: form, **options, &block)
        end

        # END button input methods

        # @private
        def inputs
          @inputs ||= []
        end

        private

        # @private
        def add_input(input)
          inputs << input
        end

        # @private
        #
        # Called before the corresponding Input class is instantiated. The return value of this method is passed
        # to the Input class's constructor.
        def decorate_options(**options)
          options
        end
      end
    end
  end
end
