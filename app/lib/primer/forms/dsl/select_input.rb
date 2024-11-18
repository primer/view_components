# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class SelectInput < Input
        SELECT_ARGUMENTS = %i[multiple include_blank include_hidden prompt].freeze

        # :nodoc:
        class Option
          include Primer::TestSelectorHelper

          attr_reader :label, :value, :system_arguments

          def initialize(label:, value:, **system_arguments)
            @label = label
            @value = value
            @system_arguments = add_test_selector(system_arguments)
          end
        end

        attr_reader :name, :label, :options, :select_arguments

        def initialize(name:, label:, **system_arguments)
          @name = name
          @label = label
          @options = []

          @select_arguments = {}.tap do |select_args|
            SELECT_ARGUMENTS.each do |select_arg|
              select_args[select_arg] = system_arguments.delete(select_arg)
            end
          end

          super(**system_arguments)

          yield(self) if block_given?
        end

        def multiple?
          @select_arguments.fetch(:multiple, false)
        end

        def option(**system_arguments)
          @options << Option.new(**system_arguments)
        end

        def to_component
          Select.new(input: self)
        end

        # :nocov:
        def type
          :select_list
        end
        # :nocov:

        # :nocov:
        def focusable?
          true
        end
        # :nocov:
      end
    end
  end
end
