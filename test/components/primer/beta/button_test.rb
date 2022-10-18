# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaButtonTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::Beta::Button.new) { "Button" }

    assert_selector(".Button", text: "Button")
  end

  def test_warns_on_uses_of_variant
    err = assert_raises ArgumentError do
      render_inline(Primer::Beta::Button.new(variant: :small)) { "Button" }
    end

    assert_equal "The `variant:` argument is no longer supported on Primer::Beta::Button. Consider `scheme:` or `size:`.", err.message
  end

  def test_warns_on_uses_of_dropdown
    err = assert_raises ArgumentError do
      render_inline(Primer::Beta::Button.new(dropdown: true)) { "Button" }
    end

    assert_equal "The `dropdown:` argument is no longer supported on Primer::Beta::Button. Use the `trailing_action` slot instead.", err.message
  end
end
