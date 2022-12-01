# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class MultiInput < Input
        include InputMethods

        attr_reader :name, :label

        def initialize(name:, label:, **system_arguments)
          @name = name
          @label = label

          super(**system_arguments)

          yield(self) if block_given?
        end

        def to_component
          Multi.new(input: self)
        end

        def type
          :multi
        end

        private

        def add_input(input)
          super

          check_one_input_visible!
        end

        def decorate_options(name: nil, **options)
          check_name!(name) if name
          new_options = { name: name || @name, label: nil, form_control: false, **options }
          new_options[:id] = nil if options[:hidden]
          new_options
        end

        def check_name!(name)
          return if name == @name

          raise ArgumentError, "Inputs inside a `multi' block must all have the same name. Expected '#{@name}', got '#{name}'."
        end

        def check_one_input_visible!
          return if inputs.count { |input| !input.hidden? } <= 1

          raise ArgumentError, "Only one input can be visible at a time in a `multi' block."
        end
      end
    end
  end
end
