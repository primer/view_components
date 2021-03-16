# frozen_string_literal: true

require "test_helper"
require_relative "button_component_test"

class PrimerButtonBlockComponentTest < PrimerButtonComponentTest
  def button_class
    Primer::ButtonBlockComponent
  end

  def test_renders_type_class
    render_inline(button_class.new) { "content" }

    assert_selector(".btn.btn-block", text: "content")
  end
end
