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
    Primer::Classify::AttrCache.instance.clear!

    assert_allocations "3.0" => 47, "2.7" => 46, "2.6" => 48, "2.5" => 49 do
      Primer::Classify::Cache.instance.disable do
        Primer::Classify::AttrCache.instance.disable do
          Primer::Classify.call(**@values)
        end
      end
    end
  end

  def bench_allocations_with_cache_warmed
    Primer::Classify::AttrCache.instance.clear!
    Primer::Classify::AttrCache.instance.preload!

    Primer::Classify::Cache.instance.clear!
    Primer::Classify.call(**@values)

    assert_allocations "3.0" => 8, "2.7" => 8, "2.6" => 9, "2.5" => 10
     do
      Primer::Classify.call(**@values)
    end
  end
end
