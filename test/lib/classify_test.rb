# frozen_string_literal: true

require "test_helper"

class PrimerClassifyTest < Minitest::Test
  include Primer::ComponentTestHelpers
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
    assert_generated_class("m-4",   { m: 4 })
    assert_generated_class("mx-4",  { mx: 4 })
    assert_generated_class("my-4",  { my: 4 })
    assert_generated_class("mt-4",  { mt: 4 })
    assert_generated_class("ml-4",  { ml: 4 })
    assert_generated_class("mb-4",  { mb: 4 })
    assert_generated_class("mr-4",  { mr: 4 })
    assert_generated_class("mt-n4",   { mt: -4 })
    assert_generated_class("ml-n4",   { ml: -4 })
    assert_generated_class("mb-n4",   { mb: -4 })
    assert_generated_class("mr-n4",   { mr: -4 })
    assert_generated_class("mx-auto", { mx: :auto })

    assert_raises ArgumentError do
      Primer::Classify.call(m: -1)
    end

    assert_raises ArgumentError do
      Primer::Classify.call(m: 7)
    end

    assert_raises ArgumentError do
      Primer::Classify.call(mr: -7)
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
    assert_generated_class("v-hidden",  { visibility: :hidden })
    assert_generated_class("v-visible", { visibility: :visible })
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
    with_force_functional_colors(false) do
      refute_generated_class({ color: "" })
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

      assert_generated_class("color-text-primary",   { color: :text_primary })
      assert_generated_class("color-text-secondary", { color: :text_secondary })
      assert_generated_class("color-text-tertiary",  { color: :text_tertiary })
      assert_generated_class("color-text-link",      { color: :text_link })
      assert_generated_class("color-text-success",   { color: :text_success })
      assert_generated_class("color-text-warning",   { color: :text_warning })
      assert_generated_class("color-text-danger",    { color: :text_danger })
      assert_generated_class("color-text-white",     { color: :text_white })
      assert_generated_class("color-text-inverse",   { color: :text_inverse })

      assert_generated_class("color-icon-primary",   { color: :icon_primary })
      assert_generated_class("color-icon-secondary", { color: :icon_secondary })
      assert_generated_class("color-icon-tertiary",  { color: :icon_tertiary })
      assert_generated_class("color-icon-info",      { color: :icon_info })
      assert_generated_class("color-icon-success",   { color: :icon_success })
      assert_generated_class("color-icon-warning",   { color: :icon_warning })
      assert_generated_class("color-icon-danger",    { color: :icon_danger })
    end
  end

  def test_color_enforcing_functional_colors
    assert_generated_class("text-orange",        { color: :orange })
    assert_generated_class("text-orange-light",  { color: :orange_light })
    assert_generated_class("text-purple",        { color: :purple })
    assert_generated_class("text-pink",          { color: :pink })
    assert_generated_class("text-inherit",       { color: :inherit })

    assert_generated_class("color-blue-5",       { color: :blue_5 })
    assert_generated_class("color-gray-9",       { color: :gray_9 })
    assert_generated_class("color-purple-3",     { color: :purple_3 })

    assert_generated_class("color-text-inverse",   { color: :text_inverse })

    assert_generated_class("color-text-primary",   { color: :text_primary })
    assert_generated_class("color-text-primary",   { color: :gray_dark })

    assert_generated_class("color-text-secondary", { color: :text_secondary })
    assert_generated_class("color-text-secondary", { color: :gray })

    assert_generated_class("color-text-tertiary",  { color: :text_tertiary })
    assert_generated_class("color-text-tertiary",  { color: :gray_light })

    assert_generated_class("color-text-link",      { color: :text_link })
    assert_generated_class("color-text-link",      { color: :blue })

    assert_generated_class("color-text-success",   { color: :text_success })
    assert_generated_class("color-text-success",   { color: :green })

    assert_generated_class("color-text-warning",   { color: :text_warning })
    assert_generated_class("color-text-warning",   { color: :yellow })

    assert_generated_class("color-text-danger",    { color: :text_danger })
    assert_generated_class("color-text-danger",    { color: :red })

    assert_generated_class("color-text-white",     { color: :text_white })
    assert_generated_class("color-text-white",     { color: :white })

    assert_generated_class("color-icon-primary",   { color: :icon_primary })
    assert_generated_class("color-icon-secondary", { color: :icon_secondary })
    assert_generated_class("color-icon-tertiary",  { color: :icon_tertiary })
    assert_generated_class("color-icon-info",      { color: :icon_info })
    assert_generated_class("color-icon-success",   { color: :icon_success })
    assert_generated_class("color-icon-warning",   { color: :icon_warning })
    assert_generated_class("color-icon-danger",    { color: :icon_danger })

    err = assert_raises ArgumentError do
      Primer::Classify.call(color: :not_a_color)
    end

    assert_equal("color not_a_color does not exist.", err.message)
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
    assert_generated_class("text-light",    { font_weight: :light })
    assert_generated_class("text-normal",   { font_weight: :normal })
    assert_generated_class("text-bold",     { font_weight: :bold })
  end

  def test_box_shadow
    assert_generated_class("box-shadow",             { box_shadow: true })
    assert_generated_class("box-shadow-medium",      { box_shadow: :medium })
    assert_generated_class("box-shadow-large",       { box_shadow: :large })
    assert_generated_class("box-shadow-extra-large", { box_shadow: :extra_large })
    assert_generated_class("box-shadow-none",        { box_shadow: :none })
  end

  def test_col
    assert_generated_class("col-1", { col: 1 })
  end

  def test_border
    assert_generated_class("border-left",   { border: :left })
    assert_generated_class("border-top",    { border: :top })
    assert_generated_class("border-bottom", { border: :bottom })
    assert_generated_class("border-right",  { border: :right })
    assert_generated_class("border-y",      { border: :y })
    assert_generated_class("border-x",      { border: :x })
    assert_generated_class("border",        { border: true })
  end

  def test_border_margins
    assert_generated_class("border-top-0",    { border_top: 0 })
    assert_generated_class("border-bottom-0", { border_bottom: 0 })
    assert_generated_class("border-left-0",   { border_left: 0 })
    assert_generated_class("border-right-0",  { border_right: 0 })
  end

  def test_border_color
    assert_generated_class("border-black-fade", { border_color: :black_fade })
  end

  def test_rounded
    assert_generated_class("rounded-0", { border_radius: 0 })
    assert_generated_class("rounded-1", { border_radius: 1 })
    assert_generated_class("rounded-2", { border_radius: 2 })
    assert_generated_class("rounded-3", { border_radius: 3 })
  end

  def test_justify_content
    assert_generated_class("flex-justify-start", { justify_content: :flex_start })
    assert_generated_class("flex-justify-end", { justify_content: :flex_end })
    assert_generated_class("flex-justify-center", { justify_content: :center })
    assert_generated_class("flex-justify-between", { justify_content: :space_between })
    assert_generated_class("flex-justify-around", { justify_content: :space_around })
  end

  def test_align_items
    assert_generated_class("flex-items-start", { align_items: :flex_start })
    assert_generated_class("flex-items-end", { align_items: :flex_end })
    assert_generated_class("flex-items-center", { align_items: :center })
    assert_generated_class("flex-items-baseline", { align_items: :baseline })
    assert_generated_class("flex-items-stretch", { align_items: :stretch })
  end

  def test_word_break
    assert_generated_class("wb-break-all", { word_break: :break_all })
  end

  def test_responsive
    assert_generated_class("p-4", { p: [4] })
    assert_generated_class("p-4 p-sm-3", { p: [4, 3] })
    assert_generated_class("float-left float-md-right", { float: [:left, nil, :right] })
    assert_generated_class("d-flex d-sm-block",  { display: %i[flex block] })
    assert_generated_class("d-flex d-md-block",  { display: [:flex, nil, :block] })
    assert_generated_class("d-lg-block", { display: [nil, nil, nil, :block] })
    assert_generated_class("flex-row flex-sm-column", { direction: %i[row column] })
    assert_generated_class("col-1 col-sm-2", { col: [1, 2] })
    assert_generated_class("col-12 col-lg-9", { col: [12, nil, nil, 9] })
    assert_generated_class("p-4 p-sm-3 p-md-3 p-lg-3 p-xl-2", { p: [4, 3, 3, 3, 2] })

    assert_raises ArgumentError do
      Primer::Classify.call(border: %i[top left])
    end
  end

  def test_style
    assert_equal("background-color: #fff;", Primer::Classify.call(bg: "#fff")[:style])
  end

  def test_height
    assert_equal(10, Primer::Classify.call(height: 10)[:height])
    assert_nil(Primer::Classify.call(height: :fit)[:height])
    assert_nil(Primer::Classify.call(height: :fill)[:height])
  end

  def test_width
    assert_equal(10, Primer::Classify.call(width: 10)[:width])
    assert_nil(Primer::Classify.call(width: :fit)[:width])
    assert_nil(Primer::Classify.call(width: :fill)[:width])
  end

  def test_flex
    assert_generated_class("flex-1",    { flex: 1 })
    assert_generated_class("flex-auto", { flex: :auto })
  end

  def test_flex_align_self
    assert_generated_class("flex-self-auto",      { align_self: :auto })
    assert_generated_class("flex-self-start",     { align_self: :start })
    assert_generated_class("flex-self-end",       { align_self: :end })
    assert_generated_class("flex-self-center",    { align_self: :center })
    assert_generated_class("flex-self-baseline",  { align_self: :baseline })
    assert_generated_class("flex-self-stretch",   { align_self: :stretch })
  end

  def test_width_and_height
    assert_generated_class("width-fit",   { width: :fit })
    assert_generated_class("width-fill",  { width: :fill })
    assert_generated_class("height-fit",  { height: :fit })
    assert_generated_class("height-fill", { height: :fill })
  end

  def test_flex_grow
    assert_generated_class("flex-grow-0", { flex_grow: 0 })
  end

  def test_flex_shrink
    assert_generated_class("flex-shrink-0", { flex_shrink: 0 })
  end

  def test_animation
    assert_generated_class("anim-fade-in", { animation: :fade_in })
    assert_generated_class("anim-fade-out", { animation: :fade_out })
    assert_generated_class("anim-fade-up", { animation: :fade_up })
    assert_generated_class("anim-fade-down", { animation: :fade_down })
    assert_generated_class("anim-fade-scale-in", { animation: :fade_scale_in })
    assert_generated_class("anim-grow-x", { animation: :grow_x })
    assert_generated_class("hover-grow", { animation: :grow })
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
    assert_generated_class("bg-blue text-center float-left ml-1 ", { classes: "bg-blue text-center float-left ml-1" })
  end

  private

  def assert_generated_class(generated_class_name, input)
    assert_equal(generated_class_name, Primer::Classify.call(**input)[:class])
  end

  def refute_generated_class(input)
    assert_nil(Primer::Classify.call(**input)[:class])
  end
end
