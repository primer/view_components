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

    # Labelling is also done in js, but we test it here where js doesn't execute to ensure
    # it's also rendered server-side. This prevents race conditions when axe checking.
    tooltip_id = page.find_css("tool-tip")[0].attributes["id"].value
    assert_selector(".Button.Button--iconOnly[aria-labelledby='#{tooltip_id}']")
  end

  def test_renders_description_tooltip
    render_inline(Primer::Beta::IconButton.new(icon: :star, "aria-label": "Star", "aria-description": "Star this repository"))

    assert_selector("tool-tip", text: "Star this repository", visible: :all)

    # Labelling is also done in js, but we test it here where js doesn't execute to ensure
    # it's also rendered server-side. This prevents race conditions when axe checking.
    tooltip_id = page.find_css("tool-tip")[0].attributes["id"].value
    assert_selector(".Button.Button--iconOnly[aria-describedby='#{tooltip_id}']")
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

  def test_aria_label_is_set_when_tooltips_are_hidden
    render_inline(Primer::Beta::IconButton.new(icon: :star, "aria-label": "Star", show_tooltip: false))
    assert_selector("[aria-label='Star']")
  end

  def test_forces_button_tag_when_disabled
    render_inline(Primer::Beta::IconButton.new(icon: :star, "aria-label": "Star", disabled: true, tag: :a))
    assert_selector(".Button-withTooltip button[disabled]")
  end
end
