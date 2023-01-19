# frozen_string_literal: true

require "components/test_helper"

class PrimerAvatarStackTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_as_a_div_by_default
    render_inline(Primer::Beta::AvatarStack.new) do |component|
      component.with_avatar(src: "Foo", alt: "Bar")
    end

    assert_selector("div.AvatarStack")
  end

  def test_renders_as_a_span
    render_inline(Primer::Beta::AvatarStack.new(tag: :span)) do |component|
      component.with_avatar(src: "Foo", alt: "Bar")
    end
    assert_selector("span.AvatarStack")
  end

  def test_falls_back_when_tag_isnt_valid
    without_fetch_or_fallback_raises do
      render_inline(Primer::Beta::AvatarStack.new(tag: :h1)) do |component|
        component.with_avatar(src: "Foo", alt: "Bar")
      end
      assert_selector("div.AvatarStack")
    end
  end

  def test_falls_back_when_body_tag_isnt_valid
    without_fetch_or_fallback_raises do
      render_inline(Primer::Beta::AvatarStack.new(body_arguments: { tag: :h1 })) do |component|
        component.with_avatar(src: "Foo", alt: "Bar")
      end
      assert_selector("div.AvatarStack-body")
    end
  end

  def test_does_not_render_without_avatars
    render_inline(Primer::Beta::AvatarStack.new)

    refute_component_rendered
  end

  def test_renders_default_body
    render_inline(Primer::Beta::AvatarStack.new) do |component|
      component.with_avatar(src: "Foo", alt: "Bar")
    end

    assert_selector(".AvatarStack") do
      refute_selector(".toltipped")
      assert_selector(".AvatarStack-body") do
        assert_selector("img.avatar", count: 1)
      end
    end
  end

  def test_renders_tooltipped_body
    render_inline(Primer::Beta::AvatarStack.new(tooltipped: true, body_arguments: { label: "Tooltip" })) do |component|
      component.with_avatar(src: "Foo", alt: "Bar")
    end

    assert_selector(".AvatarStack") do
      assert_selector("div[aria-label=\"Tooltip\"].AvatarStack-body.tooltipped") do
        assert_selector("img.avatar", count: 1)
      end
    end
  end

  def test_renders_right_aligned
    render_inline(Primer::Beta::AvatarStack.new(align: :right)) do |component|
      component.with_avatar(src: "Foo", alt: "Bar")
    end

    assert_selector(".AvatarStack.AvatarStack--right") do
      refute_selector(".toltipped")
      assert_selector(".AvatarStack-body") do
        assert_selector("img.avatar", count: 1)
      end
    end
  end

  def test_renders_two_avatar_stack
    render_inline(Primer::Beta::AvatarStack.new) do |component|
      component.with_avatar(src: "Foo", alt: "Bar")
      component.with_avatar(src: "Foo", alt: "Bar")
    end

    assert_selector(".AvatarStack.AvatarStack--two") do
      assert_selector(".AvatarStack-body") do
        assert_selector("img.avatar", count: 2)
      end
    end
  end

  def test_renders_three_plus_avatar_stack
    render_inline(Primer::Beta::AvatarStack.new) do |component|
      component.with_avatar(src: "Foo", alt: "Bar")
      component.with_avatar(src: "Foo", alt: "Bar")
      component.with_avatar(src: "Foo", alt: "Bar")
    end

    assert_selector(".AvatarStack.AvatarStack--three-plus") do
      assert_selector(".AvatarStack-body") do
        assert_selector("img.avatar", count: 3)
        assert_selector(".avatar.avatar-more", count: 1)
      end
    end
  end
end
