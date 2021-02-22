# frozen_string_literal: true

module Primer
  # A basic wrapper for the "<time-ago>" element.
  class TimeAgoComponent < Primer::Component
    def initialize(time:, micro: false, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:datetime] = time.utc.iso8601
      @system_arguments[:classes] = class_names("no-wrap", @system_arguments[:classes])
      @system_arguments[:tag] = "time-ago"
      @system_arguments[:format] = "micro" if micro
      @content = if micro
                   micro_time_ago(time)
                 else
                   time.in_time_zone.strftime("%b %-d, %Y")
                 end
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { @content }
    end

    private

    def micro_time_ago(time)
      seconds_ago = Time.current - time

      if seconds_ago < 1.minute
        "1m"
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
