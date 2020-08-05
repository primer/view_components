# frozen_string_literal: true

module Primer
  class TimelineItemComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :avatar, class_name: "TimelineItemAvatar"
    with_slot :badge, class_name: "TimelineItemBadge"
    with_slot :body, class_name: "TimelineItemBody"

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
      avatar.present? || badge.present? || body.present?
    end

    class TimelineItemAvatar < Primer::Slot
      attr_reader :kwargs
      def initialize(**kwargs)
        @kwargs = kwargs
        @kwargs[:tag] = :div
        @kwargs[:classes] = class_names(
          "TimelineItem-avatar",
          kwargs[:classes]
        )
      end
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
