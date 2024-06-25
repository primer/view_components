# frozen_string_literal: true

require "minitest"
require "minitest/benchmark"
require "test_helper"
require "test_helpers/assert_allocations_helper"

class BenchClassify < Minitest::Benchmark
  include Primer::AssertAllocationsHelper

  def bench_allocations_supported_selector
    assert_allocations "3.0" => 4, "3.1" => 6, "3.2" => 4, "3.3" => 6 do
      Primer::Classify::Utilities.supported_selector?("m-1")
    end
  end

  def bench_allocations_non_supported_selector
    assert_allocations "3.0" => 2, "3.1" => 0, "3.2" => 2, "3.3" => 0 do
      Primer::Classify::Utilities.supported_selector?("foo")
    end
  end
end
