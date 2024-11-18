# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class TextAreaInput < Input
        attr_reader :name, :label

        def initialize(name:, label:, **system_arguments)
          @name = name
          @label = label

          super(**system_arguments)
        end

        def to_component
          TextArea.new(input: self)
        end

        def type
          :text_area
        end

        # :nocov:
        def focusable?
          true
        end
        # :nocov:
      end
    end
  end
end
