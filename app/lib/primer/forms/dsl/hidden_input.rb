# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class HiddenInput < Input
        attr_reader :name

        def initialize(name:, **system_arguments)
          @name = name
          super(**system_arguments)
        end

        def to_component
          HiddenField.new(input: self)
        end

        def label
          nil
        end

        def type
          :hidden
        end

        def supports_validation?
          false
        end
      end
    end
  end
end
