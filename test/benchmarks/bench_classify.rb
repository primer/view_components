# frozen_string_literal: true

require "minitest/benchmark"
require "test_helper"

class BenchClassify < Minitest::Benchmark
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
      height: :fit,
      justify_content: :flex_start,
      m: 1,
      p: 4,
      position: :relative,
      text_align: :left,
      visibility: :hidden,
      width: :fit,
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

    assert_allocations 114 do
      Primer::Classify.call(**@values)
    end
  ensure
    Primer::Classify::Cache.preload!
  end

  def bench_allocations_with_cache
    Primer::Classify::Cache.preload!
    Primer::Classify.call(**@values)

    assert_allocations 39 do
      Primer::Classify.call(**@values)
    end
  end

  private

  def assert_allocations(count)
    GC.disable
    total_start = GC.stat[:total_allocated_objects]
    yield
    total_end = GC.stat[:total_allocated_objects]
    GC.enable

    total = total_end - total_start

    assert_equal count, total, "Expected between #{count} allocations, got #{total} allocations."
  end
end
