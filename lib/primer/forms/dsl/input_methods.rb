# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      module InputMethods
        def fields_for(*args, **kwargs, &block)
          add_input FormReferenceInput.new(*args, builder: builder, form: form, **kwargs, &block)
        end

        def multi(**options, &block)
          add_input MultiInput.new(builder: builder, form: form, **options, &block)
        end

        def hidden(**options)
          add_input HiddenInput.new(builder: builder, form: form, **options)
        end

        def check_box(**options, &block)
          add_input CheckBoxInput.new(builder: builder, form: form, **options, &block)
        end

        def radio_button_group(**options, &block)
          add_input RadioButtonGroupInput.new(builder: builder, form: form, **options, &block)
        end

        def check_box_group(**options, &block)
          add_input CheckBoxGroupInput.new(builder: builder, form: form, **options, &block)
        end

        def separator
          add_input Separator.new
        end

        # START text input methods

        def text_field(**options, &block)
          options = decorate_options(**options)
          add_input TextFieldInput.new(builder: builder, form: form, **options, &block)
        end

        def text_area(**options, &block)
          options = decorate_options(**options)
          add_input TextAreaInput.new(builder: builder, form: form, **options, &block)
        end

        # END text input methods

        # START select input methods

        def select_list(**options, &block)
          options = decorate_options(**options)
          add_input SelectListInput.new(builder: builder, form: form, **options, &block)
        end

        # END select input methods

        # START button input methods

        def submit(**options, &block)
          options = decorate_options(**options)
          add_input SubmitButtonInput.new(builder: builder, form: form, **options, &block)
        end

        def button(**options, &block)
          options = decorate_options(**options)
          add_input ButtonInput.new(builder: builder, form: form, **options, &block)
        end

        # END button input methods

        def inputs
          @inputs ||= []
        end

        private

        def add_input(input)
          inputs << input
        end

        # Called before the corresponding Input class is instantiated. The return value of this method is passed
        # to the Input class's constructor.
        def decorate_options(**options)
          options
        end
      end
    end
  end
end
