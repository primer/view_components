# frozen_string_literal: true

require "components/test_helper"

class BlankslateComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_a_basic_blankslate_component_with_a_title
    render_inline(Primer::BlankslateComponent.new(
                    title: "Title",
                    description: "Description"
                  ))

    assert_selector("div.blankslate")
    assert_selector("h3", text: "Title")
    refute_selector(".blankslate-narrow")
    refute_selector(".blankslate-large")
    refute_selector(".blankslate-spacious")
  end

  def test_renders_a_blankslate_component_with_a_title_and_custom_tag
    render_inline(Primer::BlankslateComponent.new(
                    title: "Title",
                    title_tag: :h5
                  ))

    assert_selector("h5", text: "Title")
  end

  def test_renders_a_blankslate_component_with_a_spinner_component
    render_inline(Primer::BlankslateComponent.new(title: "Title")) do |component|
      component.with_spinner(test_selector: "blankslate-spinner")
    end

    assert_selector(".blankslate [data-test-selector='blankslate-spinner']")
  end

  def test_renders_a_narrow_large_and_spacious_blankslate_component
    render_inline(Primer::BlankslateComponent.new(
                    title: "Title",
                    narrow: true,
                    large: true,
                    spacious: true
                  ))

    assert_selector(".blankslate.blankslate-narrow")
    assert_selector(".blankslate.blankslate-large")
    assert_selector(".blankslate.blankslate-spacious")
  end

  def test_renders_a_blankslate_component_with_an_icon
    render_inline(Primer::BlankslateComponent.new(
                    icon: :star,
                    title: "Title"
                  ))

    assert_selector(".blankslate-icon[height=24]")
  end

  def test_renders_a_blankslate_component_with_an_icon_with_a_custom_size
    render_inline(Primer::BlankslateComponent.new(
                    icon: :star,
                    icon_size: :medium,
                    title: "Title"
                  ))

    assert_selector(".blankslate-icon[height=24]")
  end

  def test_renders_a_blankslate_component_with_an_image
    render_inline(Primer::BlankslateComponent.new(
                    image_src: "/some_image",
                    image_alt: "Alt text",
                    title: "Title"
                  ))

    assert_selector(".blankslate > img[src$='/some_image']")
    assert_selector(".blankslate > img[alt='Alt text']")
  end

  def test_renders_a_blankslate_component_with_a_description
    render_inline(Primer::BlankslateComponent.new(
                    title: "Title",
                    description: "Description"
                  ))

    assert_selector("p", text: "Description")
  end

  def test_renders_a_blankslate_component_with_custom_content
    render_inline(Primer::BlankslateComponent.new(
                    icon: :star,
                    title: "Title"
                  )) { "Custom content" }

    assert_text("Custom content")
  end

  def test_renders_a_blankslate_component_with_a_button
    render_inline(Primer::BlankslateComponent.new(
                    title: "Title",
                    button_text: "Button",
                    button_url: "https://github.com"
                  ))

    assert_selector("a.btn[href='https://github.com']", text: "Button")
  end

  def test_renders_a_blankslate_component_with_a_button_with_custom_classes
    render_inline(Primer::BlankslateComponent.new(
                    title: "Title",
                    button_text: "Button",
                    button_url: "https://github.com",
                    button_classes: "btn-outline"
                  ))

    assert_selector("a.btn.btn-outline[href='https://github.com']", text: "Button")
  end

  def test_renders_a_blankslate_component_with_a_link
    render_inline(Primer::BlankslateComponent.new(
                    title: "Title",
                    link_text: "Link",
                    link_url: "https://docs.github.com"
                  ))

    assert_selector("a[href='https://docs.github.com']", text: "Link")
  end

  def test_status
    assert_component_state(Primer::BlankslateComponent, :deprecated)
  end
end
