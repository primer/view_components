# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class ToggleSwitchInput < Input
        attr_reader :name, :label, :src, :value, :unchecked_value, :csrf

        def initialize(
          name:,
          label:,
          src:,
          value: nil,
          unchecked_value: nil,
          csrf: nil,
          **system_arguments
        )
          @name = name
          @label = label
          @src = src
          @value = value
          @unchecked_value = unchecked_value
          @csrf = csrf

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
