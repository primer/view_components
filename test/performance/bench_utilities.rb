# frozen_string_literal: true

require "minitest"
require "minitest/benchmark"
require "test_helper"
require "test_helpers/assert_allocations_helper"

class BenchUtilities < Minitest::Benchmark
  include Primer::AssertAllocationsHelper

  def bench_allocations_supported_selector
    # warm up
    Primer::Classify::Utilities.supported_selector?("m-1")

    # Allocations increased due to find_selector iterating through space-separated class strings
    # for tmp- namespaced margin/padding utilities
    assert_allocations "3.0" => 15, "3.1" => 15, "3.2" => 15, "3.3" => 15, "3.4" => 15, "4.0" => 15 do
      Primer::Classify::Utilities.supported_selector?("m-1")
    end
  end

  def bench_allocations_non_supported_selector
    # warm up
    Primer::Classify::Utilities.supported_selector?("foo")

    # Allocations increased due to find_selector iterating through space-separated class strings
    # for tmp- namespaced margin/padding utilities
    assert_allocations "3.0" => 18, "3.1" => 18, "3.2" => 18, "3.3" => 18, "3.4" => 18, "4.0" => 18 do
      Primer::Classify::Utilities.supported_selector?("foo")
    end
  end
end
