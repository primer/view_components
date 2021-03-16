# frozen_string_literal: true

require "test_helper"

class PrimerButtonDangerComponentTest < PrimerButtonComponentTest
  def button_class
    Primer::ButtonDangerComponent
  end

  def test_renders_type_class
    render_inline(button_class.new) { "content" }

    assert_selector(".btn.btn-danger", text: "content")
  end
end
