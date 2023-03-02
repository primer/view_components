# frozen_string_literal: true

module Primer
  module Static
    module GenerateStatuses
      class << self
        def call
          Primer::Component.descendants.sort_by(&:name).each_with_object({}) do |component, mem|
            mem[component.to_s] = component.status.to_s
          end
        end
      end
    end
  end
end