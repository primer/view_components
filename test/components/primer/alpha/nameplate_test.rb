# frozen_string_literal: true

require "test_helper"

class PrimerAlphaNameplateTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_without_avatar
    render_inline(Primer::Alpha::Nameplate.new(title: "title"))

    refute_component_rendered
  end

  def test_renders_title_and_avatar
    render_inline(Primer::Alpha::Nameplate.new(title: "title")) do |c|
      c.avatar(src: "image.png")
    end

    assert_selector("span.d-flex") do
      assert_selector(".avatar[src='image.png']")
      assert_selector(".d-flex.flex-column") do
        assert_selector("span.text-bold", text: "title")
      end
    end
  end

  def test_does_not_set_aria_label_without_description
    render_inline(Primer::Alpha::Nameplate.new(title: "title")) do |c|
      c.avatar(src: "imange.png")
    end

    refute_selector("span[aria-label]")
  end

  def test_renders_title_avatar_and_description
    render_inline(Primer::Alpha::Nameplate.new(title: "title", description: "description")) do |c|
      c.avatar(src: "image.png")
    end

    assert_selector("span.d-flex[aria-label='title (description)']") do
      assert_selector(".avatar[src='image.png']")
      assert_selector(".d-flex.flex-column") do
        assert_selector("span.text-bold", text: "title")
        assert_selector("span.text-bold", text: "description")
      end
    end
  end
end
