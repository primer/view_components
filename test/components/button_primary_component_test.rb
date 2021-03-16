# frozen_string_literal: true

require "test_helper"

class PrimerButtonPrimaryComponentTest < PrimerButtonComponentTest
  def button_class
    Primer::ButtonPrimaryComponent
  end

  def test_renders_type_class
    render_inline(button_class.new) { "content" }

    assert_selector(".btn.btn-primary", text: "content")
  end
end
