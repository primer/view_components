# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::ToggleSwitchFormTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_it_renders
    render_inline(ExampleToggleSwitchForm.new(src: "/toggle_switch"))

    assert_selector "toggle-switch[src='/toggle_switch']"
    assert_selector "em", text: "favorite"
  end

  def test_accepts_custom_csrf_token
    bogus_csrf = "let me in"
    render_inline(ExampleToggleSwitchForm.new(csrf: bogus_csrf, src: "/toggle_switch"))
    assert_selector "toggle-switch[data-csrf='#{bogus_csrf}']"
  end

  def test_can_render_without_subclass
    render_inline(
      Primer::Forms::ToggleSwitchForm.new(
        name: :example_field,
        label: "Example",
        src: "/toggle_switch"
      )
    )

    assert_selector "toggle-switch[src='/toggle_switch']"
  end
end
