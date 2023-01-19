# frozen_string_literal: true

module Primer
  module Beta
    # Formats a timestamp as a localized string or as relative text that auto-updates in the user's browser.
    class RelativeTime < Primer::Component
      status :beta

      TENSE_DEFAULT = :auto
      TENSE_OPTIONS = [TENSE_DEFAULT, :past, :future].freeze

      FORMAT_DEFAULT = :auto
      FORMAT_OPTIONS = [FORMAT_DEFAULT, :micro, :elapsed].freeze

      FORMAT_STYLE_DEFAULT = nil
      FORMAT_STYLE_OPTIONS = [FORMAT_STYLE_DEFAULT, :long, :short, :narrow].freeze

      SECOND_DEFAULT = nil
      SECOND_MAPPINGS = {
        SECOND_DEFAULT => nil,
        :numeric => "numeric",
        :two_digit => "2-digit"
      }.freeze
      SECOND_OPTIONS = SECOND_MAPPINGS.keys

      MINUTE_DEFAULT = nil
      MINUTE_MAPPINGS = {
        MINUTE_DEFAULT => nil,
        :numeric => "numeric",
        :two_digit => "2-digit"
      }.freeze
      MINUTE_OPTIONS = MINUTE_MAPPINGS.keys

      HOUR_DEFAULT = nil
      HOUR_MAPPINGS = {
        HOUR_DEFAULT => nil,
        :numeric => "numeric",
        :two_digit => "2-digit"
      }.freeze
      HOUR_OPTIONS = HOUR_MAPPINGS.keys

      WEEKDAY_DEFAULT = nil
      WEEKDAY_OPTIONS = [WEEKDAY_DEFAULT, :long, :short, :narrow].freeze

      DAY_DEFAULT = nil
      DAY_MAPPINGS = {
        DAY_DEFAULT => nil,
        :numeric => "numeric",
        :two_digit => "2-digit"
      }.freeze
      DAY_OPTIONS = DAY_MAPPINGS.keys

      MONTH_DEFAULT = nil
      MONTH_MAPPINGS = {
        DAY_DEFAULT => nil,
        :numeric => "numeric",
        :two_digit => "2-digit",
        :short => "short",
        :long => "long",
        :narrow => "narrow"
      }.freeze
      MONTH_OPTIONS = MONTH_MAPPINGS.keys

      YEAR_DEFAULT = nil
      YEAR_MAPPINGS = {
        DAY_DEFAULT => nil,
        :numeric => "numeric",
        :two_digit => "2-digit"
      }.freeze
      YEAR_OPTIONS = YEAR_MAPPINGS.keys

      TIMEZONENAME_DEFAULT = nil
      TIMEZONE_MAPPINGS = {
        DAY_DEFAULT => nil,
        :long => "long",
        :short => "short",
        :short_offset => "shortOffset",
        :long_offset => "longOffset",
        :short_generic => "shortGeneric",
        :long_generic => "longGeneric"
      }.freeze
      TIMEZONENAME_OPTIONS = TIMEZONE_MAPPINGS.keys

      PRECISION_DEFAULT = nil
      PRECISION_OPTIONS = [PRECISION_DEFAULT, :second, :minute, :hour, :day, :month, :year].freeze

      # @example Default
      #   <%= render(Primer::Beta::RelativeTime.new(datetime: Time.at(628232400))) %>
      #
      # @example Past Time
      #   <%= render(Primer::Beta::RelativeTime.new(datetime: Time.at(628232400), tense: :past)) %>
      #
      # @example Elapsed Time
      #   <%= render(Primer::Beta::RelativeTime.new(datetime: Time.at(628232400), format: :elapsed)) %>
      #
      # @param datetime [Time] The time to be formatted.
      # @param tense [Symbol] Which tense to use. <%= one_of(Primer::Beta::RelativeTime::TENSE_OPTIONS) %>
      # @param prefix [sring] What to prefix the relative ime display with.
      # @param second [Symbol] What format seconds should take. <%= one_of(Primer::Beta::RelativeTime::SECOND_OPTIONS) %>
      # @param minute [Symbol] What format minues should take. <%= one_of(Primer::Beta::RelativeTime::MINUTE_OPTIONS) %>
      # @param hour [Symbol] What format hours should take. <%= one_of(Primer::Beta::RelativeTime::HOUR_OPTIONS) %>
      # @param weekday [Symbol] What format weekdays should take. <%= one_of(Primer::Beta::RelativeTime::WEEKDAY_OPTIONS) %>
      # @param day [Symbol] What format days should take. <%= one_of(Primer::Beta::RelativeTime::DAY_OPTIONS) %>
      # @param month [Symbol] What format months should take. <%= one_of(Primer::Beta::RelativeTime::MONTH_OPTIONS) %>
      # @param year [Symbol] What format years should take. <%= one_of(Primer::Beta::RelativeTime::YEAR_OPTIONS) %>
      # @param time_zone_name [Symbol] What format the time zone should take. <%= one_of(Primer::Beta::RelativeTime::TIMEZONENAME_OPTIONS) %>
      # @param threshold [string] The threshold, in ISO-8601 'durations' format, at which relative time displays become absolute.
      # @param precision [Symbol] The precision elapsed time should display. <%= one_of(Primer::Beta::RelativeTime::PRECISION_OPTIONS) %>
      # @param format [Symbol] The format the display should take. <%= one_of(Primer::Beta::RelativeTime::FORMAT_OPTIONS) %>
      # @param format_style [Symbol] The format the display should take. <%= one_of(Primer::Beta::RelativeTime::FORMAT_STYLE_OPTIONS) %>
      # @param lang [string] The language to use.
      # @param title [string] Provide a custom title to the element.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        datetime:,
        tense: TENSE_DEFAULT,
        prefix: nil,
        second: SECOND_DEFAULT,
        minute: MINUTE_DEFAULT,
        hour: HOUR_DEFAULT,
        weekday: WEEKDAY_DEFAULT,
        day: DAY_DEFAULT,
        month: MONTH_DEFAULT,
        year: YEAR_DEFAULT,
        time_zone_name: TIMEZONENAME_DEFAULT,
        threshold: nil,
        precision: PRECISION_DEFAULT,
        format: nil,
        format_style: nil,
        lang: nil,
        title: nil,
        **system_arguments
      )
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = "relative-time"
        @system_arguments[:tense] = tense if tense.present?
        @system_arguments[:prefix] = prefix if prefix.present?
        @system_arguments[:second] = fetch_or_fallback(SECOND_OPTIONS, second, SECOND_DEFAULT) if second.present?
        @system_arguments[:minute] = fetch_or_fallback(MINUTE_OPTIONS, minute, MINUTE_DEFAULT) if minute.present?
        @system_arguments[:hour] = fetch_or_fallback(HOUR_OPTIONS, hour, HOUR_DEFAULT) if hour.present?
        @system_arguments[:weekday] = fetch_or_fallback(WEEKDAY_OPTIONS, weekday, WEEKDAY_DEFAULT) if weekday.present?
        @system_arguments[:day] = fetch_or_fallback(DAY_OPTIONS, day, DAY_DEFAULT) if day.present?
        @system_arguments[:month] = fetch_or_fallback(MONTH_DEFAULT, month, MONTH_DEFAULT) if month.present?
        @system_arguments[:year] = fetch_or_fallback(YEAR_OPTIONS, year, YEAR_DEFAULT) if year.present?
        @system_arguments[:"time-zone-name"] = fetch_or_fallback(TIMEZONENAME_OPTIONS, time_zone_name, TIMEZONENAME_DEFAULT) if time_zone_name.present?
        @system_arguments[:threshold] = threshold if threshold.present?
        @system_arguments[:precision] = precision if precision.present?
        @system_arguments[:title] = title if title.present?
        @system_arguments[:lang] = lang if lang.present?
        @system_arguments[:format] = fetch_or_fallback(FORMAT_OPTIONS, format, FORMAT_DEFAULT) if format.present?
        @system_arguments[:"format-style"] = format_style if format_style.present?
        if datetime.present? && datetime.respond_to?(:iso8601)
          @datetime = datetime
          @system_arguments[:datetime] = datetime.iso8601
        elsif datetime.present?
          @datetime = Time.iso8601 datetime
          @system_arguments[:datetime] = @datetime
        end
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments).with_content(@datetime.strftime("%B %-d, %Y %H:%M")))
      end
    end
  end
end
