# frozen_string_literal: true

module Primer
  class TimelineItemComponent < Primer::Beta::TimelineItem
    status :deprecated

    class BadgeComponent < Primer::Component
      status :deprecated
    end
  end
end
