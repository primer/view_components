# frozen_string_literal: true

require "minitest/benchmark"
require "test_helper"

class BenchOcticons < Minitest::Benchmark
  include Primer::AssertAllocationsHelper

  EXPECTATIONS = {
    "2.5.x" => {
      without_cache: 53,
      with_cache: 27
    },
    "2.6.x" => {
      without_cache: 49,
      with_cache: 24
    },
    "2.7.x" => {
      without_cache: 43..45,
      with_cache: 19..21
    },
    "3.0.x" => {
      without_cache: 50..51,
      with_cache: 19..21
    }
  }.freeze

  def setup
    @options = {
      icon: :alert
    }
  end

  def bench_allocations_without_cache
    Primer::OcticonComponent.new(**@options)
    Primer::Octicon::Cache.clear!
    assert_allocations expectations_for(:without_cache) do
      Primer::OcticonComponent.new(**@options)
    end
  ensure
    Primer::Octicon::Cache.preload!
  end

  def bench_allocations_with_cache
    Primer::Octicon::Cache.preload!
    assert_allocations expectations_for(:with_cache) do
      Primer::OcticonComponent.new(**@options)
    end
  end
end
