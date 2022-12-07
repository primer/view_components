# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class SubmitButtonInput < Input
        attr_reader :name, :label, :block

        def initialize(name:, label:, **system_arguments, &block)
          @name = name
          @label = label
          @block = block

          super(**system_arguments)
        end

        def to_component
          SubmitButton.new(input: self)
        end

        # :nocov:
        def type
          :submit_button
        end
      end
    end
  end
end
