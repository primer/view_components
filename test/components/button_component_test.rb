# frozen_string_literal: true

require "components/test_helper"

class PrimerButtonComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_content
    render_inline(Primer::ButtonComponent.new) { "content" }

    assert_text("content")
  end

  def test_defaults_button_tag_with_scheme
    render_inline(Primer::ButtonComponent.new) { "content" }

    assert_selector("button.btn[type='button']")
  end

  def test_renders_a_without_button_role
    render_inline(Primer::ButtonComponent.new(tag: :a)) { "content" }

    assert_selector("a.btn")
    refute_selector("a.btn[role='button']")
    refute_selector("a[type]")
  end

  def test_renders_summary_without_button_role
    render_inline(Primer::ButtonComponent.new(tag: :summary)) { "content" }

    assert_selector("summary.btn")
    refute_selector("summary.btn[role='button']")
    refute_selector("summary[type]")
  end

  def test_renders_href
    render_inline(Primer::ButtonComponent.new(href: "www.example.com")) { "content" }

    assert_selector("button[href='www.example.com']")
  end

  def test_renders_buttons_as_a_group_item
    render_inline(Primer::ButtonComponent.new(group_item: true)) { "content" }

    assert_selector("button.btn.BtnGroup-item")
  end

  def test_falls_back_when_type_isn_t_valid
    without_fetch_or_fallback_raises do
      render_inline(Primer::ButtonComponent.new(scheme: :invalid)) { "content" }

      assert_selector(".btn")
    end
  end

  def test_renders_with_the_css_class_mapping_to_the_provided_type
    render_inline(Primer::ButtonComponent.new(scheme: :primary)) { "content" }

    assert_selector(".btn.btn-primary")
  end

  def test_falls_back_when_size_isn_t_valid
    without_fetch_or_fallback_raises do
      render_inline(Primer::ButtonComponent.new(size: :invalid)) { "content" }

      assert_selector(".btn")
    end
  end

  def test_renders_with_the_css_class_size_mapping_to_the_provided_size
    render_inline(Primer::ButtonComponent.new(size: :small)) { "content" }

    assert_selector(".btn.btn-sm")
  end

  def test_renders_with_the_css_class_size_mapping_to_the_provided_variant
    render_inline(Primer::ButtonComponent.new(variant: :small)) { "content" } # rubocop:disable Primer/DeprecatedButtonArguments

    assert_selector(".btn.btn-sm")
  end

  def test_does_not_add_btn_class_if_link
    render_inline(Primer::ButtonComponent.new(scheme: :link)) { "content" }

    assert_selector(".btn-link")
    refute_selector(".btn")
  end

  def test_renders_button_block
    render_inline(Primer::ButtonComponent.new(block: true)) { "content" }

    assert_selector(".btn.btn-block")
  end

  def test_renders_button_block_with_scheme
    render_inline(Primer::ButtonComponent.new(block: true, scheme: :primary)) { "content" }

    assert_selector(".btn.btn-primary.btn-block")
  end

  def test_renders_leading_visual
    render_inline(Primer::ButtonComponent.new) do |component|
      component.with_leading_visual_icon(icon: :star)
      "Button"
    end

    assert_selector(".btn") do
      assert_selector(".octicon.octicon-star")
      assert_text("Button")
    end
  end

  def test_renders_trailing_visual
    render_inline(Primer::ButtonComponent.new) do |component|
      component.with_trailing_visual_counter(count: 10)
      "Button"
    end

    assert_selector(".btn") do
      assert_selector(".Counter", text: "10")
      assert_text("Button")
    end
  end

  def test_renders_leading_and_trailing_visuals
    render_inline(Primer::ButtonComponent.new) do |component|
      component.with_leading_visual_icon(icon: :star)
      component.with_trailing_visual_counter(count: 10)
      "Button"
    end

    assert_selector(".btn") do
      assert_selector(".octicon.octicon-star")
      assert_selector(".Counter", text: "10")
      assert_text("Button")
    end
  end

  def test_renders_using_icon_and_counter
    render_inline(Primer::ButtonComponent.new) do |component|
      component.icon(icon: :star)
      component.counter(count: 10)
      "Button"
    end

    assert_selector(".btn") do
      assert_selector(".octicon.octicon-star")
      assert_selector(".Counter", text: "10")
      assert_text("Button")
    end
  end

  def test_renders_dropdown_caret
    render_inline(Primer::ButtonComponent.new(dropdown: true).with_content("Button"))

    assert_selector(".btn") do
      assert_text("Button")
      assert_selector(".octicon.octicon-triangle-down")
    end
  end

  def test_renders_button_with_tooltip
    render_inline(Primer::ButtonComponent.new(id: "button-id")) do |component|
      component.with_tooltip(text: "Tooltip", type: :description)
      "Button"
    end

    assert_selector(".btn", text: "Button")
    assert_selector(".btn ~ tool-tip[for='button-id']", visible: false)
  end

  def test_warns_on_use_of_tooltip_without_id
    err = assert_raises ArgumentError do
      render_inline(Primer::ButtonComponent.new) do |component|
        component.with_tooltip(text: "Tooltip")
        "Button"
      end
    end

    assert_equal "Buttons with a tooltip must have a unique `id` set on the `Button`.", err.message
  end
end
