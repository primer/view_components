# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectSubHeaderTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::SubHeader.new) do |component|
      component.with_filter_input(name: "filter", label: "Filter")
      component.with_action_button(leading_icon: :plus, label: "Create", scheme: :primary) do |button|
        "Create"
      end
      component.with_action_button(leading_icon: :trash, label: "Delete", scheme: :danger) { "Delete" }
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
      component.with_action_button(icon_only: true, leading_icon: :plus, label: "Create", aria: { label: "Create" })
    end

    assert_selector(".SubHeader")
    assert_selector(".SubHeader .Button--iconOnly")
  end

  def test_renders_a_button_without_label
    err = assert_raises ArgumentError do
      render_inline(Primer::OpenProject::SubHeader.new) do |component|
        component.with_action_button(icon_only: true, leading_icon: :plus, label: "", aria: { label: "Create" })
      end
    end

    assert_equal "You need to provide a valid label.", err.message
  end

  def test_renders_a_button_group_as_action
    render_inline(Primer::OpenProject::SubHeader.new) do |component|
      component.with_action_button_group do |group|
        group.with_button(icon: :note, "aria-label": "Button 1")
        group.with_button(icon: :rows, "aria-label": "Button 2")
        group.with_button(icon: "sort-desc", "aria-label": "Button 3")
      end
    end

    assert_selector(".SubHeader")
    assert_selector(".SubHeader .ButtonGroup")
    assert_selector(".octicon.octicon-note")
    assert_selector(".octicon.octicon-rows")
    assert_selector(".octicon.octicon-sort-desc")
  end

  def test_renders_a_menu_as_action
    render_inline(Primer::OpenProject::SubHeader.new) do |component|
      component.with_action_menu(leading_icon: :plus, label: "Create", button_arguments: { scheme: :primary, "aria-label": "Menu"}) do |menu|
        menu.with_item(label: "Foo") do |item|
          item.with_leading_visual_icon(icon: :paste)
        end
        menu.with_item(label: "Bar") do |item|
          item.with_leading_visual_icon(icon: :log)
        end
      end
    end

    assert_selector(".Button-leadingVisual .octicon-plus")
    assert_selector("ul[role=menu]") do
      assert_selector ".ActionListItem", text: "Foo"
      assert_selector ".ActionListItem", text: "Bar"
    end
  end

  def test_renders_a_menu_without_label
    err = assert_raises ArgumentError do
      render_inline(Primer::OpenProject::SubHeader.new) do |component|
        component.with_action_menu(leading_icon: :plus, label: "", button_arguments: { scheme: :primary, "aria-label": "Menu"}) do |menu|
          menu.with_item(label: "Foo") do |item|
            item.with_leading_visual_icon(icon: :paste)
          end
          menu.with_item(label: "Bar") do |item|
            item.with_leading_visual_icon(icon: :log)
          end
        end
      end
    end

    assert_equal "You need to provide a valid label.", err.message
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
    assert_selector(".SubHeader-leftPane") do
      assert_text("Filter")
    end
  end

  def test_renders_an_icon_button_as_filter_button
    render_inline(Primer::OpenProject::SubHeader.new) do |component|
      component.with_filter_button(icon_only: true)
    end

    assert_selector(".SubHeader")
    assert_selector(".SubHeader-leftPane") do
      assert_selector(".SubHeader .Button--iconOnly")
      assert_selector(".octicon.octicon-filter")
    end
  end

  def test_renders_an_icon_filter_button
    render_inline(Primer::OpenProject::SubHeader.new) do |component|
      component.with_filter_button(icon: "filter", "aria-label": "Filter")
    end

    assert_selector(".SubHeader")
    assert_selector(".SubHeader-leftPane .Button--iconOnly .octicon-filter")
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

  def test_renders_a_filter_input_label
    err = assert_raises ArgumentError do
      render_inline(Primer::OpenProject::SubHeader.new) do |component|
        component.with_filter_input(
          name: "filter",
          label: "",
          show_clear_button: true,
          value: "value is set"
        )
      end
    end

    assert_equal "You need to provide a valid label.", err.message
  end

  def test_renders_a_segmented_control
    render_inline(Primer::OpenProject::SubHeader.new) do |component|
      component.with_segmented_control("aria-label": "Segmented control") do |control|
        control.with_item(tag: :a, href: "#", label: "Preview", icon: :eye, selected: true)
        control.with_item(tag: :a, href: "#", label: "Raw", icon: :"file-code")
      end
    end

    assert_selector(".SubHeader")
    assert_selector(".SubHeader .SegmentedControl")
    assert_text("Preview")
    assert_text("Raw")
  end

  def test_renders_empty_left_pane
    render_inline(Primer::OpenProject::SubHeader.new) do |component|
      component.with_action_button_group do |group|
        group.with_button(icon: :note, "aria-label": "Button 1")
        group.with_button(icon: :rows, "aria-label": "Button 2")
      end
    end

    assert_selector(".SubHeader.SubHeader--emptyLeftPane")
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
