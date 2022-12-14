# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::ToggleSwitchFormTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_it_renders_with_a_name
    bogus_csrf = "let me in"
    render_inline(ExampleToggleSwitchForm.new(csrf: bogus_csrf))

    assert_selector "toggle-switch[src='/toggle_switch'][csrf='#{bogus_csrf}']"
  end
end
