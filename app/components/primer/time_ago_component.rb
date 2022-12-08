# frozen_string_literal: true

module Primer
  # Use `TimeAgo` to display a time relative to how long ago it was. This component requires JavaScript.
  class TimeAgoComponent < Primer::Component
    warn_on_deprecated_slot_setter
    status :beta

    # @example Default
    #   <%= render(Primer::TimeAgoComponent.new(time: Time.at(628232400))) %>
    #
    # @param time [Time] The time to be formatted
    # @param micro [Boolean] If true then the text will be formatted in "micro" mode, using as few characters as possible
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(time:, micro: false, **system_arguments)
      @system_arguments = deny_tag_argument(**system_arguments)
      @system_arguments[:datetime] = time.utc.iso8601
      @system_arguments[:classes] = class_names("no-wrap", @system_arguments[:classes])
      @system_arguments[:tag] = "relative-time"
      @system_arguments[:tense] = "past"
      @system_arguments[:format] = "micro" if micro
      @time = time
      @micro = micro
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { time_in_words }
    end

    private

    def time_in_words
      return @time.in_time_zone.strftime("%b %-d, %Y") unless @micro

      seconds_ago = Time.current - @time

      if seconds_ago < 1.minute
        # :nocov:
        "1m"
        # :nocov:
      elsif seconds_ago >= 1.minute && seconds_ago < 1.hour
        "#{(seconds_ago / 60).floor}m"
      elsif seconds_ago >= 1.hour && seconds_ago < 1.day
        "#{(seconds_ago / 60 / 60).floor}h"
      elsif seconds_ago >= 1.day && seconds_ago < 1.year
        "#{(seconds_ago / 60 / 60 / 24).floor}d"
      elsif seconds_ago >= 1.year
        "#{(seconds_ago / 60 / 60 / 24 / 365).floor}y"
      end
    end
  end
end
