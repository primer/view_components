# frozen_string_literal: true

##
# The `Primer::ProgressBarComponent` can take the following arguments:
#
# 1. `size` (string). Can be "small" or "large". Increases the height of the progress bar.
# 2. `percentage` (number). Used to set the width of the completed bar.
#
# ```ruby
#   <%= render(Primer::ProgressBarComponent.new(percentage: 50)) %>
# ```
##
module Primer
  class ProgressBarComponent < Primer::Component
    SIZE_DEFAULT = :default

    SIZE_MAPPINGS = {
      SIZE_DEFAULT => "",
      :small => "Progress--small",
      :large => "Progress--large",
    }.freeze

    SIZE_OPTIONS = SIZE_MAPPINGS.keys

    def initialize(size: SIZE_DEFAULT, percentage: 0, **kwargs)
      @kwargs = kwargs
      @kwargs[:classes] = class_names(
        @kwargs[:classes],
        "Progress",
        SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, SIZE_DEFAULT)]
      )
      @kwargs[:tag] = :span

      @percentage = percentage
    end
  end
end
