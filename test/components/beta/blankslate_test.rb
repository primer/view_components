# frozen_string_literal: true

require "test_helper"

class PrimerBetaBlankslateTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_a_basic_blankslate_component_with_a_title
    render_inline(Primer::Beta::Blankslate.new) do |c|
      c.title(tag: :h3).with_content("Title")
    end

    assert_selector("div.blankslate")
    assert_selector("h3.h2", text: "Title")
    refute_selector(".blankslate-narrow")
    refute_selector(".blankslate-large")
    refute_selector(".blankslate-spacious")
  end

  def test_renders_a_blankslate_component_with_a_spinner_component
    render_inline(Primer::Beta::Blankslate.new) do |c|
      c.title(tag: :h2).with_content("Title")
      c.graphic_spinner(test_selector: "blankslate-spinner")
    end

    assert_selector(".blankslate") do
      assert_selector("span[role='status']") do
        assert_selector(".sr-only", text: "Loading")
        assert_selector("[data-test-selector='blankslate-spinner']")
      end
    end
  end

  def test_renders_a_narrow_large_and_spacious_blankslate_component
    render_inline(Primer::Beta::Blankslate.new(narrow: true, large: true, spacious: true)) do |c|
      c.title(tag: :h2).with_content("Title")
    end

    assert_selector(".blankslate.blankslate-narrow")
    assert_selector(".blankslate.blankslate-large")
    assert_selector(".blankslate.blankslate-spacious")
  end

  def test_renders_a_blankslate_component_with_an_icon
    render_inline(Primer::Beta::Blankslate.new) do |c|
      c.graphic_icon(icon: :star)
      c.title(tag: :h2).with_content("Title")
    end

    assert_selector(".blankslate-icon[height=24]")
  end

  def test_renders_a_blankslate_component_with_an_icon_with_a_custom_size
    render_inline(Primer::Beta::Blankslate.new) do |c|
      c.graphic_icon(icon: :star, size: :small)
      c.title(tag: :h3).with_content("Title")
    end

    assert_selector(".blankslate-icon[height=16]")
  end

  def test_renders_a_blankslate_component_with_an_image
    render_inline(Primer::Beta::Blankslate.new) do |c|
      c.title(tag: :h3).with_content("Title")
      c.graphic_image(src: "/some_image", alt: "Alt text")
    end

    assert_selector(".blankslate > img[src$='/some_image']")
    assert_selector(".blankslate > img[alt='Alt text']")
  end

  def test_renders_a_blankslate_component_with_a_description
    render_inline(Primer::Beta::Blankslate.new) do |c|
      c.title(tag: :h3).with_content("Title")
      c.description { "Description" }
    end

    assert_selector("p", text: "Description")
  end

  def test_renders_a_blankslate_component_with_a_priamry_action
    render_inline(Primer::Beta::Blankslate.new) do |c|
      c.title(tag: :h2).with_content("Title")
      c.primary_action(href: "https://github.com").with_content("Button")
    end

    assert_selector("a.btn[href='https://github.com']", text: "Button")
  end

  def test_renders_a_blankslate_component_with_a_priamry_action_with_custom_classes
    render_inline(Primer::Beta::Blankslate.new) do |c|
      c.title(tag: :h2).with_content("Title")
      c.primary_action(href: "https://github.com", scheme: :outline).with_content("Button")
    end

    assert_selector("a.btn.btn-outline[href='https://github.com']", text: "Button")
  end

  def test_renders_a_blankslate_component_with_a_secondary_action
    render_inline(Primer::Beta::Blankslate.new) do |c|
      c.title(tag: :h2).with_content("Title")
      c.secondary_action(href: "https://docs.github.com").with_content("Link")
    end

    assert_selector("a[href='https://docs.github.com']", text: "Link")
  end

  def test_wraps_in_a_box_when_border_true
    render_inline(Primer::Beta::Blankslate.new(border: true)) do |c|
      c.title(tag: :h2) { "Title" }
    end

    assert_selector(".Box") do
      assert_selector(".blankslate") do
        assert_selector("h2", text: "Title")
      end
    end
  end
end
