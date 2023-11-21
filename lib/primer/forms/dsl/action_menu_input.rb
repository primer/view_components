# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class ActionMenuInput < Input
        attr_reader :name, :label, :block

        def initialize(name:, label:, **system_arguments, &block)
          @name = name
          @label = label
          @block = block

          super(**system_arguments)
        end

        def to_component
          ActionMenu.new(input: self)
        end

        # :nocov:
        def type
          :action_menu
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
