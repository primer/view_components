# frozen_string_literal: true

require "minitest/benchmark"
require "test_helper"

class BenchOcticons < Minitest::Benchmark
  include Primer::AssertAllocationsHelper

  def test_order
    "random"
  end

  def setup
    @options = {
      icon: :alert
    }
  end

  def bench_allocations_without_cache
    assert_allocations "3.0" => 40, "2.7" => 42, "2.6" => 48, "2.5" => 53 do
      Primer::Octicon::Cache.clear!
      Primer::OcticonComponent.new(**@options)
    end
  ensure
    Primer::Octicon::Cache.preload!
  end

  def bench_allocations_with_cache
    Primer::Octicon::Cache.preload!

    assert_allocations "3.0" => 19, "2.7" => 20, "2.6" => 24, "2.5" => 28 do
      Primer::OcticonComponent.new(**@options)
    end
  end
end
