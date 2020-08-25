# frozen_string_literal: true

##
# Use progress components to visualize task completion.

## Basic example
#
# The `Primer::ProgressBarComponent` can take the following arguments:
#
# 1. `size` (string). Can be "small" or "large". Increases the height of the progress bar.
#
# The `Primer::ProgressBarComponent` uses the [Slots API](https://github.com/github/view_component#slots-experimental) and at least one slot is required for the component to render. Each slot accepts a `percentage` parameter, which is used to set the width of the completed bar.
#
# ```ruby
#   <%= render(Primer::ProgressBarComponent.new(size: :small)) do |component| %>
#     <% component.slot(:item, bg: :blue-4, percentage: 50) %>
#   <% end %>
# ```
##
module Primer
  class ProgressBarComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :item, collection: true, class_name: "Item"

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

    end

    def render?
      items.any?
    end

    class Item < ViewComponent::Slot
      include ClassNameHelper
      attr_reader :kwargs

      def initialize(percentage: 0, bg: :green, **kwargs)
        @percentage = percentage
        @kwargs = kwargs

        @kwargs[:tag] = :span
        @kwargs[:bg] = bg
        @kwargs[:style] = "width: #{@percentage}%;#{@kwargs[:style]}"
        @kwargs[:classes] = class_names("Progress-item", @kwargs[:classes])
      end
    end
  end
end
