# frozen_string_literal: true

require "test_helper"

class PrimerPopoverComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_default_styling
    render_inline(Primer::PopoverComponent.new) do |component|
      component.slot(:message) do
      end
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
end
