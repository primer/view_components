# frozen_string_literal: true

# :nocov:
module Primer
  module Accessibility
    # Skip axe checks for components that should be tested as part of a larger component.
    # Do not add to this list for any other reason!
    IGNORED_PREVIEWS = %w[
      Primer::Beta::MarkdownPreview
      Primer::Beta::AutoCompleteItemPreview
    ].freeze
  end
end
# :nocov:
