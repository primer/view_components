# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaAvatarTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_an_avatar
    render_inline(Primer::Beta::Avatar.new(src: "https://github.com/github.png", alt: "github"))

    assert_selector("img.avatar")
  end

  def test_defaults_to_size_20
    render_inline(Primer::Beta::Avatar.new(src: "https://github.com/github.png", alt: "github"))

    assert_selector("img.avatar[size=20][height=20][width=20]")
  end

  def test_falls_back_when_size_isn_t_valid
    without_fetch_or_fallback_raises do
      render_inline(Primer::Beta::Avatar.new(src: "https://github.com/github.png", alt: "github", size: 1_000_000_000))

      assert_selector("img.avatar[size=20][height=20][width=20]")
    end
  end

  def test_defaults_to_circle_avatar
    render_inline(Primer::Beta::Avatar.new(src: "https://github.com/github.png", alt: "github"))

    assert_selector("img.avatar.circle")
  end

  def test_defaults_adds_small_modifier_when_size_is_less_than_threshold
    render_inline(Primer::Beta::Avatar.new(src: "https://github.com/github.png", alt: "github", size: Primer::Beta::Avatar::SMALL_THRESHOLD - 4))

    assert_selector("img.avatar.avatar-small")
  end

  def test_defaults_does_not_add_small_modifier_when_size_is_greater_than_threshold
    render_inline(Primer::Beta::Avatar.new(src: "https://github.com/github.png", alt: "github", size: Primer::Beta::Avatar::SMALL_THRESHOLD + 8))

    assert_selector("img.avatar")
    refute_selector(".avatar-small")
  end

  def test_adds_custom_classes
    render_inline(Primer::Beta::Avatar.new(src: "https://github.com/github.png", alt: "github", classes: "custom-class"))

    assert_selector("img.avatar.custom-class")
  end

  def test_sets_size_height_and_width
    render_inline(Primer::Beta::Avatar.new(src: "https://github.com/github.png", alt: "github", size: 24))

    assert_selector("img.avatar[size=24][height=24][width=24]")
  end

  def test_squared_avatar
    render_inline(Primer::Beta::Avatar.new(src: "https://github.com/github.png", alt: "github", shape: :square))

    assert_selector("img.avatar")
    refute_selector(".circle")
  end

  def test_renders_link_wrapper
    render_inline(Primer::Beta::Avatar.new(src: "https://github.com/github.png", alt: "github", href: "#given-href"))

    assert_selector("a.avatar") do |(a)|
      assert_equal("#given-href", a["href"])
      assert_selector("img")
      refute_selector("img.avatar")
    end
  end

  def test_defaults_circle_link_wrapper
    render_inline(Primer::Beta::Avatar.new(src: "https://github.com/github.png", alt: "github", href: "#"))

    assert_selector("a.avatar.circle") do
      assert_selector("img")
      refute_selector("img.circle")
    end
  end

  def test_squared_link_wrapper
    render_inline(Primer::Beta::Avatar.new(src: "https://github.com/github.png", alt: "github", href: "#", shape: :square))

    assert_selector("a.avatar") do
      assert_selector("img")
    end
    refute_selector(".circle")
  end

  def test_adds_small_modifier_to_link_wrapper_when_size_is_less_than_threshold
    render_inline(Primer::Beta::Avatar.new(src: "https://github.com/github.png", alt: "github", href: "#", size: Primer::Beta::Avatar::SMALL_THRESHOLD - 4))

    assert_selector("a.avatar.avatar-small") do
      assert_selector("img")
      refute_selector("img.avatar-small")
    end
  end

  def test_does_not_add_small_modifier_to_link_wrapper_when_size_is_greater_than_threshold
    render_inline(Primer::Beta::Avatar.new(src: "https://github.com/github.png", alt: "github", href: "#", size: Primer::Beta::Avatar::SMALL_THRESHOLD + 8))

    assert_selector("a.avatar") do
      assert_selector("img")
    end
    refute_selector(".avatar-small")
  end

  def test_adds_custom_classes_to_link_wrapper
    render_inline(Primer::Beta::Avatar.new(src: "https://github.com/github.png", alt: "github", href: "#", classes: "custom-class"))

    assert_selector("a.avatar.custom-class") do
      assert_selector("img")
      refute_selector("img.custom-class")
    end
  end

  def test_clears_link_wrapper_line_height
    render_inline(Primer::Beta::Avatar.new(src: "https://github.com/github.png", alt: "github", href: "#"))

    assert_selector("a.lh-0") do
      assert_selector("img")
      refute_selector("img.lh-0")
    end
  end

  def test_status
    assert_component_state(Primer::Beta::Avatar, :beta)
  end
end
