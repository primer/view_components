# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaOverlayTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_title_and_body
    render_inline(Primer::Alpha::Overlay.new(title: "Title", role: :dialog)) do |component|
      component.with_header
      component.with_body { "Hello" }
    end

    assert_selector("anchored-position[role='dialog']") do
      assert_selector("h1", text: "Title")
      assert_selector(".Overlay-body", text: "Hello")
    end
  end

  def test_does_not_render_header_if_omitted
    render_inline(Primer::Alpha::Overlay.new(title: "Title", role: :dialog)) do |component|
      component.with_body { "Hello" }
    end

    assert_selector("anchored-position[role='dialog'][aria-label='Title']") do
      refute_selector("h1", text: "Title")
      assert_selector(".Overlay-body", text: "Hello")
    end
  end

  def test_renders_with_given_role
    render_inline(Primer::Alpha::Overlay.new(title: "Title", role: :menu)) do |component|
      component.with_body { "Hello" }
    end

    assert_selector("anchored-position[role='menu']")
  end

  def test_renders_show_button
    render_inline(Primer::Alpha::Overlay.new(title: "Title", role: :dialog)) do |component|
      component.with_body { "Hello" }
      component.with_show_button { "Show" }
    end

    assert_selector("[popovertarget]")
  end

  def test_renders_show_icon_button
    render_inline(Primer::Alpha::Overlay.new(title: "Title", role: :dialog)) do |component|
      component.with_body { "Hello" }
      component.with_show_button(icon: :star, "aria-label": "Star")
    end

    assert_selector("[popovertarget]")
  end

  def test_raises_on_missing_title
    error = assert_raises(ArgumentError) do
      render_inline(Primer::Alpha::Overlay.new(role: :dialog))
    end

    assert_includes(error.message, "missing keyword:")
    assert_includes(error.message, "title")
  end

  def test_role_is_optional
    render_inline(Primer::Alpha::Overlay.new(title: "Title")) do |component|
      component.with_header
      component.with_body { "Hello" }
    end

    assert_selector("anchored-position:not([role])") do
      assert_selector("h1", text: "Title")
      assert_selector(".Overlay-body", text: "Hello")
    end
  end

  def test_renders_provided_id
    render_inline(Primer::Alpha::Overlay.new(title: "Title", role: :dialog, id: "my-id")) do |component|
      component.with_body { "content" }
    end

    assert_selector("anchored-position[id='my-id']")
  end

  def test_renders_random_id
    render_inline(Primer::Alpha::Overlay.new(title: "Title", role: :dialog)) do |component|
      component.with_body { "content" }
    end

    assert_selector("anchored-position[id^='overlay-']")
  end

  def test_body_padding
    render_inline(Primer::Alpha::Overlay.new(title: "Title", role: :dialog, padding: :condensed)) do |component|
      component.with_body { "content" }
    end

    assert_selector(".Overlay-body.Overlay-body--paddingCondensed")
  end

  def test_footer_align
    render_inline(Primer::Alpha::Overlay.new(title: "Title", role: :dialog, padding: :condensed)) do |component|
      component.with_footer(align_content: :start) { "content" }
    end

    assert_selector(".Overlay-footer.Overlay-footer--alignStart")
  end
end
