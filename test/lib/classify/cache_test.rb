# frozen_string_literal: true

require "test_helper"

class PrimerClassifyCacheTest < Minitest::Test
  def test_clear_clears_the_cache
    Primer::Classify::Cache.instance.clear!

    assert Primer::Classify::Cache.instance.empty?
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
end
