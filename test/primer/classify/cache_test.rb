# frozen_string_literal: true

require "test_helper"

class PrimerClassifyCacheTest < Minitest::Test
  def test_clear_clears_the_cache
    Primer::Classify::Cache.clear!

    assert_empty Primer::Classify::Cache::LOOKUP
  ensure
    Primer::Classify::Cache.preload!
  end
end
