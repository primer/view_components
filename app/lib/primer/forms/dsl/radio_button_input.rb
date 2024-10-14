# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class RadioButtonInput < Input
        attr_reader :name, :value, :label, :nested_form_block, :nested_form_arguments

        def initialize(name:, value:, label:, **system_arguments)
          @name = name
          @value = value
          @label = label

          super(**system_arguments)

          yield(self) if block_given?
        end

        # radio buttons cannot be invalid, as both selected and unselected are valid states
        # :nocov:
        def valid?
          true
        end
        # :nocov:

        def to_component
          RadioButton.new(input: self)
        end

        def nested_form(**system_arguments, &block)
          @nested_form_arguments = system_arguments
          @nested_form_block = block
        end

        # :nocov:
        def type
          :radio_button
        end
        # :nocov:

        def supports_validation?
          false
        end
      end
    end
  end
end
