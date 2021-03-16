# frozen_string_literal: true

require "test_helper"

class PrimerButtonOutlineComponentTest < PrimerButtonComponentTest
  def button_class
    Primer::ButtonOutlineComponent
  end

  def test_renders_type_class
    render_inline(button_class.new) { "content" }

    assert_selector(".btn.btn-outline", text: "content")
  end
end
