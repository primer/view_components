# frozen_string_literal: true

require "minitest/benchmark"
require "test_helper"

class BenchClassify < Minitest::Benchmark
  include Primer::AssertAllocationsHelper

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

  def bench_allocations_with_cache_disabled
    Primer::Classify::Cache.instance.clear!

    assert_allocations "3.0" => 60, "2.7" => 60, "2.6" => 61, "2.5" => 92 do
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

    assert_allocations "3.0" => 48, "2.7" => 40, "2.6" => 41, "2.5" => 58 do
      Primer::Classify.call(**@values)
    end
  end

  def bench_allocations_with_cache_preloaded_and_warmed
    Primer::Classify::Cache.instance.clear!
    Primer::Classify::Cache.instance.preload!
    Primer::Classify.call(**@values)

    assert_allocations "3.0" => 15, "2.7" => 15, "2.6" => 16, "2.5" => 17 do
      Primer::Classify.call(**@values)
    end
  end
end
