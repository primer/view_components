# frozen_string_literal: true

require "test_helper"
require "primer/view_components/stats"

class Primer::ViewComponents::StatsTest < Minitest::Test
  def test_accessibility_tags_count
    assert_equal 16, Primer::ViewComponents::Stats.accessibility_tags_count
  end
end
