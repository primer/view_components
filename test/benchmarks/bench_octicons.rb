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
    assert_allocations "3.0" => 39, "2.7" => 40, "2.6" => 45, "2.5" => 47 do
      Primer::OcticonComponent.new(**@options)
    end
  ensure
    Primer::Octicon::Cache.preload!
  end

  def bench_allocations_with_cache
    Primer::Octicon::Cache.preload!
    assert_allocations "3.0" => 17, "2.7" => 19, "2.6" => 23, "2.5" => 25 do
      Primer::OcticonComponent.new(**@options)
    end
  end
end
