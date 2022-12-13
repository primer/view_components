# frozen_string_literal: true

# rubocop:disable Primer/ComponentNameMigration

module Primer
  # @label TimeAgoComponent
  class TimeAgoComponentPreview < ViewComponent::Preview
    # @label Playground
    #
    # @param time datetime-local
    # @param micro [Boolean] toggle
    def playground(time: Time.zone.now.to_s, micro: false)
      render(Primer::TimeAgoComponent.new(time: DateTime.parse(time), micro: micro))
    end

    # @param time datetime-local
    # @param micro [Boolean] toggle
    def default(time: Time.zone.now.to_s, micro: false)
      render(Primer::TimeAgoComponent.new(time: DateTime.parse(time), micro: micro))
    end

    def micro
      render(Primer::TimeAgoComponent.new(time: Time.zone.now, micro: true))
    end
  end
end
# rubocop:enable Primer/ComponentNameMigration
