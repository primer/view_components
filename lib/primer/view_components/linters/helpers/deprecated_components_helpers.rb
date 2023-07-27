# frozen_string_literal: true

require "primer/deprecations"

module ERBLint
  module Linters
    module Helpers
      # Helpers to share between DeprecatedComponents ERB lint and Rubocop cop
      module DeprecatedComponentsHelpers
        def message(component_name)
          ::Primer::Deprecations.deprecation_message(component_name)
        end

        def deprecated_components
          ::Primer::Deprecations.deprecated_components
        end
      end
    end
  end
end
