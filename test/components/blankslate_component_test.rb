# frozen_string_literal: true

require "test_helper"

class BlankslateComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  test "renders a basic blankslate component with a title" do
    render_inline(Primer::BlankslateComponent.new(
      title: "Title",
      description: "Description",
    ))

    assert_selector("div.blankslate")
    assert_selector("h3", text: "Title")
    refute_selector(".blankslate-narrow")
  end

  test "renders a narrow blankslate component" do
    render_inline(Primer::BlankslateComponent.new(
      title: "Title",
      narrow: true,
    ))

    assert_selector(".blankslate.blankslate-narrow")
  end

  test "renders a blankslate component with an icon" do
    render_inline(Primer::BlankslateComponent.new(
      icon: "octoface",
      title: "Title",
    ))

    assert_selector(".blankslate-icon")
  end

  test "renders a blankslate component with an image" do
    render_inline(Primer::BlankslateComponent.new(
      image_src: "file.svg",
      image_alt: "Alt text",
      title: "Title",
    ))

    assert_selector(".blankslate > img[src$='file.svg']")
    assert_selector(".blankslate > img[alt='Alt text']")
  end

  test "renders a blankslate component with a description" do
    render_inline(Primer::BlankslateComponent.new(
      title: "Title",
      description: "Description",
    ))

    assert_selector("p", text: "Description")
  end

  test "renders a blankslate component with custom content" do
    render_inline(Primer::BlankslateComponent.new(
      icon: "octoface",
      title: "Title",
    )) { "Custom content" }

    assert_text("Custom content")
  end

  test "renders a blankslate component with a button" do
    render_inline(Primer::BlankslateComponent.new(
      title: "Title",
      button_text: "Button",
      button_url: "https://github.com",
    ))

    assert_selector("a.btn[href='https://github.com']", text: "Button")
  end

  test "renders a blankslate component with a link" do
    render_inline(Primer::BlankslateComponent.new(
      title: "Title",
      link_text: "Link",
      link_url: "https://docs.github.com",
    ))

    assert_selector("a[href='https://docs.github.com']", text: "Link")
  end
end
