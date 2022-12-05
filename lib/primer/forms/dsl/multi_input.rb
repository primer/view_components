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

        def decorate_options(name:, **options)
          new_options = { name: @name, label: nil, form_control: false, **options }
          new_options[:data] ||= {}
          new_options[:data][:name] = name
          new_options[:data][:targets] = "primer-multi-input.fields"
          new_options[:id] = nil if options[:hidden]
          new_options[:disabled] = true if options[:hidden] # disable to avoid submitting to server
          new_options
        end

        def check_one_input_visible!
          return if inputs.count { |input| !input.hidden? } <= 1

          raise ArgumentError, "Only one input can be visible at a time in a `multi' block."
        end
      end
    end
  end
end
