# frozen_string_literal: true

# @label LocalTime
class LocalTimePreview < ViewComponent::Preview
  # @param datetime datetime-local
  # @param weekday [Symbol] select [long, short]
  # @param month [Symbol] select [long, short]
  # @param year [Symbol] select [numeric, "2-digit"]
  # @param day [Symbol] select [numeric, "2-digit"]
  # @param hour [Symbol] select [numeric, "2-digit"]
  # @param minute [Symbol] select [numeric, "2-digit"]
  # @param second [Symbol] select [numeric, "2-digit"]
  # @param time_zone_name [Symbol] select [long, short]
  def default(datetime: DateTime.now.to_s, weekday: :short, month: :short, year: :numeric, day: :numeric, hour: :numeric, minute: :numeric, second: :numeric, time_zone_name: :short)
    render(Primer::LocalTime.new(datetime: DateTime.parse(datetime), weekday: weekday, month: month, year: year, day: day, hour: hour, minute: minute, second: second, time_zone_name: time_zone_name))
  end

  # @label With replaceable content
  #
  # @param initial_text [String] textarea
  def with_contents(initial_text: "This will be replaced as soon as the web component loads.")
    render Primer::LocalTime.new(datetime: DateTime.parse("2014-04-01T16:30:00-08:00"), initial_text: initial_text)
  end
end
