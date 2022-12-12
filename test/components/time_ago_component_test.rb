# frozen_string_literal: true

require "components/test_helper"
require "timecop"

class PrimerTimeAgoComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_time_ago_element
    render_inline(Primer::TimeAgoComponent.new(time: Time.zone.now))

    assert_selector("relative-time[tense=\"past\"][data-view-component][datetime][class]", count: 1)
  end

  def test_reflects_datetime_attr_and_contents_based_on_date
    render_inline(Primer::TimeAgoComponent.new(time: Time.utc(2021, 1, 1, 9, 10)))

    assert_selector("relative-time[tense=\"past\"][data-view-component][datetime=\"2021-01-01T09:10:00Z\"]", count: 1, text: "Jan 1, 2021")
  end

  def test_sets_contents_to_short_representation_with_micro_eq_true
    Timecop.freeze("2021-01-30T15:00:00Z") do
      render_inline(Primer::TimeAgoComponent.new(time: Time.utc(2021, 1, 1, 9, 10), micro: true))

      assert_selector("relative-time[tense=\"past\"][data-view-component][datetime=\"2021-01-01T09:10:00Z\"]", count: 1, text: "29d")
    end
  end

  def test_returns_number_of_mins_ago_in_micro_format
    Timecop.freeze("2021-01-01T09:50:00Z") do
      render_inline(Primer::TimeAgoComponent.new(time: Time.utc(2021, 1, 1, 9, 10), micro: true))

      assert_selector("relative-time[tense=\"past\"][data-view-component][datetime=\"2021-01-01T09:10:00Z\"]", count: 1, text: "40m")
    end
  end

  def test_returns_number_of_hours_ago_in_micro_format
    Timecop.freeze("2021-01-01T15:00:00Z") do
      render_inline(Primer::TimeAgoComponent.new(time: Time.utc(2021, 1, 1, 9, 10), micro: true))

      assert_selector("relative-time[tense=\"past\"][data-view-component][datetime=\"2021-01-01T09:10:00Z\"]", count: 1, text: "5h")
    end
  end

  def test_returns_number_of_days_ago_in_micro_format
    Timecop.freeze("2021-09-30T15:00:00Z") do
      render_inline(Primer::TimeAgoComponent.new(time: Time.utc(2021, 1, 1, 9, 10), micro: true))

      assert_selector("relative-time[tense=\"past\"][data-view-component][datetime=\"2021-01-01T09:10:00Z\"]", count: 1, text: "d")
    end
  end

  def test_returns_number_of_years_ago_in_micro_format
    Timecop.freeze("2037-09-30T15:00:00Z") do
      render_inline(Primer::TimeAgoComponent.new(time: Time.utc(2021, 1, 1, 9, 10), micro: true))

      assert_selector("relative-time[tense=\"past\"][data-view-component][datetime=\"2021-01-01T09:10:00Z\"]", count: 1, text: "16y")
    end
  end
end
