# frozen_string_literal: true

require "minitest"
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

  def bench_allocations
    assert_allocations "3.1" => 6, "3.0" => 6, "2.7" => 4 do
      Primer::Classify.call(**@values)
    end
  end
end
