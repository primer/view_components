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
      component.with_action_button(scheme: :danger) { "Delete" }
    end

    assert_selector(".SubHeader")
    assert_selector(".SubHeader-filterInput")
    assert_selector(".SubHeader .Button--primary")
    assert_selector(".SubHeader .Button--danger")
    # Assert the correct order
    assert_selector(".SubHeader-rightPane .Button--primary+.Button--danger")
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
    render_inline(Primer::OpenProject::SubHeader.new) do |component|
      component.with_filter_component do
        "<button class='MyCustomButton'>Filter</button>".html_safe
      end
      component.with_bottom_pane_component do
        "<div class='ABottomPane'>Whatever block you need</div>".html_safe
      end
    end

    assert_selector(".SubHeader")
    assert_selector(".SubHeader .MyCustomButton")
    assert_selector(".SubHeader .SubHeader-bottomPane .ABottomPane")
  end

  def test_renders_a_clear_button_when_show_clear_button_is_set
    render_inline(Primer::OpenProject::SubHeader.new) do |component|
      component.with_filter_input(
        name: "filter",
        label: "Filter",
        show_clear_button: true,
        value: "value is set"
      )
    end

    assert_selector(".SubHeader")
    assert_selector(
      ".SubHeader-filterInput"\
      "[data-action=\" input:sub-header#toggleFilterInputClearButton focus:sub-header#toggleFilterInputClearButton\"]"
    )
    assert_selector(".FormControl-input-trailingAction[data-action=\"click:primer-text-field#clearContents\"]")
  end

  def test_does_not_render_input_events_when_show_clear_button_is_not_set
    render_inline(Primer::OpenProject::SubHeader.new) do |component|
      component.with_filter_input(
        name: "filter",
        label: "Filter",
        show_clear_button: false,
        value: "value is set"
      )
    end

    assert_selector(".SubHeader")
    assert_selector(".SubHeader-filterInput")
    assert_no_selector(
      ".SubHeader-filterInput"\
      "[data-action=\" input:sub-header#toggleFilterInputClearButton focus:sub-header#toggleFilterInputClearButton\"]"
    )
    assert_no_selector(".FormControl-input-trailingAction[data-action=\"click:primer-text-field#clearContents\"]")
  end
end
