# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class CheckBoxInput < Input
        attr_reader :name, :label

        def initialize(name:, label:, **system_arguments)
          @name = name
          @label = label

          super(**system_arguments)
        end

        def to_component
          CheckBox.new(input: self)
        end

        def type
          :check_box
        end
      end
    end
  end
end
