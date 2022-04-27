# frozen_string_literal: true

module Primer
  # no doc
  class TimeAgoComponentPreview < ViewComponent::Preview
    def default
      render(Primer::TimeAgoComponent.new(time: Time.zone.now))
    end

    def micro
      render(Primer::TimeAgoComponent.new(time: Time.zone.now, micro: true))
    end
  end
end
