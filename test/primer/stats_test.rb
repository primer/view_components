# frozen_string_literal: true

require "test_helper"
require "primer/view_components/stats"

class Primer::ViewComponents::StatsTest < Minitest::Test
  def test_accessibility_tags_count
    # reference: https://github.com/primer/view_components/pull/833
    assert_equal 17, Primer::ViewComponents::Stats.accessibility_tags_count
  end
end
