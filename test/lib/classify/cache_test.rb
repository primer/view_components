# frozen_string_literal: true

require "test_helper"

class PrimerClassifyCacheTest < Minitest::Test
  def test_clear_clears_the_cache
    Primer::Classify::Cache.instance.clear!

    assert Primer::Classify::Cache.instance.empty?
  end
end
