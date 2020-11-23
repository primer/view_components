# frozen_string_literal: true

require "test_helper"

class PrimerSelectMenuBlankslateComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline Primer::SelectMenuBlankslateComponent.new do
      "No results"
    end

    assert_selector("div.SelectMenu-blankslate", text: /No results/)
  end

  def test_passes_through_extra_options
    render_inline Primer::SelectMenuBlankslateComponent.new(
      classes: "my-blankslate",
      mt: 1,
      color: :red,
    ) do
      "No results"
    end

    assert_selector("div.SelectMenu-blankslate.my-blankslate.mt-1.text-red",
      text: /No results/)
  end
end
