# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectSubHeaderTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::SubHeader.new) do |component|
      component.with_filter_input(name: "filter", label: "Filter")
      component.with_button(scheme: :primary) do |button|
        button.with_leading_visual_icon(icon: :plus)
        "Create"
      end
    end

    assert_selector(".SubHeader")
    assert_selector(".SubHeader-filterInput")
    assert_selector(".SubHeader-button.Button--primary")
  end

  def test_renders_an_icon_button_as_action
    render_inline(Primer::OpenProject::SubHeader.new) do |component|
      component.with_button(icon: :plus, aria: { label: "Create" })
    end

    assert_selector(".SubHeader")
    assert_selector(".SubHeader-button.Button--iconOnly")
  end

  def test_renders_a_dialog_as_action
    callback = lambda do |button|
      button.with_trailing_visual_icon(icon: :history)
      "Open dialog"
    end

    render_inline(Primer::OpenProject::SubHeader.new) do |component|
      component.with_dialog_button(dialog_arguments: { id: "my_dialog", title: "A great dialog" },
                                   button_arguments: { button_block: callback }) do |d|
        d.with_body { "Hello" }
      end
    end

    assert_selector(".SubHeader")
    assert_selector(".SubHeader dialog-helper")
    assert_selector(".SubHeader-button")
  end

  def test_renders_a_menu_as_action
    render_inline(Primer::OpenProject::SubHeader.new) do |component|
      component.with_menu_button(menu_arguments: { anchor_align: :end },
                                 button_arguments: { icon: "op-kebab-vertical", aria: { label: "Menu" }}) do |menu|
        menu.with_item(label: "Subitem 1") do |item|
          item.with_leading_visual_icon(icon: :paste)
        end
        menu.with_item(label: "Subitem 2") do |item|
          item.with_leading_visual_icon(icon: :log)
        end
      end
    end

    assert_selector(".SubHeader")
    assert_selector(".SubHeader action-menu")
    assert_selector(".SubHeader-button")
  end

  def test_renders_a_button_group_as_action
    render_inline(Primer::OpenProject::SubHeader.new) do |component|
      component.with_button_group do |group|
        group.with_button(id: "button-1", tag: :button) do |button|
          button.with_tooltip(text: "Button Tooltip")
          "Button 1"
        end
        group.with_button(id: "button-2", tag: :a, href: "#") do |button|
          button.with_tooltip(text: "Button Tooltip")
          "Button 2"
        end
      end
    end

    assert_selector(".SubHeader")
    assert_selector(".SubHeader-button.ButtonGroup")
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
