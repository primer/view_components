# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectGridLayoutTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::GridLayout.new(css_class: "grid-layout", tag: :div)) do |component|
      component.with_area(:area1) do
        "Block 1"
      end
      component.with_area(:area2) do
        "Block 2"
      end
    end

    assert_selector(".grid-layout")
    assert_selector(".grid-layout--area1[style='grid-area: area1']")
    assert_selector(".grid-layout--area2[style='grid-area: area2']")
  end

  def test_does_not_render_with_no_area_provided
    render_inline(Primer::OpenProject::GridLayout.new(css_class: "grid-layout", tag: :div))

    refute_component_rendered
  end
end
