# frozen_string_literal: true

# :nocov:
module Primer
  module Yard
    # Helper methods to use for yard documentation
    module InfoArchDocsHelper
      include DocsHelper

      def link_to_component(component)
        "{{#link_to_component}}#{component}{{/link_to_component}}"
      end
    end
  end
end
