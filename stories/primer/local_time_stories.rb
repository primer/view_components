# frozen_string_literal: true

class Primer::LocalTimeStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:local_time) do
    constructor(
      datetime: date(Time.current),

      weekday: select(Primer::LocalTime::TEXT_TYPE_OPTIONS, Primer::LocalTime::DEFAULT_TEXT_TYPE),
      year: select(Primer::LocalTime::DIGIT_TYPE_OPTIONS, Primer::LocalTime::DEFAULT_DIGIT_TYPE),
      month: select(Primer::LocalTime::TEXT_TYPE_OPTIONS, Primer::LocalTime::DEFAULT_TEXT_TYPE),
      day: select(Primer::LocalTime::DIGIT_TYPE_OPTIONS, Primer::LocalTime::DEFAULT_DIGIT_TYPE),
      hour: select(Primer::LocalTime::DIGIT_TYPE_OPTIONS, Primer::LocalTime::DEFAULT_DIGIT_TYPE),
      minute: select(Primer::LocalTime::DIGIT_TYPE_OPTIONS, Primer::LocalTime::DEFAULT_DIGIT_TYPE),
      second: select(Primer::LocalTime::DIGIT_TYPE_OPTIONS, Primer::LocalTime::DEFAULT_DIGIT_TYPE),
      time_zone_name: select(Primer::LocalTime::TEXT_TYPE_OPTIONS, Primer::LocalTime::DEFAULT_TEXT_TYPE)
    )
  end
end
