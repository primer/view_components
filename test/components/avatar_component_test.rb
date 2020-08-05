# frozen_string_literal: true

require "test_helper"

class PrimerAvatarComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_an_avatar
    render_inline(Primer::AvatarComponent.new(src: "https://github.com/github.png", alt: "github", size: 2))

    assert_selector("img.avatar")
  end

  def test_defaults_to_no_size_modifier
    without_fetch_or_fallback_raises do
      render_inline(Primer::AvatarComponent.new(src: "https://github.com/github.png", alt: "github"))
    end

    assert_selector("img.avatar")
  end

  def test_defaults_adds_size_modifier
    render_inline(Primer::AvatarComponent.new(src: "https://github.com/github.png", alt: "github", size: 2))

    assert_selector("img.avatar.avatar-2")
  end
end
