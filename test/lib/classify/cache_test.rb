# frozen_string_literal: true

require "test_helper"

class PrimerClassifyCacheTest < Minitest::Test
  def test_clear_clears_the_cache
    Primer::Classify::Cache.instance.clear!

    assert_empty Primer::Classify::Cache.instance.instance_variable_get(:@lookup)
  ensure
    Primer::Classify::Cache.instance.preload!
  end
end
