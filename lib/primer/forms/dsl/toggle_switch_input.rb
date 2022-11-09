# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class ToggleSwitchInput < Input
        attr_reader :name, :label, :value, :unchecked_value

        def initialize(name:, label:, value: nil, unchecked_value: nil, **system_arguments)
          @name = name
          @label = label
          @value = value
          @unchecked_value = unchecked_value

          super(**system_arguments)
        end

        def to_component
          ToggleSwitch.new(input: self)
        end

        def type
          :toggle_switch
        end
      end
    end
  end
end
