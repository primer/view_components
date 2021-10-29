# frozen_string_literal: true

require "test_helper"

class PrimerClassifyCacheTest < Minitest::Test
  def test_clear_clears_the_cache
    Primer::Classify::Cache.instance.clear!
    Primer::Classify::AttrCache.instance.clear!

    assert Primer::Classify::Cache.instance.empty?
    assert Primer::Classify::AttrCache.instance.empty?
  ensure
    Primer::Classify::AttrCache.instance.preload!
  end

  def test_evicts_entries
    # rubocop:disable Style/RedundantFetchBlock
    cache = Primer::Classify::Cache.instance
    lookup = cache.instance_variable_get(:@lookup)

    cache.max_size = 3

    cache.fetch(:foo) { :foo }
    cache.fetch(:bar) { :bar }
    cache.fetch(:baz) { :baz }

    assert_equal cache.size, 3
    assert_includes lookup, [:foo].hash

    cache.fetch(:boo) { :boo }

    assert_equal cache.size, 3
    assert_includes lookup, [:bar].hash
    assert_includes lookup, [:baz].hash
    assert_includes lookup, [:boo].hash
    refute_includes lookup, [:foo].hash

    cache.max_size = Rails.application.config.primer_view_components.max_classify_cache_size
    # rubocop:enable Style/RedundantFetchBlock
  end

  def test_notifies_on_cache_hits_and_misses
    hits = 0
    misses = 0

    hit_sub = ActiveSupport::Notifications.subscribe("primer_view_components.classify_cache.hit") do
      hits += 1
    end

    miss_sub = ActiveSupport::Notifications.subscribe("primer_view_components.classify_cache.miss") do
      misses += 1
    end

    Primer::Classify::Cache.instance.clear!
    Primer::Classify.call(classes: "m-1")
    Primer::Classify.call(classes: "m-1")

    assert_equal hits, 1
    assert_equal misses, 1
  ensure
    ActiveSupport::Notifications.unsubscribe(hit_sub) if hit_sub
    ActiveSupport::Notifications.unsubscribe(miss_sub) if miss_sub
  end
end
