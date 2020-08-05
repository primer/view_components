# frozen_string_literal: true

module Primer
  class TimelineItemComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :badge, class_name: "TimelineItemBadge"
    with_slot :body, class_name: "TimelineItemBody"

    attr_reader :kwargs
    def initialize(**kwargs)
      @kwargs = kwargs
      @kwargs[:tag] = :div
      @kwargs[:classes] = class_names(
        "TimelineItem",
        kwargs[:classes]
      )
    end

    def render?
      badge.present? || body.present?
    end

    class TimelineItemBadge < Primer::Slot
      attr_reader :kwargs
      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:tag] = :div
        @kwargs[:classes] = class_names(
          "TimelineItem-badge",
          kwargs[:classes]
        )
      end
    end

    class TimelineItemBody < Primer::Slot
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
