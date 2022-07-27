module Primer
  class TimeAgoComponentPreview < ViewComponent::Preview
    def default
      render(Primer::TimeAgoComponent.new(time: Time.new))
    end

    def micro
      render(Primer::TimeAgoComponent.new(time: Time.new, micro: true))
    end
  end
end
