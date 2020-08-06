# frozen_string_literal: true

module Primer
  class TimelineItemComponent < Primer::Component
    include ViewComponent::Slotable

    with_slot :avatar, class_name: "Avatar"
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
      avatar.present? || badge.present? || body.present?
    end

    class Avatar < Primer::Slot
      attr_reader :kwargs, :alt, :src, :size, :square
      def initialize(alt: nil, src: nil, size: 40, square: true, **kwargs)
        @alt = alt
        @src = src
        @size = size
        @square = square

        @kwargs = kwargs
        @kwargs[:tag] = :div
        @kwargs[:classes] = class_names(
          "TimelineItem-avatar",
          kwargs[:classes]
        )
      end
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
