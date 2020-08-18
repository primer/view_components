# frozen_string_literal: true

require "test_helper"

class PrimerPopoverComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_default_styling
    render_inline(Primer::PopoverComponent.new) do |component|
      component.slot(:message)
      component.slot(:heading) do
        "My header"
      end
      component.slot(:body) do
        "My body"
      end
      component.slot(:button) do
        "My button"
      end
    end

    assert_selector("div.Popover div.Popover-message h4.mb-2", text: "My header")
    assert_selector("div.Popover div.Popover-message", text: "My body")
    assert_selector("div.Popover div.Popover-message button.btn.btn-outline.mt-2.text-bold",
      text: "My button")
  end

  def test_respects_message_caret_option
    render_inline(Primer::PopoverComponent.new) do |component|
      component.slot(:message, caret: :left_bottom)
    end

    assert_selector("div.Popover div.Popover-message.Popover-message--left-bottom")
  end

  def test_respects_message_large_option
    render_inline(Primer::PopoverComponent.new) do |component|
      component.slot(:message, large: true)
    end

    assert_selector("div.Popover div.Popover-message.Popover-message--large")
  end

  def test_allows_message_customization
    render_inline(Primer::PopoverComponent.new) do |component|
      component.slot(:message, p: 3, mt: 1, mx: 4, text_align: :right)
    end

    assert_selector("div.Popover div.Popover-message.p-3.mt-1.mx-4.text-right")
  end

  def test_allows_heading_customization
    render_inline(Primer::PopoverComponent.new) do |component|
      component.slot(:message)
      component.slot(:heading, mb: 4, pr: 3, tag: :h3) do
        "Hello world"
      end
    end

    assert_selector("div.Popover div.Popover-message h3.mb-4.pr-3", text: "Hello world")
  end

  def test_allows_button_customization
    render_inline(Primer::PopoverComponent.new) do |component|
      component.slot(:message)
      component.slot(:button, mt: 1, button_type: :danger, font_weight: :normal) do
        "A lovely day"
      end
    end

    assert_selector("div.Popover div.Popover-message button.btn.btn-danger.mt-1.text-normal",
      text: "A lovely day")
  end

  def test_allows_different_tag_for_button_slot
    render_inline(Primer::PopoverComponent.new) do |component|
      component.slot(:message)
      component.slot(:button, tag: :summary) do
        "Neat music"
      end
    end

    assert_selector("div.Popover div.Popover-message summary.mt-2.text-bold",
      text: "Neat music")
  end
end
