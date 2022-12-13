# frozen_string_literal: true

# rubocop:disable Primer/ComponentNameMigration

module Primer
  # @label LocalTime
  class LocalTimeComponentPreview < ViewComponent::Preview
    # @param datetime datetime-local
    # @param weekday [Symbol] select [long, short]
    # @param month [Symbol] select [long, short]
    # @param year [Symbol] select [numeric, "2-digit"]
    # @param day [Symbol] select [numeric, "2-digit"]
    # @param hour [Symbol] select [numeric, "2-digit"]
    # @param minute [Symbol] select [numeric, "2-digit"]
    # @param second [Symbol] select [numeric, "2-digit"]
    # @param time_zone_name [Symbol] select [long, short]
    def playground(datetime: "2014-04-01T16:30:00-08:00", weekday: :short, month: :short, year: :numeric, day: :numeric, hour: :numeric, minute: :numeric, second: :numeric, time_zone_name: :short)
      render(Primer::LocalTime.new(datetime: DateTime.parse(datetime), weekday: weekday, month: month, year: year, day: day, hour: hour, minute: minute, second: second, time_zone_name: time_zone_name))
    end

    # @param datetime datetime-local
    # @param weekday [Symbol] select [long, short]
    # @param month [Symbol] select [long, short]
    # @param year [Symbol] select [numeric, "2-digit"]
    # @param day [Symbol] select [numeric, "2-digit"]
    # @param hour [Symbol] select [numeric, "2-digit"]
    # @param minute [Symbol] select [numeric, "2-digit"]
    # @param second [Symbol] select [numeric, "2-digit"]
    # @param time_zone_name [Symbol] select [long, short]
    def default(datetime: "2014-04-01T16:30:00-08:00", weekday: :short, month: :short, year: :numeric, day: :numeric, hour: :numeric, minute: :numeric, second: :numeric, time_zone_name: :short)
      render(Primer::LocalTime.new(datetime: DateTime.parse(datetime), weekday: weekday, month: month, year: year, day: day, hour: hour, minute: minute, second: second, time_zone_name: time_zone_name))
    end

    # @hidden
    def with_all_the_options
      render(Primer::LocalTime.new(
               datetime: DateTime.parse("2016-06-01T13:05:07Z"),
               weekday: :long,
               year: :"2-digit",
               month: :long,
               day: :"2-digit",
               hour: :"2-digit",
               minute: :"2-digit",
               second: :"2-digit",
               time_zone_name: :long
             ))
    end

    # @label With replaceable content
    #
    # @param initial_text [String] textarea
    def with_contents(initial_text: "This will be replaced")
      render Primer::LocalTime.new(datetime: DateTime.parse("2014-04-01T16:30:00-08:00"), initial_text: initial_text)
    end
  end
end
# rubocop:enable Primer/ComponentNameMigration
