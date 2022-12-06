# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaLocalTimeTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline Primer::Alpha::LocalTime.new(datetime: DateTime.parse("2014-06-01T13:05:07Z"))

    assert_selector("relative-time[data-view-component][threshold=\"PT0S\"][prefix=\"\"][datetime=\"2014-06-01T13:05:07+00:00\"][year=\"numeric\"][month=\"short\"][day=\"numeric\"][hour=\"numeric\"][minute=\"numeric\"][second=\"numeric\"]", text: "June 1, 2014 13:05 +00:00")
  end

  def test_all_options
    render_inline Primer::Alpha::LocalTime.new(
      datetime: DateTime.parse("2016-06-01T13:05:07Z"),
      weekday: :long,
      year: :"2-digit",
      month: :long,
      day: :"2-digit",
      hour: :"2-digit",
      minute: :"2-digit",
      second: :"2-digit",
      time_zone_name: :long
    )

    assert_selector("relative-time[data-view-component][threshold=\"PT0S\"][prefix=\"\"][weekday=\"long\"][datetime=\"2016-06-01T13:05:07+00:00\"][year=\"2-digit\"][month=\"long\"][day=\"2-digit\"][hour=\"2-digit\"][minute=\"2-digit\"][second=\"2-digit\"][time-zone-name=\"long\"]", text: "June 1, 2016 13:05 +00:00")
  end

  def test_contents
    render_inline Primer::Alpha::LocalTime.new(datetime: DateTime.parse("2014-06-01T13:05:07Z"), initial_text: "2014/06/01 13:05")

    assert_selector("relative-time[data-view-component][threshold=\"PT0S\"][prefix=\"\"][datetime=\"2014-06-01T13:05:07+00:00\"][year=\"numeric\"][month=\"short\"][day=\"numeric\"][hour=\"numeric\"][minute=\"numeric\"][second=\"numeric\"]", text: "2014/06/01 13:05")
  end
end
