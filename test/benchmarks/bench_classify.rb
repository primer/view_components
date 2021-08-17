# frozen_string_literal: true

require "minitest/benchmark"
require "test_helper"

class BenchClassify < Minitest::Benchmark
  include Primer::AssertAllocationsHelper

  EXPECTATIONS = {
    "2.7.3" => {
      without_cache: 68,
      with_cache: 25
    }
  }.freeze

  def setup
    @values = {
      align_items: :center,
      align_self: :center,
      bg: :info,
      border: :top,
      box_shadow: true,
      col: 1,
      color: :text_danger,
      flex: 1,
      float: :left,
      font_weight: :bold,
      font_size: 1,
      h: :fit,
      justify_content: :flex_start,
      m: 1,
      p: 4,
      position: :relative,
      text_align: :left,
      visibility: :hidden,
      w: :fit,
      underline: true,
      vertical_align: :baseline,
      direction: [:row, :column],
      display: [:flex, :block, :inline_block, nil],
      word_break: :break_all,
      flex_grow: 0,
      flex_shrink: 0
    }
  end

  def bench_allocations_without_cache
    # Preload cache, warm up benchmark
    Primer::Classify::Cache.clear!
    Primer::Classify.call(**@values)

    assert_allocations expectations_for(:without_cache) do
      Primer::Classify.call(**@values)
    end
  ensure
    Primer::Classify::Cache.preload!
  end

  def bench_allocations_with_cache
    Primer::Classify::Cache.preload!
    Primer::Classify.call(**@values)

    assert_allocations expectations_for(:with_cache) do
      Primer::Classify.call(**@values)
    end
  end

  private

  def expectations_for(type)
    EXPECTATIONS[ENV["RUBY_VERSION"]][type]
  end
end
