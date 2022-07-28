# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class SelectListInput < Input
        # :nodoc:
        class Option
          attr_reader :label, :value, :system_arguments

          def initialize(label:, value:, **system_arguments)
            @label = label
            @value = value
            @system_arguments = system_arguments
          end
        end

        attr_reader :name, :label, :options

        def initialize(name:, label:, **system_arguments)
          @name = name
          @label = label
          @options = []

          super(**system_arguments)

          yield(self) if block_given?
        end

        def option(**system_arguments)
          @options << Option.new(**system_arguments)
        end

        def to_component
          SelectList.new(input: self)
        end

        def type
          :select_list
        end

        def focusable?
          true
        end
      end
    end
  end
end
