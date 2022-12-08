# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaBlankslateTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_a_basic_blankslate_component_with_a_heading
    render_inline(Primer::Beta::Blankslate.new) do |c|
      c.heading(tag: :h3).with_content("Title")
    end

    assert_selector("div.blankslate")
    assert_selector("h3.blankslate-heading", text: "Title")
    refute_selector(".blankslate-narrow")
    refute_selector(".blankslate-spacious")
  end

  def test_renders_a_blankslate_component_with_a_spinner_component
    render_inline(Primer::Beta::Blankslate.new) do |c|
      c.heading(tag: :h2).with_content("Title")
      c.visual_spinner(test_selector: "blankslate-spinner")
    end

    assert_selector(".blankslate") do
      assert_selector("svg[data-test-selector='blankslate-spinner']")
    end
  end

  def test_renders_a_narrow_and_spacious_blankslate_component
    render_inline(Primer::Beta::Blankslate.new(narrow: true, spacious: true)) do |c|
      c.heading(tag: :h2).with_content("Title")
    end

    assert_selector(".blankslate.blankslate-narrow")
    assert_selector(".blankslate.blankslate-spacious")
  end

  def test_renders_a_blankslate_component_with_an_icon
    render_inline(Primer::Beta::Blankslate.new) do |c|
      c.visual_icon(icon: :star)
      c.heading(tag: :h2).with_content("Title")
    end

    assert_selector(".blankslate-icon[height=24]")
  end

  def test_renders_a_blankslate_component_with_an_icon_with_a_custom_size
    render_inline(Primer::Beta::Blankslate.new) do |c|
      c.visual_icon(icon: :star, size: :small)
      c.heading(tag: :h3).with_content("Title")
    end

    assert_selector(".blankslate-icon[height=16]")
  end

  def test_renders_a_blankslate_component_with_an_image
    render_inline(Primer::Beta::Blankslate.new) do |c|
      c.heading(tag: :h3).with_content("Title")
      c.visual_image(src: "/some_image", alt: "Alt text")
    end

    assert_selector(".blankslate > img[src$='/some_image']")
    assert_selector(".blankslate > img[alt='Alt text']")
  end

  def test_renders_a_blankslate_component_with_a_description
    render_inline(Primer::Beta::Blankslate.new) do |c|
      c.heading(tag: :h3).with_content("Title")
      c.description { "Description" }
    end

    assert_selector("div", text: "Description")
  end

  def test_renders_a_blankslate_component_with_a_primary_action
    render_inline(Primer::Beta::Blankslate.new) do |c|
      c.heading(tag: :h2).with_content("Title")
      c.primary_action(href: "https://github.com").with_content("Button")
    end

    assert_selector("a.Button[href='https://github.com']", text: "Button")
  end

  def test_renders_a_blankslate_component_with_a_primary_action_with_custom_classes
    render_inline(Primer::Beta::Blankslate.new) do |c|
      c.heading(tag: :h2).with_content("Title")
      c.primary_action(href: "https://github.com", scheme: :danger).with_content("Button")
    end

    assert_selector("a.Button.Button--danger[href='https://github.com']", text: "Button")
  end

  def test_renders_a_blankslate_component_with_a_secondary_action
    render_inline(Primer::Beta::Blankslate.new) do |c|
      c.heading(tag: :h2).with_content("Title")
      c.secondary_action(href: "https://docs.github.com").with_content("Link")
    end

    assert_selector("a[href='https://docs.github.com']", text: "Link")
  end

  def test_wraps_in_a_box_when_border_true
    render_inline(Primer::Beta::Blankslate.new(border: true)) do |c|
      c.heading(tag: :h2) { "Title" }
    end

    assert_selector(".Box") do
      assert_selector(".blankslate") do
        assert_selector("h2", text: "Title")
      end
    end
  end
end
