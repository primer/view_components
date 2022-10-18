# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaIconButtonTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::Beta::IconButton.new(icon: :star, "aria-label": "Star"))

    assert_selector(".Button.Button--iconOnly") do
      assert_selector(".Button-visual")
    end
    assert_selector("tool-tip", text: "Star", visible: :all)
  end

  def test_renders_description_tooltip
    render_inline(Primer::Beta::IconButton.new(icon: :star, "aria-label": "Star", "aria-description": "Star this repository"))

    assert_selector("tool-tip", text: "Star this repository", visible: :all)
  end

  def test_adds_wrapper_arguments
    render_inline(Primer::Beta::IconButton.new(icon: :star, "aria-label": "Star", wrapper_arguments: { id: "foo" }))

    assert_selector(".Button-withTooltip#foo")
  end

  def test_allows_hiding_tooltip
    render_inline(Primer::Beta::IconButton.new(icon: :star, "aria-label": "Star", show_tooltip: false))

    refute_selector(".Button-withTooltip")
    refute_selector("tool-tip")
  end
end
