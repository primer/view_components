# frozen_string_literal: true

require "test_helper"

class PrimerAvatarStackComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_without_avatars
    render_inline(Primer::AvatarStackComponent.new)

    refute_component_rendered
  end

  def test_renders_default_body
    render_inline(Primer::AvatarStackComponent.new) do |c|
      c.avatar(src: "Foo", alt: "Bar")
    end

    assert_selector(".AvatarStack") do
      refute_selector(".toltipped")
      assert_selector(".AvatarStack-body") do
        assert_selector("img.avatar", count: 1)
      end
    end
  end

  def test_renders_tooltipped_body
    render_inline(Primer::AvatarStackComponent.new(tooltipped: true, body_arguments: { label: 'Tooltip' })) do |c|
      c.avatar(src: "Foo", alt: "Bar")
    end

    assert_selector(".AvatarStack") do
      assert_selector("div[aria-label=\"Tooltip\"].AvatarStack-body.tooltipped") do
        assert_selector("img.avatar", count: 1)
      end
    end
  end

  def test_renders_right_aligned
    render_inline(Primer::AvatarStackComponent.new(align: :right)) do |c|
      c.avatar(src: "Foo", alt: "Bar")
    end

    assert_selector(".AvatarStack.AvatarStack--right") do
      refute_selector(".toltipped")
      assert_selector(".AvatarStack-body") do
        assert_selector("img.avatar", count: 1)
      end
    end
  end

  def test_renders_two_avatar_stack
    render_inline(Primer::AvatarStackComponent.new) do |c|
      c.avatar(src: "Foo", alt: "Bar")
      c.avatar(src: "Foo", alt: "Bar")
    end

    assert_selector(".AvatarStack.AvatarStack--two") do
      assert_selector(".AvatarStack-body") do
        assert_selector("img.avatar", count: 2)
      end
    end
  end

  def test_renders_three_plus_avatar_stack
    render_inline(Primer::AvatarStackComponent.new) do |c|
      c.avatar(src: "Foo", alt: "Bar")
      c.avatar(src: "Foo", alt: "Bar")
      c.avatar(src: "Foo", alt: "Bar")
    end

    assert_selector(".AvatarStack.AvatarStack--three-plus") do
      assert_selector(".AvatarStack-body") do
        assert_selector("img.avatar", count: 3)
        assert_selector(".avatar.avatar-more", count: 1)
      end
    end
  end
end
