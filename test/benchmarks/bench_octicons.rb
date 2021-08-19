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
    assert_allocations "3.0" => 60, "2.7" => 43, "2.6" => 50, "2.5" => 54 do
      Primer::OcticonComponent.new(**@options)
    end
  ensure
    Primer::Octicon::Cache.preload!
  end

  def bench_allocations_with_cache
    Primer::Octicon::Cache.preload!
    assert_allocations "3.0" => 29, "2.7" => 20, "2.6" => 24, "2.5" => 28 do
      Primer::OcticonComponent.new(**@options)
    end
  end
end
