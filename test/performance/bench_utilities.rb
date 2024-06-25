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

    assert_allocations "3.0" => 4, "3.1" => 4, "3.2" => 4, "3.3" => 4 do
      Primer::Classify::Utilities.supported_selector?("m-1")
    end
  end

  def bench_allocations_non_supported_selector
    # warm up
    Primer::Classify::Utilities.supported_selector?("foo")

    assert_allocations "3.0" => 0, "3.1" => 0, "3.2" => 0, "3.3" => 0 do
      Primer::Classify::Utilities.supported_selector?("foo")
    end
  end
end
