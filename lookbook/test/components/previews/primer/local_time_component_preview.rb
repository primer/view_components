# frozen_string_literal: true

module Primer
  # no doc
  class LocalTimeComponentPreview < ViewComponent::Preview
    def default
      render(Primer::LocalTime.new(datetime: DateTime.parse("2014-04-01T16:30:00-08:00")))
    end

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

    def with_contents
      render Primer::LocalTime.new(datetime: DateTime.parse("2014-04-01T16:30:00-08:00")) do
        # :nocov:
        "This will be replaced"
        # :nocov:
      end
    end
  end
end
