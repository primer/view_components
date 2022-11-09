# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::ToggleSwitchFormTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_it_renders_with_a_name
    render_inline(ExampleToggleSwitchForm.new)

    assert_selector "input[name=example_field]"
    assert_selector "label", text: "Example"
    assert_selector "em", text: "favorite"
  end
end
