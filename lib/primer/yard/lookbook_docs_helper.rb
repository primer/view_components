# frozen_string_literal: true

# :nocov:
module Primer
  module Yard
    # Helper methods for documentation generated in Lookbook pages.
    module LookbookDocsHelper
      # Adheres to the same signature as Primer::Yard::DocsHelper#link_to_component so link_to_component
      # may be used in a Gatsby or Lookbook context and produce the correct link for each platform.
      #
      # @param component [Class] The component class to link to.
      # @return [String] The link, either in HTML or markdown format.
      def link_to_component(component)
        backend = Primer::Yard::LookbookPagesBackend.new(Primer::Yard::Registry.make, nil)
        component_ref = Primer::Yard::ComponentManifest.ref_for(component)
        page = backend.page_for(component_ref)

        # If the page_path method is available, we're being rendered into HTML by Lookbook
        # and should emit an HTML <a> tag. No page_path means we're being rendered into
        # markdown by LookbookPagesBackend and should emit a markdown + ERB link that
        # Lookbook will eventually render on page load.
        if respond_to?(:page_path)
          link_to(page.docs.short_name, page_path(page.page_id.to_sym.inspect))
        else
          # rubocop:disable Rails/OutputSafety
          "[#{page.docs.short_name}](<%= page_path(#{page.page_id.to_sym.inspect}) %>)".html_safe
          # rubocop:enable Rails/OutputSafety
        end
      end
    end
  end
end
