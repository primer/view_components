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
    assert_allocations "3.4" => 26, "3.3" => 30, "3.2" => 30, "3.1" => 28, "3.0" => 28 do
      Primer::Beta::Octicon.new(**@options)
    end
  ensure
    Primer::Octicon::Cache.preload!
  end

  def bench_allocations_with_cache
    Primer::Octicon::Cache.preload!
    assert_allocations "3.4" => 10, "3.3" => 14, "3.2" => 14, "3.1" => 11, "3.0" => 11 do
      Primer::Beta::Octicon.new(**@options)
    end
  end
end
