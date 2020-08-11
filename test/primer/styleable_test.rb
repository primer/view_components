# frozen_string_literal: true

require "test_helper"

class StyleableTest < Minitest::Test
  class EmptyComponent < ViewComponent::Base
    include Primer::Styleable
  end

  def test_margin
    # positive values
    assert_equal "m-4", EmptyComponent.new.m(4).primer_classes
    assert_equal "mx-4", EmptyComponent.new.mx(4).primer_classes
    assert_equal "mt-4", EmptyComponent.new.mt(4).primer_classes
    assert_equal "ml-4", EmptyComponent.new.ml(4).primer_classes
    assert_equal "mb-4", EmptyComponent.new.mb(4).primer_classes
    assert_equal "mr-4", EmptyComponent.new.mr(4).primer_classes

    # negative values
    assert_equal "mt-n4", EmptyComponent.new.mt(-4).primer_classes
    assert_equal "ml-n4", EmptyComponent.new.ml(-4).primer_classes
    assert_equal "mb-n4", EmptyComponent.new.mb(-4).primer_classes
    assert_equal "mr-n4", EmptyComponent.new.mr(-4).primer_classes

    assert_raises ArgumentError do
      EmptyComponent.new.m(-1)
    end

    # positive over 6
    assert_raises ArgumentError do
      EmptyComponent.new.mr(7)
    end

    # negative under -6
    assert_raises ArgumentError do
      EmptyComponent.new.mr(-7)
    end
  end

  def test_multiple_params
    assert_equal "m-4 py-2", EmptyComponent.new.m(4).py(2).primer_classes
  end

  def test_font_size
    assert_equal "f00", EmptyComponent.new.f("00").primer_classes
    assert_equal "f0", EmptyComponent.new.f(0).primer_classes
    assert_equal "f1", EmptyComponent.new.f(1).primer_classes
    assert_equal "f2", EmptyComponent.new.f(2).primer_classes
    assert_equal "f3", EmptyComponent.new.f(3).primer_classes
    assert_equal "f4", EmptyComponent.new.f(4).primer_classes
    assert_equal "f5", EmptyComponent.new.f(5).primer_classes
    assert_equal "f6", EmptyComponent.new.f(6).primer_classes
  end

  def test_p
    assert_equal "p-4", EmptyComponent.new.p(4).primer_classes
    assert_equal "px-4", EmptyComponent.new.px(4).primer_classes
    assert_equal "py-4", EmptyComponent.new.py(4).primer_classes
    assert_equal "pt-4", EmptyComponent.new.pt(4).primer_classes
    assert_equal "pl-4", EmptyComponent.new.pl(4).primer_classes
    assert_equal "pb-4", EmptyComponent.new.pb(4).primer_classes
    assert_equal "pr-4", EmptyComponent.new.pr(4).primer_classes

    assert_raises ArgumentError do
      EmptyComponent.new.p(-1)
    end

    assert_raises ArgumentError do
      EmptyComponent.new.p(7)
    end
  end

  def test_position
    # TODO maybe make these methods instead of accepting an argument?
    # e.g. `EmptyComponent.new.relative`, `EmptyComponent.new.absolute`
    assert_equal "position-relative", EmptyComponent.new.position(:relative).primer_classes
    assert_equal "position-absolute", EmptyComponent.new.position(:absolute).primer_classes
    assert_equal "position-fixed", EmptyComponent.new.position(:fixed).primer_classes

    assert_equal "top-0", EmptyComponent.new.top0.primer_classes
    assert_equal "bottom-0", EmptyComponent.new.bottom0.primer_classes
    assert_equal "left-0", EmptyComponent.new.left0.primer_classes
    assert_equal "right-0", EmptyComponent.new.right0.primer_classes
  end

  def test_display
    assert_equal "d-block", EmptyComponent.new.block.primer_classes
    assert_equal "d-none", EmptyComponent.new.none.primer_classes
    assert_equal "d-inline", EmptyComponent.new.inline.primer_classes
    assert_equal "d-inline-block", EmptyComponent.new.inline_block.primer_classes
    assert_equal "d-table", EmptyComponent.new.table.primer_classes
    assert_equal "d-table-cell", EmptyComponent.new.table_cell.primer_classes
  end

  def test_v
    assert_equal "v-hidden", EmptyComponent.new.hidden.primer_classes
    assert_equal "v-visible", EmptyComponent.new.visible.primer_classes
  end

  def test_hide
    assert_equal "hide-sm", EmptyComponent.new.hide_sm.primer_classes
    assert_equal "hide-md", EmptyComponent.new.hide_md.primer_classes
    assert_equal "hide-lg", EmptyComponent.new.hide_lg.primer_classes
    assert_equal "hide-xl", EmptyComponent.new.hide_xl.primer_classes
  end

  def test_vertical_align
    assert_equal "v-align-baseline", EmptyComponent.new.valign_baseline.primer_classes
    assert_equal "v-align-top", EmptyComponent.new.valign_top.primer_classes
    assert_equal "v-align-middle", EmptyComponent.new.valign_middle.primer_classes
    assert_equal "v-align-bottom", EmptyComponent.new.valign_bottom.primer_classes
    assert_equal "v-align-text-top", EmptyComponent.new.valign_text_top.primer_classes
    assert_equal "v-align-text-bottom", EmptyComponent.new.valign_text_bottom.primer_classes
  end

  def test_float
    assert_equal "float-left", EmptyComponent.new.float(:left).primer_classes
  end

  def test_underline
    assert_equal "text-underline", EmptyComponent.new.underline.primer_classes
    assert_equal "no-underline", EmptyComponent.new.no_underline.primer_classes
  end

  # def test_color
  #   assert_generated_class("text-blue",          { color: :blue })
  #   assert_generated_class("text-red",           { color: :red })
  #   assert_generated_class("text-gray-light",    { color: :gray_light })
  #   assert_generated_class("text-gray",          { color: :gray })
  #   assert_generated_class("text-gray-dark",     { color: :gray_dark })
  #   assert_generated_class("text-green",         { color: :green })
  #   assert_generated_class("text-orange",        { color: :orange })
  #   assert_generated_class("text-orange-light",  { color: :orange_light })
  #   assert_generated_class("text-purple",        { color: :purple })
  #   assert_generated_class("text-pink",          { color: :pink })
  #   assert_generated_class("text-white",         { color: :white })
  #   assert_generated_class("text-inherit",       { color: :inherit })
  #
  #   assert_generated_class("color-blue-5",       { color: :blue_5 })
  #   assert_generated_class("color-gray-9",       { color: :gray_9 })
  #   assert_generated_class("color-purple-3",     { color: :purple_3 })
  # end
  #
  # def test_bg
  #   assert_generated_class("bg-blue-5",       { bg: :blue_5 })
  #   assert_generated_class("bg-gray-9",       { bg: :gray_9 })
  #   assert_generated_class("bg-purple-3",     { bg: :purple_3 })
  # end
  #
  # def test_text_align
  #   assert_generated_class("text-right",      { text_align: :right })
  #   assert_generated_class("text-left",       { text_align: :left })
  # end
  #
  # def test_font_weight
  #   assert_generated_class("text-light",    { font_weight: :light })
  #   assert_generated_class("text-normal",   { font_weight: :normal })
  #   assert_generated_class("text-semibold", { font_weight: :semibold })
  #   assert_generated_class("text-bold",     { font_weight: :bold })
  # end
  #
  # def test_col
  #   assert_generated_class("col-1", { col: 1 })
  # end
  #
  # def test_border
  #   assert_generated_class("border-left",    { border: :left })
  #   assert_generated_class("border-top",     { border: :top })
  #   assert_generated_class("border-bottom",  { border: :bottom })
  #   assert_generated_class("border-right",   { border: :right })
  #   assert_generated_class("border-y",       { border: :y })
  # end
  #
  # def test_border_color
  #   assert_generated_class("border-black-fade", { border_color: :black_fade })
  # end
  #
  # def test_justify_content
  #   assert_generated_class("flex-justify-start", { justify_content: :flex_start })
  #   assert_generated_class("flex-justify-end", { justify_content: :flex_end })
  #   assert_generated_class("flex-justify-center", { justify_content: :center })
  #   assert_generated_class("flex-justify-between", { justify_content: :space_between })
  #   assert_generated_class("flex-justify-around", { justify_content: :space_around })
  # end
  #
  # def test_align_items
  #   assert_generated_class("flex-items-start", { align_items: :flex_start })
  #   assert_generated_class("flex-items-end", { align_items: :flex_end })
  #   assert_generated_class("flex-items-center", { align_items: :center })
  #   assert_generated_class("flex-items-baseline", { align_items: :baseline })
  #   assert_generated_class("flex-items-stretch", { align_items: :stretch })
  # end
  #
  # def test_word_break
  #   assert_generated_class("wb-break-all",   { word_break: :break_all })
  # end
  #
  # def test_responsive
  #   assert_generated_class("p-4",  { p: [4] })
  #   assert_generated_class("p-4 p-sm-3",  { p: [4, 3] })
  #   assert_generated_class("d-flex d-sm-block",  { display: [:flex, :block] })
  #   assert_generated_class("d-flex d-md-block",  { display: [:flex, nil, :block] })
  #   assert_generated_class("flex-row flex-sm-column",  { direction: [:row, :column] })
  #   assert_generated_class("col-1 col-sm-2",  { col: [1, 2] })
  #   assert_generated_class("p-4 p-sm-3 p-md-3 p-lg-3",  { p: [4, 3, 3, 3] })
  #
  #   assert_raises ArgumentError do
  #     Primer::Classify.call(border: [:top, :left])
  #   end
  # end
  #
  # def test_style
  #   assert_equal("background-color: #fff;", Primer::Classify.call(bg: "#fff")[:style])
  # end
  #
  # def test_height
  #   assert_equal(10, Primer::Classify.call(height: 10)[:height])
  #   assert_nil(Primer::Classify.call(height: :fit)[:height])
  #   assert_nil(Primer::Classify.call(height: :fill)[:height])
  # end
  #
  # def test_width
  #   assert_equal(10, Primer::Classify.call(width: 10)[:width])
  #   assert_nil(Primer::Classify.call(width: :fit)[:width])
  #   assert_nil(Primer::Classify.call(width: :fill)[:width])
  # end
  #
  # def test_flex
  #   assert_generated_class("flex-1",    { flex: 1 })
  #   assert_generated_class("flex-auto", { flex: :auto })
  # end
  #
  # def test_flex_align_self
  #   assert_generated_class("flex-self-auto",      { align_self: :auto })
  #   assert_generated_class("flex-self-start",     { align_self: :start })
  #   assert_generated_class("flex-self-end",       { align_self: :end })
  #   assert_generated_class("flex-self-center",    { align_self: :center })
  #   assert_generated_class("flex-self-baseline",  { align_self: :baseline })
  #   assert_generated_class("flex-self-stretch",   { align_self: :stretch })
  # end
  #
  # def test_width_and_height
  #   assert_generated_class("width-fit",   { width: :fit })
  #   assert_generated_class("width-fill",  { width: :fill })
  #   assert_generated_class("height-fit",  { height: :fit })
  #   assert_generated_class("height-fill", { height: :fill })
  # end
  #
  # def test_flex_grow
  #   assert_generated_class("flex-grow-0", { flex_grow: 0 })
  # end
  #
  # def test_flex_shrink
  #   assert_generated_class("flex-shrink-0", { flex_shrink: 0 })
  # end
  #
  # def test_raises_error_when_passing_in_a_primer_css_class_name_in_development
  #   ENV["RAILS_ENV"] = "development"
  #   exception = assert_raises ArgumentError do
  #     Primer::Classify.call(classes: "bg-blue text-center float-left ml-1")
  #   end
  #
  #   assert_includes exception.message, "Primer CSS class names"
  # ensure
  #   ENV["RAILS_ENV"] = "test"
  # end
  #
  # def test_does_not_raise_error_when_passing_in_a_primer_css_class_otherwise
  #   assert_generated_class("bg-blue text-center float-left ml-1 ",  { classes: "bg-blue text-center float-left ml-1" })
  # end
  #
  # def assert_generated_class(generated_class_name, input)
  #   assert_equal(generated_class_name, Primer::Classify.call(**input)[:class])
  # end
  #
  # def refute_generated_class(input)
  #   assert_nil(Primer::Classify.call(**input)[:class])
  # end
end
