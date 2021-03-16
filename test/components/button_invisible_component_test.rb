# frozen_string_literal: true

require "test_helper"

class PrimerButtonInvisibleComponentTest < PrimerButtonComponentTest
  def button_class
    Primer::ButtonInvisibleComponent
  end

  def test_renders_type_class
    render_inline(button_class.new) { "content" }

    assert_selector(".btn.btn-invisible", text: "content")
  end
end
