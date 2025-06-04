# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module Alpha
    # @label IncludeFragment
    class IncludeFragmentPreview < ViewComponent::Preview
      # @label Playground
      # @param loading select [eager, lazy]
      def playground(loading: :eager)
        render(Primer::Alpha::IncludeFragment.new(loading: loading, src: UrlHelpers.primer_view_components.include_fragment_deferred_path)) { "Loading..." }
      end

      # @label Default options
      def default
        render(Primer::Alpha::IncludeFragment.new(loading: :eager, src: UrlHelpers.primer_view_components.include_fragment_deferred_path)) { "Loading..." }
      end
    end
  end
end
