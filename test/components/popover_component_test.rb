# frozen_string_literal: true

require "components/test_helper"

class PrimerPopoverComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_default_styling
    render_inline(Primer::PopoverComponent.new) do |component|
      component.heading do
        "My header"
      end
      component.body do
        "My body"
      end
    end

    assert_selector("div.Popover.right-0.left-0")
    assert_selector("div.Popover div.Popover-message h4.mb-2", text: "My header")
    assert_selector("div.Popover div.Popover-message.Box.color-shadow-large", text: "My body")
  end

  def test_without_left_and_right_classes
    render_inline(Primer::PopoverComponent.new(left: true, right: true)) do |component|
      component.heading do
        "My header"
      end
      component.body do
        "My body"
      end
    end

    assert_selector("div.Popover")
    refute_selector(".right-0.left-0")
    assert_selector("div.Popover div.Popover-message h4.mb-2", text: "My header")
    assert_selector("div.Popover div.Popover-message.Box.color-shadow-large", text: "My body")
  end

  def test_allows_customization
    render_inline(Primer::PopoverComponent.new(
                    position: :absolute, classes: "custom-class"
                  )) do |component|
      component.body do
        "Hi there"
      end
    end

    assert_selector("div.Popover.position-absolute.custom-class", text: "Hi there")
  end

  def test_respects_message_caret_option
    render_inline(Primer::PopoverComponent.new) do |component|
      component.body(caret: :left_bottom)
    end

    assert_selector("div.Popover div.Popover-message.Popover-message--left-bottom.Box")
  end

  def test_respects_message_large_option
    render_inline(Primer::PopoverComponent.new) do |component|
      component.body(large: true)
    end

    assert_selector("div.Popover div.Popover-message.Popover-message--large.Box")
  end

  def test_allows_message_customization
    render_inline(Primer::PopoverComponent.new) do |component|
      component.body(p: 3, mt: 1, mx: 4, text_align: :right)
    end

    assert_selector("div.Popover div.Popover-message.Box.p-3.mt-1.mx-4.text-right")
  end

  def test_allows_heading_customization
    render_inline(Primer::PopoverComponent.new) do |component|
      component.body { "Foo" }
      component.heading(mb: 4, pr: 3, tag: :h3) do
        "Hello world"
      end
    end

    assert_selector("div.Popover div.Popover-message.Box h3.mb-4.pr-3", text: "Hello world")
  end

  def test_status
    assert_component_state(Primer::PopoverComponent, :beta)
  end
end
