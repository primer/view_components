# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectSubHeaderTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::SubHeader.new) do |component|
      component.with_filter_input(name: "filter", label: "Filter")
      component.with_action_button(scheme: :primary) do |button|
        button.with_leading_visual_icon(icon: :plus)
        "Create"
      end
    end

    assert_selector(".SubHeader")
    assert_selector(".SubHeader-filterInput")
    assert_selector(".SubHeader .Button--primary")
  end

  def test_renders_an_icon_button_as_action
    render_inline(Primer::OpenProject::SubHeader.new) do |component|
      component.with_action_button(icon: :plus, aria: { label: "Create" })
    end

    assert_selector(".SubHeader")
    assert_selector(".SubHeader .Button--iconOnly")
  end

  def test_renders_a_custom_button_as_action
    render_inline(Primer::OpenProject::SubHeader.new) do |component|
      component.with_action_component do
        "<div class='ButtonGroup'><div><button class='MyCustomClass'>Button 1</button></div><div><button class='MyCustomClass'>Button 2</button></div></div>".html_safe
      end
    end

    assert_selector(".SubHeader")
    assert_selector(".SubHeader .ButtonGroup")
    assert_selector(".SubHeader .MyCustomClass")
    assert_text("Button 1")
    assert_text("Button 2")
  end

  def test_renders_a_text
    render_inline(Primer::OpenProject::SubHeader.new) do |component|
      component.with_text { "Hello world!" }
    end

    assert_selector(".SubHeader")
    assert_text("Hello world!")
  end

  def test_renders_a_filter_button
    render_inline(Primer::OpenProject::SubHeader.new) do |component|
      component.with_filter_button do |button|
        button.with_trailing_visual_counter(count: "15")
        "Filter"
      end
    end

    assert_selector(".SubHeader")
    assert_selector(".SubHeader-filterButton")
    assert_text("Filter")
  end


  def test_renders_an_icon_filter_button
    render_inline(Primer::OpenProject::SubHeader.new) do |component|
      component.with_filter_button(icon: "filter", "aria-label": "Filter")
    end

    assert_selector(".SubHeader")
    assert_selector(".SubHeader-filterButton.Button--iconOnly .octicon-filter")
  end

  def test_renders_a_custom_filter_button
    render_inline(Primer::OpenProject::SubHeader.new(bottom_pane_id: "my_cool_id")) do |component|
      component.with_filter_component do
        "<button class='MyCustomButton'>Filter</button>".html_safe
      end
    end

    assert_selector(".SubHeader")
    assert_selector(".SubHeader .MyCustomButton")
    assert_selector(".SubHeader .SubHeader-bottomPane#my_cool_id")
  end
end
