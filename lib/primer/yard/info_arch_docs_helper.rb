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

      def link_to_system_arguments_docs
        "{{link_to_system_arguments_docs}}"
      end

      def link_to_typography_docs
        "{{link_to_typography_docs}}"
      end

      def link_to_accessibility
        "{{link_to_accessibility}}"
      end
    end
  end
end
