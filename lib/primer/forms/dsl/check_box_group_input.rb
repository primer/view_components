# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class CheckBoxGroupInput < Input
        attr_reader :label, :check_boxes

        def initialize(label: nil, **system_arguments)
          @label = label
          @check_boxes = []

          super(**system_arguments)

          add_label_classes("FormControl-label", "mb-2")

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

        def check_box(**system_arguments)
          @check_boxes << CheckBoxInput.new(
            builder: @builder, form: @form, **system_arguments
          )
        end
      end
    end
  end
end
