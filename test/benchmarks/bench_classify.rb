# frozen_string_literal: true

require "minitest/benchmark"
require "test_helper"

class BenchClassify < Minitest::Benchmark
  include Primer::AssertAllocationsHelper

  def setup
    @values = {
      align_items: :center,
      align_self: :center,
      bg: :accent,
      border: :top,
      box_shadow: true,
      col: 1,
      color: :danger,
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

  def bench_allocations_with_cache_disabled
    Primer::Classify::Cache.instance.clear!

    assert_allocations "3.0" => 46, "2.7" => 46, "2.6" => 49, "2.5" => 50 do
      Primer::Classify::Cache.instance.disable do
        Primer::Classify.call(**@values)
      end
    end
  ensure
    Primer::Classify::Cache.instance.preload!
  end

  def bench_allocations_with_cache_preloaded
    Primer::Classify::Cache.instance.clear!
    Primer::Classify::Cache.instance.preload!

    assert_allocations "3.0" => 42, "2.7" => 35, "2.6" => 38, "2.5" => 39 do
      Primer::Classify.call(**@values)
    end
  end

  def bench_allocations_with_cache_preloaded_and_warmed
    Primer::Classify::Cache.instance.clear!
    Primer::Classify::Cache.instance.preload!
    Primer::Classify.call(**@values)

    assert_allocations "3.0" => 8, "2.7" => 8, "2.6" => 11, "2.5" => 12 do
      Primer::Classify.call(**@values)
    end
  end
end
