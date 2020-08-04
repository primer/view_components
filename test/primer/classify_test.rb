# frozen_string_literal: true

require "test_helper"

class PrimerClassifyTest < Minitest::Test
  def test_multiple_params
    assert_generated_class("m-4 py-2", { m: 4, py: 2 })
  end

  def test_font_size
    assert_generated_class("f00", { font_size: "00" })
    assert_generated_class("f0",  { font_size: 0 })
    assert_generated_class("f1",  { font_size: 1 })
    assert_generated_class("f2",  { font_size: 2 })
    assert_generated_class("f3",  { font_size: 3 })
    assert_generated_class("f4",  { font_size: 4 })
    assert_generated_class("f5",  { font_size: 5 })
    assert_generated_class("f6",  { font_size: 6 })
  end

  def test_m
    assert_generated_class("m-4",  { m: 4 })
    assert_generated_class("mx-4", { mx: 4 })
    assert_generated_class("my-4", { my: 4 })
    assert_generated_class("mt-4", { mt: 4 })
    assert_generated_class("ml-4", { ml: 4 })
    assert_generated_class("mb-4", { mb: 4 })
    assert_generated_class("mr-4", { mr: 4 })

    assert_raises ArgumentError do
      Primer::Classify.call(m: -1)
    end

    assert_raises ArgumentError do
      Primer::Classify.call(m: 7)
    end
  end

  def test_p
    assert_generated_class("p-4",  { p: 4 })
    assert_generated_class("px-4", { px: 4 })
    assert_generated_class("py-4", { py: 4 })
    assert_generated_class("pt-4", { pt: 4 })
    assert_generated_class("pl-4", { pl: 4 })
    assert_generated_class("pb-4", { pb: 4 })
    assert_generated_class("pr-4", { pr: 4 })

    assert_raises ArgumentError do
      Primer::Classify.call(p: -1)
    end

    assert_raises ArgumentError do
      Primer::Classify.call(p: 7)
    end
  end

  def test_position
    assert_generated_class("position-relative", { position: :relative })
    assert_generated_class("position-absolute", { position: :absolute })
    assert_generated_class("position-fixed",    { position: :fixed })
    assert_generated_class("top-0",             { top:      false })
    assert_generated_class("bottom-0",          { bottom:   false })
    assert_generated_class("left-0",            { left:     false })
    assert_generated_class("right-0",           { right:    false })

    refute_generated_class({ top:    true })
    refute_generated_class({ bottom: true })
    refute_generated_class({ left:   true })
    refute_generated_class({ right:  true })
  end

  def test_display
    assert_generated_class("d-block",        { display: :block })
    assert_generated_class("d-none",         { display: :none })
    assert_generated_class("d-inline",       { display: :inline })
    assert_generated_class("d-inline-block", { display: :inline_block })
    assert_generated_class("d-table",        { display: :table })
    assert_generated_class("d-table-cell",   { display: :table_cell })
  end

  def test_v
    assert_generated_class("v-hidden",  { v: :hidden })
    assert_generated_class("v-visible", { v: :visible })
  end

  def test_hide
    assert_generated_class("hide-sm",                         { hide: :sm })
    assert_generated_class("hide-md",                         { hide: :md })
    assert_generated_class("hide-lg",                         { hide: :lg })
    assert_generated_class("hide-xl",                         { hide: :xl })
  end

  def test_vertical_align
    assert_generated_class("v-align-baseline",    { vertical_align: :baseline })
    assert_generated_class("v-align-top",         { vertical_align: :top })
    assert_generated_class("v-align-middle",      { vertical_align: :middle })
    assert_generated_class("v-align-bottom",      { vertical_align: :bottom })
    assert_generated_class("v-align-text-top",    { vertical_align: :text_top })
    assert_generated_class("v-align-text-bottom", { vertical_align: :text_bottom })
  end

  def test_float
    assert_generated_class("float-left", { float: :left })
  end

  def test_underline
    assert_generated_class("no-underline",   { underline: false })
    assert_generated_class("text-underline", { underline: true })
  end

  def test_color
    assert_generated_class("text-blue",          { color: :blue })
    assert_generated_class("text-red",           { color: :red })
    assert_generated_class("text-gray-light",    { color: :gray_light })
    assert_generated_class("text-gray",          { color: :gray })
    assert_generated_class("text-gray-dark",     { color: :gray_dark })
    assert_generated_class("text-green",         { color: :green })
    assert_generated_class("text-orange",        { color: :orange })
    assert_generated_class("text-orange-light",  { color: :orange_light })
    assert_generated_class("text-purple",        { color: :purple })
    assert_generated_class("text-pink",          { color: :pink })
    assert_generated_class("text-white",         { color: :white })
    assert_generated_class("text-inherit",       { color: :inherit })

    assert_generated_class("color-blue-5",       { color: :blue_5 })
    assert_generated_class("color-gray-9",       { color: :gray_9 })
    assert_generated_class("color-purple-3",     { color: :purple_3 })
  end

  def test_bg
    assert_generated_class("bg-blue-5",       { bg: :blue_5 })
    assert_generated_class("bg-gray-9",       { bg: :gray_9 })
    assert_generated_class("bg-purple-3",     { bg: :purple_3 })
  end

  def test_text_align
    assert_generated_class("text-right",      { text_align: :right })
    assert_generated_class("text-left",       { text_align: :left })
  end

  def test_font_weight
    assert_generated_class("text-normal",  { font_weight: :normal })
    assert_generated_class("text-bold",    { font_weight: :bold })
    assert_generated_class("text-bold",    { font_weight: :bold })
  end

  def test_col
    assert_generated_class("col-1", { col: 1 })
  end

  def test_border
    assert_generated_class("border-left",    { border: :left })
    assert_generated_class("border-top",     { border: :top })
    assert_generated_class("border-bottom",  { border: :bottom })
    assert_generated_class("border-right",   { border: :right })
    assert_generated_class("border-y",       { border: :y })
  end

  def test_border_color
    assert_generated_class("border-black-fade", { border_color: :black_fade })
  end

  def test_word_break
    assert_generated_class("wb-break-all",   { word_break: :break_all })
  end

  def test_responsive
    assert_generated_class("p-4",  { p: [4] })
    assert_generated_class("p-4 p-sm-3",  { p: [4, 3] })
    assert_generated_class("d-flex d-sm-block",  { display: [:flex, :block] })
    assert_generated_class("d-flex d-md-block",  { display: [:flex, nil, :block] })
    assert_generated_class("flex-row flex-sm-column",  { direction: [:row, :column] })
    assert_generated_class("col-1 col-sm-2",  { col: [1, 2] })
    assert_generated_class("p-4 p-sm-3 p-md-3 p-lg-3",  { p: [4, 3, 3, 3] })

    assert_raises ArgumentError do
      Primer::Classify.call(border: [:top, :left])
    end
  end

  def test_raises_error_when_passing_in_a_primer_css_class_name_in_development
    ENV["RAILS_ENV"] = "development"
    exception = assert_raises ArgumentError do
      Primer::Classify.call(classes: "bg-blue text-center float-left ml-1")
    end

    assert_includes exception.message, "Primer CSS class names"
  ensure
    ENV["RAILS_ENV"] = "test"
  end

  def test_does_not_raise_error_when_passing_in_a_primer_css_class_otherwise
    assert_generated_class("bg-blue text-center float-left ml-1 ",  { classes: "bg-blue text-center float-left ml-1" })
  end

  def assert_generated_class(generated_class_name, input)
    assert_equal(generated_class_name, Primer::Classify.call(**input))
  end

  def refute_generated_class(input)
    assert_nil(Primer::Classify.call(**input))
  end
end
