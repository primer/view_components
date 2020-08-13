# frozen_string_literal: true

require "test_helper"

class PrimerAvatarComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_an_avatar
    render_inline(Primer::AvatarComponent.new(src: "https://github.com/github.png", alt: "github"))

    assert_selector("img.avatar")
  end

  def test_defaults_to_size_20
    render_inline(Primer::AvatarComponent.new(src: "https://github.com/github.png", alt: "github"))

    assert_selector("img.avatar[size=20][height=20][width=20]")
  end

  def test_defaults_to_circle_avatar
    render_inline(Primer::AvatarComponent.new(src: "https://github.com/github.png", alt: "github"))

    assert_selector("img.avatar.CircleBadge")
  end

  def test_defaults_adds_small_modifier_when_size_is_less_than_threshold
    render_inline(Primer::AvatarComponent.new(src: "https://github.com/github.png", alt: "github", size: Primer::AvatarComponent::SMALL_THRESHOLD - 1))

    assert_selector("img.avatar.avatar--small")
  end

  def test_defaults_does_not_add_small_modifier_when_size_is_greater_than_threshold
    render_inline(Primer::AvatarComponent.new(src: "https://github.com/github.png", alt: "github", size: Primer::AvatarComponent::SMALL_THRESHOLD + 1))

    assert_selector("img.avatar")
    refute_selector(".avatar--small")
  end

  def test_sets_size_height_and_width
    render_inline(Primer::AvatarComponent.new(src: "https://github.com/github.png", alt: "github", size: 50))

    assert_selector("img.avatar[size=50][height=50][width=50]")
  end

  def test_squared_avatar
    render_inline(Primer::AvatarComponent.new(src: "https://github.com/github.png", alt: "github", square: true))

    assert_selector("img.avatar")
    refute_selector(".CircleBadge")
  end
end
