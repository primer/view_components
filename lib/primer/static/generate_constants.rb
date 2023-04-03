# frozen_string_literal: true

# :nocov:
module Primer
  module Static
    # :nodoc:
    module GenerateConstants
      class << self
        def call
          Primer::Component.descendants.sort_by(&:name).each_with_object({}) do |component, mem|
            mem[component.to_s] = component.constants(false).sort.each_with_object({}) do |constant, h|
              h[constant] = component.const_get(constant)
            end
          end
        end
      end
    end
  end
end
