# frozen_string_literal: true

module Primer
  class TimelineItemComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :badge, class_name: "Badge"
    with_slot :body, class_name: "Body"

    attr_reader :kwargs
    def initialize(condensed: false, **kwargs)
      @kwargs = kwargs
      @kwargs[:tag] = :div
      @kwargs[:classes] = class_names(
        "TimelineItem",
        condensed ? "TimelineItem--condensed" : "",
        kwargs[:classes]
      )
    end

    def render?
      badge.present? || body.present?
    end

    class Badge < Primer::Slot
      attr_reader :kwargs, :icon
      def initialize(icon: nil, **kwargs)
        @icon = icon

        @kwargs = kwargs
        @kwargs[:tag] = :div
        @kwargs[:classes] = class_names(
          "TimelineItem-badge",
          kwargs[:classes]
        )
      end
    end

    class Body < Primer::Slot
      attr_reader :kwargs
      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:tag] = :div
        @kwargs[:classes] = class_names(
          "TimelineItem-body",
          kwargs[:classes]
        )
      end
    end
  end
end
