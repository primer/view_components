# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class ButtonInput < Input
        attr_reader :name, :label, :block

        def initialize(name:, label:, **system_arguments, &block)
          @name = name
          @label = label
          @block = block

          super(**system_arguments)
        end

        def to_component
          Button.new(input: self)
        end

        # :nocov:
        def type
          :button
        end

        def supports_validation?
          false
        end
      end
    end
  end
end
