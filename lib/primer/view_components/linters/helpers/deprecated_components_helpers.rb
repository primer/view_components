# frozen_string_literal: true

require "primer/deprecations"

module ERBLint
  module Linters
    module Helpers
      # Helpers to share between DeprecatedComponents ERB lint and Rubocop cop
      module DeprecatedComponentsHelpers
        def message(component)
          message = "#{component} has been deprecated and should not be used."

          if Primer::Deprecations.correctable?(component)
            replacement = Primer::Deprecations.replacement(component)
            message += " Try #{replacement} instead."
          end

          message
        end

        def statuses_json
          JSON.parse(
            File.read(
              File.join(File.dirname(__FILE__), "../../../../../static/statuses.json")
            )
          ).freeze
        end

        def deprecated_components
          @deprecated_components ||= statuses_json.select { |_, value| value == "deprecated" }.keys
        end
      end
    end
  end
end
