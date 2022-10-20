# frozen_string_literal: true

require "lib/test_helper"

class PrimerOcticonCacheTest < Minitest::Test
  def test_preload_loads_octicon_cache
    Primer::Octicon::Cache.clear!
    assert_empty Primer::Octicon::Cache::LOOKUP
    Primer::Octicon::Cache.preload!
    assert_equal 20, Primer::Octicon::Cache::LOOKUP.size
  end

  def test_clear_clears_the_cache
    Primer::Octicon::Cache.clear!

    assert_empty Primer::Octicon::Cache::LOOKUP
  ensure
    Primer::Octicon::Cache.preload!
  end

  def test_get_key_returns_the_correct_key
    assert_equal({ symbol: :alert, size: :small }.hash, Primer::Octicon::Cache.get_key(symbol: :alert, size: :small))
    assert_equal({ symbol: :alert, size: :small, width: 20 }.hash, Primer::Octicon::Cache.get_key(symbol: :alert, size: :small, width: 20))
    assert_equal({ symbol: :alert, size: :small, height: 16, width: 20 }.hash, Primer::Octicon::Cache.get_key(symbol: :alert, size: :small, height: 16, width: 20))
  end

  def test_cache_evacuates_after_limit_reached
    Primer::Octicon::Cache.clear!
    Primer::Octicon::Cache.stub :limit, 3 do
      # Assert the limit is stubbed properly
      assert_equal 3, Primer::Octicon::Cache.limit
      assert_empty Primer::Octicon::Cache::LOOKUP

      # Preload the cache should be 20 items
      Primer::Octicon::Cache.preload!

      # Assert the cache size is 3 because the limit is 3
      assert_equal 3, Primer::Octicon::Cache::LOOKUP.size
    end
  end
end
