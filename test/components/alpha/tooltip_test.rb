# frozen_string_literal: true

require "components/test_helper"

class PrimerAlphaTooltipTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_default_direction
    text = "This describes the button"
    render_inline(Primer::Alpha::Tooltip.new(type: :description, for_id: "someButton", text: text))
    assert_selector("tool-tip[for='someButton'][data-direction='s']", text: text, visible: false)
  end

  def test_renders_type_label
    text = "This labels the button"
    render_inline(Primer::Alpha::Tooltip.new(type: :label, for_id: "someButton", direction: :n, text: text))
    assert_selector("tool-tip[for='someButton'][data-type='label']", text: text, visible: false)
  end

  def test_renders_type_description
    text = "This describes the button"
    render_inline(Primer::Alpha::Tooltip.new(type: :description, for_id: "someButton", direction: :n, text: text))
    assert_selector("tool-tip[for='someButton'][data-type='description']", text: text, visible: false)
  end

  def test_raises_if_text_is_not_string
    not_text = Primer::Beta::Octicon.new("calendar")
    assert_raises(TypeError, "Tooltip content must be a string") do
      render_inline(Primer::Alpha::Tooltip.new(type: :description, for_id: "someButton", text: not_text, visible: false))
    end
  end

  def test_tooltip_is_position_absolute
    render_inline(Primer::Alpha::Tooltip.new(type: :description, for_id: "someButton", text: "Tooltip"))
    assert_selector("tool-tip.position-absolute", visible: false)
  end
end
