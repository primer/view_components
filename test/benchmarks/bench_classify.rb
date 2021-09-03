# frozen_string_literal: true

require "minitest/benchmark"
require "test_helper"

class BenchClassify < Minitest::Benchmark
  include Primer::AssertAllocationsHelper

  def test_order
    "random"
  end

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
    assert_allocations "3.0" => 68, "2.7" => 68, "2.6" => 69, "2.5" => 70 do
      Primer::Classify::Cache.clear!
      Primer::Classify.call(**@values)
    end
  ensure
    Primer::Classify::Cache.preload!
  end

  def bench_allocations_with_cache
    Primer::Classify::Cache.preload!

    assert_allocations "3.0" => 25, "2.7" => 25, "2.6" => 26, "2.5" => 27 do
      Primer::Classify.call(**@values)
    end
  end
end
