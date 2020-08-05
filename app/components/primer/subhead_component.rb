# frozen_string_literal: true

# This component consists of a .Subhead container, which has a light gray bottom border.

# Use a heading element whenever possible as they can be
# used as navigation for assistive technologies, and avoid skipping levels.

# ## Basic example

# The `Primer::SubheadComponent` can take the following arguments:

# 1. `heading` (string). The heading to be rendered.
# 2. `actions` (content). Slot to render any actions to the right of heading.
# 3. `description` (string). Slot to render description under the heading.

# ```erb
# <%= Primer::SubheadComponent.new(heading: "Hello world")) do |component| %>
#   <% component.slot(:actions) do %>
#     My Actions
#   <% end %>
# <% end %>
# ```
module Primer
  class SubheadComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :heading, class_name: "Heading"
    with_slot :actions, class_name: "Actions"
    with_slot :description, class_name: "Description"

    def initialize(spacious: false, hide_border: false, **kwargs)
      @kwargs = kwargs

      @kwargs[:tag] = :div
      @kwargs[:classes] =
        class_names(
          @kwargs[:classes],
          "Subhead hx_Subhead--responsive",
          "Subhead--spacious": spacious,
          "border-bottom-0": hide_border
        )
      @kwargs[:mb] ||= hide_border ? 0 : nil
    end

    def render?
      heading.present?
    end

    class Heading < ViewComponent::Slot
      include ClassNameHelper

      attr_reader :kwargs

      def initialize(danger: false, **kwargs)
        @kwargs = kwargs
        @kwargs[:tag] ||= :div
        @kwargs[:classes] = class_names(
          @kwargs[:classes],
          "Subhead-heading",
          "Subhead-heading--danger": danger
        )
      end
    end

    class Actions < ViewComponent::Slot
      include ClassNameHelper

      attr_reader :kwargs

      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:tag] = :div
        @kwargs[:classes] = class_names(@kwargs[:classes], "Subhead-actions")
      end
    end

    class Description < ViewComponent::Slot
      include ClassNameHelper

      attr_reader :kwargs

      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:tag] = :div
        @kwargs[:classes] = class_names(@kwargs[:classes], "Subhead-description")
      end
    end
  end
end
