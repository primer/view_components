# frozen_string_literal: true

require "test_helper"

class PrimerLocalTimeTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline Primer::LocalTime.new(datetime: "2014-06-01T13:05:07Z")

    assert_selector("local-time[datetime=\"2014-06-01T13:05:07Z\"][year=\"numeric\"][month=\"short\"][day=\"numeric\"][hour=\"numeric\"][minute=\"numeric\"][second=\"numeric\"]", text: "June 1, 2014 13:05 +00:00")
  end

  def test_all_options
    render_inline Primer::LocalTime.new(
      datetime: "2016-06-01T13:05:07Z",
      weekday: "long",
      year: "2-digit",
      month: "long",
      day: "2-digit",
      hour: "2-digit",
      minute: "2-digit",
      second: "2-digit",
      time_zone_name: "Iceland"
    )

    assert_selector("local-time[weekday=\"long\"][datetime=\"2016-06-01T13:05:07Z\"][year=\"2-digit\"][month=\"long\"][day=\"2-digit\"][hour=\"2-digit\"][minute=\"2-digit\"][second=\"2-digit\"][time-zone-name=\"Iceland\"]", text: "June 1, 2016 13:05 +00:00")
  end
end
