# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class AutoCompleteInput < Input
        attr_reader :name, :label, :block

        def initialize(name:, label:, **system_arguments, &block)
          @name = name
          @label = label
          @block = block

          super(**system_arguments)
        end

        def to_component
          AutoComplete.new(input: self)
        end

        def type
          :autocomplete
        end

        # The AutoComplete Primer component does not allow auto-focusing
        def focusable?
          false
        end
      end
    end
  end
end
