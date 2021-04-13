# frozen_string_literal: true

require "test_helper"

class PrimerButtonBaseTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::Button::Base.new) { "content" }

    assert_text("content")
  end

  def test_renders_a_as_a_button
    render_inline(Primer::Button::Base.new(tag: :a)) { "content" }

    assert_selector("a[role='button']")
    refute_selector("a[type]")
  end

  def test_renders_summary_as_a_button
    render_inline(Primer::Button::Base.new(tag: :summary)) { "content" }

    assert_selector("summary[role='button']")
    refute_selector("summary[type]")
  end

  def test_renders_href
    render_inline(Primer::Button::Base.new(href: "www.example.com")) { "content" }

    assert_selector("button[href='www.example.com']")
  end

  def test_renders_buttons_as_a_group_item
    render_inline(Primer::Button::Base.new(group_item: true)) { "content" }

    assert_selector("button.BtnGroup-item")
  end

  def test_falls_back_when_variant_isn_t_valid
    without_fetch_or_fallback_raises do
      render_inline(Primer::Button::Base.new(variant: :invalid)) { "content" }

      assert_selector("button")
    end
  end

  def test_renders_with_the_css_class_variant_mapping_to_the_provided_variant
    render_inline(Primer::Button::Base.new(variant: :small)) { "content" }

    assert_selector(".btn-sm")
  end

  def test_renders_button_block
    render_inline(Primer::Button::Base.new(block: true)) { "content" }

    assert_selector(".btn-block")
  end
end
