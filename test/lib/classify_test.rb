# frozen_string_literal: true

require "lib/test_helper"

class PrimerClassifyTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_multiple_params
    assert_generated_class("m-4 py-2", { m: 4, py: 2 })
  end

  def test_container
    assert_generated_class("container-xl", { container: :xl })
    assert_generated_class("container-lg", { container: :lg })
    assert_generated_class("container-md", { container: :md })
    assert_generated_class("container-sm", { container: :sm })

    assert_raises ArgumentError do
      Primer::Classify.call(container: :foo)
    end
  end

  def test_clearfix
    assert_generated_class("clearfix", { clearfix: true })
    refute_generated_class({ clearfix: false })

    assert_raises ArgumentError do
      Primer::Classify.call(clearfix: :foo)
    end
  end

  def test_font_size
    assert_generated_class("f00", { font_size: "00" })
    assert_generated_class("f1",  { font_size: 1 })
    assert_generated_class("f2",  { font_size: 2 })
    assert_generated_class("f3",  { font_size: 3 })
    assert_generated_class("f4",  { font_size: 4 })
    assert_generated_class("f5",  { font_size: 5 })
    assert_generated_class("f6",  { font_size: 6 })
    assert_generated_class("text-small", { font_size: :small })
    assert_generated_class("text-normal",  { font_size: :normal })
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
    assert_generated_class("mr-1 mr-sm-2 mr-md-3 mr-lg-4 mr-xl-5", { mr: [1, 2, 3, 4, 5] })

    assert_raises ArgumentError do
      Primer::Classify.call(m: -1)
    end

    assert_raises ArgumentError do
      Primer::Classify.call(m: 7)
    end

    assert_raises ArgumentError do
      Primer::Classify.call(mr: -7)
    end

    assert_raises ArgumentError do
      Primer::Classify.call(my: :foo)
    end

    assert_raises ArgumentError do
      Primer::Classify.call(mr: :foo)
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
    assert_generated_class("p-responsive", { p: :responsive })
    assert_generated_class("pr-1 pr-sm-2 pr-md-3 pr-lg-4 pr-xl-5", { pr: [1, 2, 3, 4, 5] })

    assert_raises ArgumentError do
      Primer::Classify.call(p: -1)
    end

    assert_raises ArgumentError do
      Primer::Classify.call(p: 7)
    end

    assert_raises ArgumentError do
      Primer::Classify.call(pr: :responsive)
    end

    assert_raises ArgumentError do
      Primer::Classify.call(px: :responsive)
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
    assert_generated_class("hide-sm", { hide: :sm })
    assert_generated_class("hide-md", { hide: :md })
    assert_generated_class("hide-lg", { hide: :lg })
    assert_generated_class("hide-xl", { hide: :xl })
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
    assert_generated_class("float-right", { float: :right })
  end

  def test_underline
    assert_generated_class("no-underline",   { underline: false })
    assert_generated_class("text-underline", { underline: true })
  end

  def test_color
    assert_generated_class("color-fg-on-emphasis", { color: :on_emphasis })
    assert_generated_class("color-fg-default",     { color: :default })
    assert_generated_class("color-fg-muted",       { color: :muted })
    assert_generated_class("color-fg-accent",      { color: :accent })
    assert_generated_class("color-fg-success",     { color: :success })
    assert_generated_class("color-fg-attention",   { color: :attention })
    assert_generated_class("color-fg-danger",      { color: :danger })

    err = assert_raises ArgumentError do
      Primer::Classify.call(color: :not_a_color)
    end

    assert_includes(err.message, "not_a_color is not a valid value for :color")
  end

  def test_bg_colors
    assert_generated_class("color-bg-default",            { bg: :default })
    assert_generated_class("color-bg-subtle",             { bg: :subtle })
    assert_generated_class("color-bg-emphasis",           { bg: :emphasis })
    assert_generated_class("color-bg-accent",             { bg: :accent })
    assert_generated_class("color-bg-accent-emphasis",    { bg: :accent_emphasis })
    assert_generated_class("color-bg-success",            { bg: :success })
    assert_generated_class("color-bg-success-emphasis",   { bg: :success_emphasis })
    assert_generated_class("color-bg-attention",          { bg: :attention })
    assert_generated_class("color-bg-attention-emphasis", { bg: :attention_emphasis })
    assert_generated_class("color-bg-danger",             { bg: :danger })
    assert_generated_class("color-bg-danger-emphasis",    { bg: :danger_emphasis })
    assert_generated_class("color-bg-overlay",            { bg: :overlay })

    err = assert_raises ArgumentError do
      Primer::Classify.call(bg: :not_a_color)
    end

    assert_includes(err.message, "not_a_color is not a valid value for :bg")
  end

  def test_text_align
    assert_generated_class("text-right", { text_align: :right })
    assert_generated_class("text-left",  { text_align: :left })
    assert_generated_class("text-left text-sm-right text-md-center", { text_align: [:left, :right, :center] })
  end

  def test_font_family
    assert_generated_class("text-mono", { font_family: :mono })
  end

  def test_font_style
    assert_generated_class("text-italic", { font_style: :italic })
  end

  def test_text_transform
    assert_generated_class("text-uppercase", { text_transform: :uppercase })
  end

  def test_font_weight
    assert_generated_class("text-light",      { font_weight: :light })
    assert_generated_class("text-normal",     { font_weight: :normal })
    assert_generated_class("text-bold",       { font_weight: :bold })
    assert_generated_class("text-semibold",   { font_weight: :semibold })
    assert_generated_class("text-emphasized", { font_weight: :emphasized })
  end

  def test_box_shadow
    assert_generated_class("color-shadow-small",       { box_shadow: true })
    assert_generated_class("color-shadow-small",       { box_shadow: :small })
    assert_generated_class("color-shadow-medium",      { box_shadow: :medium })
    assert_generated_class("color-shadow-large",       { box_shadow: :large })
    assert_generated_class("color-shadow-extra-large", { box_shadow: :extra_large })
    assert_generated_class("box-shadow-none",          { box_shadow: :none })
    assert_generated_class("box-shadow-none",          { box_shadow: false })
  end

  def test_col
    assert_generated_class("col-1", { col: 1 })
    assert_generated_class("col-2", { col: 2 })
    assert_generated_class("col-3", { col: 3 })
    assert_generated_class("col-4", { col: 4 })
    assert_generated_class("col-5", { col: 5 })
    assert_generated_class("col-6", { col: 6 })
    assert_generated_class("col-7", { col: 7 })
    assert_generated_class("col-8", { col: 8 })
    assert_generated_class("col-9", { col: 9 })
    assert_generated_class("col-10", { col: 10 })
    assert_generated_class("col-11", { col: 11 })
    assert_generated_class("col-12", { col: 12 })

    assert_raises ArgumentError do
      Primer::Classify.call(col: 13)
    end
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
    assert_generated_class("color-border-default",            { border_color: :default })
    assert_generated_class("color-border-muted",              { border_color: :muted })
    assert_generated_class("color-border-accent-emphasis",    { border_color: :accent_emphasis })
    assert_generated_class("color-border-success",            { border_color: :success })
    assert_generated_class("color-border-attention-emphasis", { border_color: :attention_emphasis })
    assert_generated_class("color-border-danger",             { border_color: :danger })
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

    assert_raises ArgumentError do
      Primer::Classify.call(justify_content: :invalid_option)
    end
  end

  def test_align_items
    assert_generated_class("flex-items-start", { align_items: :flex_start })
    assert_generated_class("flex-items-end", { align_items: :flex_end })
    assert_generated_class("flex-items-center", { align_items: :center })
    assert_generated_class("flex-items-baseline", { align_items: :baseline })
    assert_generated_class("flex-items-stretch", { align_items: :stretch })

    assert_raises ArgumentError do
      Primer::Classify.call(align_items: :invalid_option)
    end
  end

  def test_flex_wrap
    assert_generated_class("flex-wrap", { flex_wrap: :wrap })
    assert_generated_class("flex-nowrap", { flex_wrap: :nowrap })
    assert_generated_class("flex-wrap-reverse", { flex_wrap: :reverse })

    assert_raises ArgumentError do
      Primer::Classify.call(flex_wrap: :invalid_option)
    end
  end

  def test_flex_direction
    assert_generated_class("flex-column", { direction: :column })
    assert_generated_class("flex-column-reverse", { direction: :column_reverse })
    assert_generated_class("flex-row", { direction: :row })
    assert_generated_class("flex-row-reverse", { direction: :row_reverse })
    assert_generated_class("flex-row flex-sm-column flex-md-row-reverse flex-lg-column-reverse flex-xl-row", { direction: %i[row column row_reverse column_reverse row] })

    assert_raises ArgumentError do
      Primer::Classify.call(direction: :invalid_option)
    end
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
    assert_generated_class("border-bottom border-sm-right border-lg-left", { border: [:bottom, :right, nil, :left, nil] })
    assert_generated_class("rounded-0 rounded-sm-1 rounded-md-2 rounded-lg-2 rounded-xl-3", { border_radius: [0, 1, 2, 2, 3] })
  end

  def test_style
    assert_equal("background-color: #fff;", Primer::Classify.call(style: "background-color: #fff;")[:style])
  end

  def test_flex
    assert_generated_class("flex-1",    { flex: 1 })
    assert_generated_class("flex-auto", { flex: :auto })

    assert_raises ArgumentError do
      Primer::Classify.call(flex: :invalid_option)
    end
  end

  def test_flex_align_self
    assert_generated_class("flex-self-auto",      { align_self: :auto })
    assert_generated_class("flex-self-start",     { align_self: :start })
    assert_generated_class("flex-self-end",       { align_self: :end })
    assert_generated_class("flex-self-center",    { align_self: :center })
    assert_generated_class("flex-self-baseline",  { align_self: :baseline })
    assert_generated_class("flex-self-stretch",   { align_self: :stretch })

    assert_raises ArgumentError do
      Primer::Classify.call(align_self: :invalid_option)
    end
  end

  def test_width_and_height
    assert_generated_class("width-fit", { w: :fit })
    assert_generated_class("width-full", { w: :full })

    assert_generated_class("height-fit", { h: :fit })
    assert_generated_class("height-full", { h: :full })
  end

  def test_flex_grow
    assert_generated_class("flex-grow-0", { flex_grow: 0 })

    assert_raises ArgumentError do
      Primer::Classify.call(flex_grow: :invalid_option)
    end
  end

  def test_flex_shrink
    assert_generated_class("flex-shrink-0", { flex_shrink: 0 })

    assert_raises ArgumentError do
      Primer::Classify.call(flex_shrink: :invalid_option)
    end
  end

  def test_animation
    assert_generated_class("anim-fade-in", { animation: :fade_in })
    assert_generated_class("anim-fade-out", { animation: :fade_out })
    assert_generated_class("anim-fade-up", { animation: :fade_up })
    assert_generated_class("anim-fade-down", { animation: :fade_down })
    assert_generated_class("anim-scale-in", { animation: :scale_in })
    assert_generated_class("anim-grow-x", { animation: :grow_x })
    assert_generated_class("anim-hover-grow", { animation: :hover_grow })
  end

  def test_does_not_raise_error_when_passing_in_a_primer_css_class_name_in_development_and_flag_is_set
    ENV["PRIMER_WARNINGS_DISABLED"] = "1"
    with_raise_on_invalid_options(true) do
      assert_generated_class("color-bg-primary text-center float-left ml-1", { classes: "color-bg-primary text-center float-left ml-1" })
    end
  ensure
    ENV["PRIMER_WARNINGS_DISABLED"] = nil
  end

  def test_does_not_raise_error_when_passing_in_a_primer_css_class_otherwise
    with_raise_on_invalid_options(false) do
      assert_generated_class("color-bg-primary text-center float-left ml-1", { classes: "color-bg-primary text-center float-left ml-1" })
    end
  end

  def test_does_include_leading_trailing_whitespace_in_class
    generated_class = Primer::Classify.call(classes: "foo-class")[:class]
    refute(generated_class.start_with?(" "))
    refute(generated_class.end_with?(" "))
  end

  def test_raises_if_not_using_system_arguments_when_raise_on_invalid_options_is_true
    with_raise_on_invalid_options(true) do
      exception = assert_raises ArgumentError do
        Primer::Classify.call(classes: "d-block")
      end

      assert_includes exception.message, "Use System Arguments (https://primer.style/view-components/system-arguments) instead of Primer CSS class"
    end
  end

  def test_does_not_raise_if_not_using_system_arguments_when_raise_on_invalid_options_is_false
    with_raise_on_invalid_options(false) do
      assert_generated_class("d-block", { classes: "d-block" })
    end
  end

  private

  def assert_generated_class(generated_class_name, input)
    assert_equal(generated_class_name, Primer::Classify.call(**input)[:class])
  end

  def refute_generated_class(input)
    with_validate_class_names(false) do
      assert_nil(Primer::Classify.call(**input)[:class])
    end
  end
end
