# frozen_string_literal: true

require "minitest"
require "minitest/benchmark"
require "test_helper"
require "test_helpers/assert_allocations_helper"

class BenchOcticons < Minitest::Benchmark
  include Primer::AssertAllocationsHelper

  def setup
    @options = {
      icon: :alert
    }
  end

  def bench_allocations_without_cache
    Primer::Beta::Octicon.new(**@options)
    Primer::Octicon::Cache.clear!
    assert_allocations "3.2" => 28, "3.1" => 29, "3.0" => 29, "2.7" => 30 do
      Primer::Beta::Octicon.new(**@options)
    end
  ensure
    Primer::Octicon::Cache.preload!
  end

  def bench_allocations_with_cache
    Primer::Octicon::Cache.preload!
    assert_allocations "3.2" => 10, "3.1" => 10, "3.0" => 10, "2.7" => 12 do
      Primer::Beta::Octicon.new(**@options)
    end
  end
end
