# frozen_string_literal: true

require "minitest/benchmark"
require "test_helper"

class BenchOcticons < Minitest::Benchmark
  def setup
    @options = {
      icon: :alert
    }
  end

  def bench_allocations_without_cache
    Primer::OcticonComponent.new(**@options)
    Primer::Octicon::Cache.clear!
    assert_allocations 50 do
      Primer::OcticonComponent.new(**@options)
    end
  ensure
    Primer::Octicon::Cache.preload!
  end

  def bench_allocations_with_cache
    Primer::Octicon::Cache.preload!
    assert_allocations 21 do
      Primer::OcticonComponent.new(**@options)
    end
  end

  private

  def assert_allocations(count)
    GC.disable
    total_start = GC.stat[:total_allocated_objects]
    yield
    total_end = GC.stat[:total_allocated_objects]
    GC.enable

    total = total_end - total_start

    assert_equal count, total, "Expected between #{count} allocations, got #{total} allocations."
  end
end
