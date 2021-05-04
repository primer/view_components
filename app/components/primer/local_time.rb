# frozen_string_literal: true

module Primer
  # Add a general description of component here
  # Add additional usage considerations or best practices that may aid the user to use the component correctly.
  # @accessibility Add any accessibility considerations
  class LocalTime < Primer::Component
    DEFAULT_DIGIT_TYPE = "numeric"
    DIGIT_TYPE_OPTIONS = [DEFAULT_DIGIT_TYPE, "2-digit"].freeze

    DEFAULT_TEXT_TYPE = "short"
    TEXT_TYPE_OPTIONS = [DEFAULT_TEXT_TYPE, "long"].freeze

    # @example Example goes here
    #
    #   <%= render(Primer::LocalTime.new(datetime: "2014-06-01T13:05:07Z")) %>
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(datetime:, weekday: DEFAULT_TEXT_TYPE, year: DEFAULT_DIGIT_TYPE, month: DEFAULT_TEXT_TYPE, day: DEFAULT_DIGIT_TYPE, hour: DEFAULT_DIGIT_TYPE, minute: DEFAULT_DIGIT_TYPE, second: DEFAULT_DIGIT_TYPE, time_zone_name: DEFAULT_TEXT_TYPE, **system_arguments)
      @system_arguments = system_arguments

      @datetime = datetime

      @system_arguments[:tag] = "local-time"
      @system_arguments[:datetime] = datetime

      @system_arguments[:weekday] = fetch_or_fallback(TEXT_TYPE_OPTIONS, weekday, DEFAULT_TEXT_TYPE)
      @system_arguments[:year] = fetch_or_fallback(DIGIT_TYPE_OPTIONS, year, DEFAULT_DIGIT_TYPE)
      @system_arguments[:month] = fetch_or_fallback(TEXT_TYPE_OPTIONS, month, DEFAULT_TEXT_TYPE)
      @system_arguments[:day] = fetch_or_fallback(DIGIT_TYPE_OPTIONS, day, DEFAULT_DIGIT_TYPE)
      @system_arguments[:hour] = fetch_or_fallback(DIGIT_TYPE_OPTIONS, hour, DEFAULT_DIGIT_TYPE)
      @system_arguments[:minute] = fetch_or_fallback(DIGIT_TYPE_OPTIONS, minute, DEFAULT_DIGIT_TYPE)
      @system_arguments[:second] = fetch_or_fallback(DIGIT_TYPE_OPTIONS, second, DEFAULT_DIGIT_TYPE)
      @system_arguments[:"time-zone-name"] = fetch_or_fallback(TEXT_TYPE_OPTIONS, time_zone_name, DEFAULT_TEXT_TYPE)
    end
  end
end
