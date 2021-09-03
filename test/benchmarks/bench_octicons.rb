# frozen_string_literal: true

require "minitest/benchmark"
require "test_helper"

class BenchOcticons < Minitest::Benchmark
  include Primer::AssertAllocationsHelper

  def setup
    @options = {
      icon: :alert
    }
  end

  def bench_allocations_without_cache
    Primer::OcticonComponent.new(**@options)
    Primer::Octicon::Cache.clear!
    assert_allocations "3.0" => 31, "2.7" => 34, "2.6" => 38, "2.5" => 40 do
      Primer::OcticonComponent.new(**@options)
    end
  ensure
    Primer::Octicon::Cache.preload!
  end

  def bench_allocations_with_cache
    Primer::Octicon::Cache.preload!
    assert_allocations "3.0" => 10, "2.7" => 14, "2.6" => 17, "2.5" => 19 do
      Primer::OcticonComponent.new(**@options)
    end
  end
end
