# frozen_string_literal: true

require "test_helper"

class PrimerSelectMenuLoadingComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline Primer::SelectMenuLoadingComponent.new do
      "Loading"
    end

    assert_selector("div.SelectMenu-blankslate", text: /Loading/)
  end

  def test_passes_through_extra_options
    render_inline Primer::SelectMenuLoadingComponent.new(
      classes: "my-blankslate",
      mt: 1,
      color: :red,
    ) do
      "Loading"
    end

    assert_selector("div.SelectMenu-blankslate.my-blankslate.mt-1.text-red",
      text: /Loading/)
  end
end
