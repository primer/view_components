# frozen_string_literal: true

# @label TimeAgoComponent
class TimeAgoComponentPreview < ViewComponent::Preview
  # @param time datetime-local
  # @param micro [Boolean] toggle
  def default(time: Time.zone.now.to_s, micro: false)
    render(Primer::TimeAgoComponent.new(time: DateTime.parse(time), micro: micro))
  end
end
