# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module Beta
    # @label RelativeTime
    class RelativeTimePreview < ViewComponent::Preview
      # @label Playground
      # @param datetime datetime-local
      # @param tense [Symbol] select [~, auto, past, future]
      # @param prefix [String] text
      # @param second [Symbol] select [~, numeric, two_digit]
      # @param minute [Symbol] select [~, numeric, two_digit]
      # @param hour [Symbol] select [~, numeric, two_digit]
      # @param weekday [Symbol] select [~, long, short, narrow]
      # @param day [Symbol] select [~, numeric, two_digit]
      # @param month [Symbol] select [~, numeric, two_digit, short, long, narrow]
      # @param year [Symbol] select [~, numeric, two_digit]
      # @param time_zone_name [Symbol] select [~, long, short, short_offset, long_offset, short_generic, long_generic]
      # @param precision [Symbol] select [~, second, minute, hour, day, month, year]
      # @param format [Symbol] select [~, auto, micro, elapsed]
      # @param format_style [Symbol] select [~, long, short, narrow]
      # @param lang [String] text
      # @param title [String] text
      def playground(
        tense: nil,
        prefix: nil,
        second: nil,
        minute: nil,
        hour: nil,
        weekday: nil,
        day: nil,
        month: nil,
        year: nil,
        time_zone_name: nil,
        threshold: nil,
        precision: nil,
        format: nil,
        format_style: nil,
        datetime: Time.utc(2020, 1, 1, 0, 0, 0),
        lang: nil,
        title: nil
      )
        render(Primer::Beta::RelativeTime.new(
                 tense: tense,
                 prefix: prefix,
                 second: second,
                 minute: minute,
                 hour: hour,
                 weekday: weekday,
                 day: day,
                 month: month,
                 year: year,
                 time_zone_name: time_zone_name,
                 threshold: threshold,
                 precision: precision,
                 format: format,
                 format_style: format_style,
                 datetime: datetime,
                 lang: lang,
                 title: title
               ))
      end

      # @label Default
      # @param datetime datetime-local
      # @param tense [Symbol] select [~, auto, past, future]
      # @param prefix [String] text
      # @param second [Symbol] select [~, numeric, two_digit]
      # @param minute [Symbol] select [~, numeric, two_digit]
      # @param hour [Symbol] select [~, numeric, two_digit]
      # @param weekday [Symbol] select [~, long, short, narrow]
      # @param day [Symbol] select [~, numeric, two_digit]
      # @param month [Symbol] select [~, numeric, two_digit, short, long, narrow]
      # @param year [Symbol] select [~, numeric, two_digit]
      # @param time_zone_name [Symbol] select [~, long, short, short_offset, long_offset, short_generic, long_generic]
      # @param precision [Symbol] select [~, second, minute, hour, day, month, year]
      # @param format [Symbol] select [~, auto, micro, elapsed]
      # @param format_style [Symbol] select [~, long, short, narrow]
      # @param lang [String] text
      # @param title [String] text
      def default(
        tense: nil,
        prefix: nil,
        second: nil,
        minute: nil,
        hour: nil,
        weekday: nil,
        day: nil,
        month: nil,
        year: nil,
        time_zone_name: nil,
        threshold: nil,
        precision: nil,
        format: nil,
        format_style: nil,
        datetime: Time.now.utc,
        lang: nil,
        title: nil
      )
        render(Primer::Beta::RelativeTime.new(
                 tense: tense,
                 prefix: prefix,
                 second: second,
                 minute: minute,
                 hour: hour,
                 weekday: weekday,
                 day: day,
                 month: month,
                 year: year,
                 time_zone_name: time_zone_name,
                 threshold: threshold,
                 precision: precision,
                 format: format,
                 format_style: format_style,
                 datetime: datetime,
                 lang: lang,
                 title: title
               ))
      end

      # @label Micro Format
      # @param datetime datetime-local
      # @param tense [Symbol] select [~, auto, past, future]
      # @param prefix [String] text
      # @param second [Symbol] select [~, numeric, two_digit]
      # @param minute [Symbol] select [~, numeric, two_digit]
      # @param hour [Symbol] select [~, numeric, two_digit]
      # @param weekday [Symbol] select [~, long, short, narrow]
      # @param day [Symbol] select [~, numeric, two_digit]
      # @param month [Symbol] select [~, numeric, two_digit, short, long, narrow]
      # @param year [Symbol] select [~, numeric, two_digit]
      # @param time_zone_name [Symbol] select [~, long, short, short_offset, long_offset, short_generic, long_generic]
      # @param precision [Symbol] select [~, second, minute, hour, day, month, year]
      # @param format_style [Symbol] select [~, long, short, narrow]
      # @param lang [String] text
      # @param title [String] text
      def micro_format(
        tense: nil,
        prefix: nil,
        second: nil,
        minute: nil,
        hour: nil,
        weekday: nil,
        day: nil,
        month: nil,
        year: nil,
        time_zone_name: nil,
        threshold: nil,
        precision: nil,
        format_style: nil,
        datetime: Time.now.iso8601,
        lang: nil,
        title: nil
      )
        render(Primer::Beta::RelativeTime.new(
                 tense: tense,
                 prefix: prefix,
                 second: second,
                 minute: minute,
                 hour: hour,
                 weekday: weekday,
                 day: day,
                 month: month,
                 year: year,
                 time_zone_name: time_zone_name,
                 threshold: threshold,
                 precision: precision,
                 format: :micro,
                 format_style: format_style,
                 datetime: datetime,
                 lang: lang,
                 title: title
               ))
      end

      # @label Recent Time
      # @param datetime datetime-local
      # @param tense [Symbol] select [~, auto, past, future]
      # @param prefix [String] text
      # @param second [Symbol] select [~, numeric, two_digit]
      # @param minute [Symbol] select [~, numeric, two_digit]
      # @param hour [Symbol] select [~, numeric, two_digit]
      # @param weekday [Symbol] select [~, long, short, narrow]
      # @param day [Symbol] select [~, numeric, two_digit]
      # @param month [Symbol] select [~, numeric, two_digit, short, long, narrow]
      # @param year [Symbol] select [~, numeric, two_digit]
      # @param time_zone_name [Symbol] select [~, long, short, short_offset, long_offset, short_generic, long_generic]
      # @param precision [Symbol] select [~, second, minute, hour, day, month, year]
      # @param format [Symbol] select [~, auto, micro, elapsed]
      # @param format_style [Symbol] select [~, long, short, narrow]
      # @param lang [String] text
      # @param title [String] text
      def recent_time(
        tense: nil,
        prefix: nil,
        second: nil,
        minute: nil,
        hour: nil,
        weekday: nil,
        day: nil,
        month: nil,
        year: nil,
        time_zone_name: nil,
        threshold: nil,
        precision: nil,
        format: nil,
        format_style: nil,
        datetime: Time.now.iso8601,
        lang: nil,
        title: nil
      )
        render(Primer::Beta::RelativeTime.new(
                 tense: tense,
                 prefix: prefix,
                 second: second,
                 minute: minute,
                 hour: hour,
                 weekday: weekday,
                 day: day,
                 month: month,
                 year: year,
                 time_zone_name: time_zone_name,
                 threshold: threshold,
                 precision: precision,
                 format: format,
                 format_style: format_style,
                 datetime: datetime,
                 lang: lang,
                 title: title
               ))
      end

      # @label Count Down Timer
      # @param datetime datetime-local
      # @param tense [Symbol] select [~, auto, past, future]
      # @param prefix [String] text
      # @param second [Symbol] select [~, numeric, two_digit]
      # @param minute [Symbol] select [~, numeric, two_digit]
      # @param hour [Symbol] select [~, numeric, two_digit]
      # @param weekday [Symbol] select [~, long, short, narrow]
      # @param year [Symbol] select [~, numeric, two_digit]
      # @param time_zone_name [Symbol] select [~, long, short, short_offset, long_offset, short_generic, long_generic]
      # @param precision [Symbol] select [~, second, minute, hour, day, month, year]
      # @param format_style [Symbol] select [~, long, short, narrow]
      # @param lang [String] text
      # @param title [String] text
      def count_down_timer(
        tense: nil,
        prefix: nil,
        second: nil,
        minute: nil,
        hour: nil,
        weekday: nil,
        year: nil,
        time_zone_name: nil,
        threshold: nil,
        precision: nil,
        format_style: nil,
        datetime: Time.utc(2038, 1, 19, 0o3, 14, 8),
        lang: nil,
        title: nil
      )
        render(Primer::Beta::RelativeTime.new(
                 tense: tense,
                 prefix: prefix,
                 second: second,
                 minute: minute,
                 hour: hour,
                 weekday: weekday,
                 year: year,
                 time_zone_name: time_zone_name,
                 threshold: threshold,
                 precision: precision,
                 format: :elapsed,
                 format_style: format_style,
                 datetime: datetime,
                 lang: lang,
                 title: title
               ))
      end
    end
  end
end
