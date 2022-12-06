# frozen_string_literal: true

module Primer
  module Alpha
    # Use `LocalTime` to format a date and time in the user's preferred locale format. This component requires JavaScript.
    class LocalTime < Primer::Component
      DEFAULT_DIGIT_TYPE = :numeric
      DIGIT_TYPE_OPTIONS = [DEFAULT_DIGIT_TYPE, :"2-digit"].freeze

      DEFAULT_TEXT_TYPE = :short
      TEXT_TYPE_OPTIONS = [DEFAULT_TEXT_TYPE, :long].freeze

      # @example Default
      #   <%= render(Primer::Alpha::LocalTime.new(datetime: DateTime.parse("2014-06-01T13:05:07Z"))) %>
      #
      # @example All the options
      #   <%= render(Primer::Alpha::LocalTime.new(datetime: DateTime.parse("2014-06-01T13:05:07Z"), weekday: :long, year: :"2-digit", month: :long, day: :"2-digit", hour: :"2-digit", minute: :"2-digit", second: :"2-digit", time_zone_name: :long)) %>
      #
      # @example With initial content
      #   <%= render(Primer::Alpha::LocalTime.new(datetime: DateTime.parse("2014-06-01T13:05:07Z"))) do %>
      #     <!-- This content will be replaced once the component connects -->
      #     2014/06/01 13:05
      #   <% end %>
      #
      # @param datetime [DateTime] The date to parse
      # @param initial_text [String] Text to render before component is initialized
      # @param weekday [Symbol] <%= one_of(Primer::Alpha::LocalTime::TEXT_TYPE_OPTIONS) %>
      # @param year [Symbol] <%= one_of(Primer::Alpha::LocalTime::DIGIT_TYPE_OPTIONS) %>
      # @param month [Symbol] <%= one_of(Primer::Alpha::LocalTime::TEXT_TYPE_OPTIONS) %>
      # @param day [Symbol] <%= one_of(Primer::Alpha::LocalTime::DIGIT_TYPE_OPTIONS) %>
      # @param hour [Symbol] <%= one_of(Primer::Alpha::LocalTime::DIGIT_TYPE_OPTIONS) %>
      # @param minute [Symbol] <%= one_of(Primer::Alpha::LocalTime::DIGIT_TYPE_OPTIONS) %>
      # @param second [Symbol] <%= one_of(Primer::Alpha::LocalTime::DIGIT_TYPE_OPTIONS) %>
      # @param time_zone_name [Symbol] <%= one_of(Primer::Alpha::LocalTime::TEXT_TYPE_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(datetime:, initial_text: nil, weekday: DEFAULT_TEXT_TYPE, year: DEFAULT_DIGIT_TYPE, month: DEFAULT_TEXT_TYPE, day: DEFAULT_DIGIT_TYPE, hour: DEFAULT_DIGIT_TYPE, minute: DEFAULT_DIGIT_TYPE, second: DEFAULT_DIGIT_TYPE, time_zone_name: DEFAULT_TEXT_TYPE, **system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)

        @datetime = datetime

        @system_arguments[:tag] = "relative-time"
        @system_arguments[:threshold] = "PT0S"
        @system_arguments[:prefix] = ""
        @system_arguments[:datetime] = datetime

        @initial_text = initial_text

        @system_arguments[:weekday] = fetch_or_fallback(TEXT_TYPE_OPTIONS, weekday, DEFAULT_TEXT_TYPE)
        @system_arguments[:year] = fetch_or_fallback(DIGIT_TYPE_OPTIONS, year, DEFAULT_DIGIT_TYPE)
        @system_arguments[:month] = fetch_or_fallback(TEXT_TYPE_OPTIONS, month, DEFAULT_TEXT_TYPE)
        @system_arguments[:day] = fetch_or_fallback(DIGIT_TYPE_OPTIONS, day, DEFAULT_DIGIT_TYPE)
        @system_arguments[:hour] = fetch_or_fallback(DIGIT_TYPE_OPTIONS, hour, DEFAULT_DIGIT_TYPE)
        @system_arguments[:minute] = fetch_or_fallback(DIGIT_TYPE_OPTIONS, minute, DEFAULT_DIGIT_TYPE)
        @system_arguments[:second] = fetch_or_fallback(DIGIT_TYPE_OPTIONS, second, DEFAULT_DIGIT_TYPE)
        @system_arguments[:"time-zone-name"] = fetch_or_fallback(TEXT_TYPE_OPTIONS, time_zone_name, DEFAULT_TEXT_TYPE)
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments).with_content(@initial_text || @datetime.strftime("%B %-d, %Y %H:%M %Z")))
      end
    end
  end
end
