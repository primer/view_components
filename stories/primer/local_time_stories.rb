# frozen_string_literal: true

class Primer::LocalTimeStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:local_time) do
    controls do
      date(:datetime, DateTime.now)

      select(:weekday, Primer::LocalTime::TEXT_TYPE_OPTIONS, Primer::LocalTime::DEFAULT_TEXT_TYPE)
      select(:year, Primer::LocalTime::DIGIT_TYPE_OPTIONS, Primer::LocalTime::DEFAULT_DIGIT_TYPE)
      select(:month, Primer::LocalTime::TEXT_TYPE_OPTIONS, Primer::LocalTime::DEFAULT_TEXT_TYPE)
      select(:day, Primer::LocalTime::DIGIT_TYPE_OPTIONS, Primer::LocalTime::DEFAULT_DIGIT_TYPE)
      select(:hour, Primer::LocalTime::DIGIT_TYPE_OPTIONS, Primer::LocalTime::DEFAULT_DIGIT_TYPE)
      select(:minute, Primer::LocalTime::DIGIT_TYPE_OPTIONS, Primer::LocalTime::DEFAULT_DIGIT_TYPE)
      select(:second, Primer::LocalTime::DIGIT_TYPE_OPTIONS, Primer::LocalTime::DEFAULT_DIGIT_TYPE)
      select(:time_zone_name, Primer::LocalTime::TEXT_TYPE_OPTIONS, Primer::LocalTime::DEFAULT_TEXT_TYPE)
    end
  end
end
