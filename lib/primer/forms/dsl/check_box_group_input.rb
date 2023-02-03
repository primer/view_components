# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class CheckBoxGroupInput < Input
        attr_reader :label, :check_boxes

        def initialize(name: nil, label: nil, **system_arguments)
          @name = name
          @label = label
          @check_boxes = []

          super(**system_arguments)

          yield(self) if block_given?
        end

        def to_component
          CheckBoxGroup.new(input: self)
        end

        def name
          nil
        end

        def type
          :check_box_group
        end

        def check_box(**system_arguments, &block)
          args = {
            name: @name,
            **system_arguments,
            builder: @builder,
            form: @form,
            scheme: scheme,
            disabled: disabled?
          }

          @check_boxes << CheckBoxInput.new(**args, &block)
        end

        private

        def scheme
          @name ? :array : :boolean
        end
      end
    end
  end
end
