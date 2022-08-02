# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class RadioButtonGroupInput < Input
        attr_reader :name, :label, :radio_buttons

        def initialize(name:, label: nil, **system_arguments)
          @name = name
          @label = label
          @radio_buttons = []

          super(**system_arguments)

          add_label_classes("FormControl-label", "mb-2")

          yield(self) if block_given?
        end

        def to_component
          RadioButtonGroup.new(input: self)
        end

        def type
          :radio_button_group
        end

        def radio_button(**system_arguments, &block)
          @radio_buttons << RadioButtonInput.new(
            builder: @builder, form: @form, name: @name, **system_arguments, &block
          )
        end
      end
    end
  end
end
