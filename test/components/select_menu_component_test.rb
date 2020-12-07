# frozen_string_literal: true

require "test_helper"

class PrimerSelectMenuComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline Primer::SelectMenuComponent.new(list_role: "menu") do
      "hello world"
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("div.SelectMenu-list[role='menu']", text: /hello world/)
      end
    end
  end

  def test_nests_components_correctly
    render_inline Primer::SelectMenuComponent.new(message: "Goodness me", loading: true) do |component|
      component.slot(:header, closeable: true) { "A nice title" }
      component.slot(:filter) { "filter description" }
      component.slot(:tab, selected: true) { "Tab 1" }
      component.slot(:item, divider: true) { "item 1" }
      component.slot(:item) { "item 2" }
      component.slot(:footer) { "the end" }
      "hello world"
    end

    assert_selector("div.SelectMenu div.SelectMenu-modal header.SelectMenu-header " \
      "h3.SelectMenu-title", text: /A nice title/)
    assert_selector("div.SelectMenu div.SelectMenu-modal header.SelectMenu-header " \
      "button.SelectMenu-closeButton .octicon.octicon-x")
    assert_selector("div.SelectMenu div.SelectMenu-modal form.SelectMenu-filter " \
      "input.SelectMenu-input")
    assert_selector("div.SelectMenu div.SelectMenu-modal nav.SelectMenu-tabs " \
      "button.SelectMenu-tab[aria-selected='true']", text: /Tab 1/)
    assert_selector("div.SelectMenu div.SelectMenu-modal footer.SelectMenu-footer",
      text: /the end/)
    assert_selector("div.SelectMenu div.SelectMenu-modal div.SelectMenu-list " \
      "div.SelectMenu-message", text: /Goodness me/)
    assert_selector("div.SelectMenu div.SelectMenu-modal div.SelectMenu-list " \
      "div.SelectMenu-loading", text: /hello world/)
    assert_selector("div.SelectMenu div.SelectMenu-modal div.SelectMenu-list " \
      "button.SelectMenu-item", text: /item 1/)
    assert_selector("div.SelectMenu div.SelectMenu-modal div.SelectMenu-list " \
      "hr.SelectMenu-divider")
    assert_selector("div.SelectMenu div.SelectMenu-modal div.SelectMenu-list " \
      "button.SelectMenu-item", text: /item 2/)
  end

  def test_renders_with_loading
    render_inline Primer::SelectMenuComponent.new(loading: true) do
      "Loading"
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("div.SelectMenu-list") do
          assert_selector("div.SelectMenu-loading", text: /Loading/)
        end
      end
    end
  end

  def test_renders_with_items
    render_inline Primer::SelectMenuComponent.new do |component|
      component.slot(:item, divider: "some divider") { "item 1" }
      component.slot(:item, selected: true, icon: "star") { "item 2" }
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("div.SelectMenu-list") do
          assert_selector("button.SelectMenu-item[role='menuitem']", text: /item 1/)
          assert_selector("div.SelectMenu-divider", text: /some divider/)
          assert_selector("button.SelectMenu-item[role='menuitemcheckbox'][aria-checked='true']",
            text: /item 2/) do
              assert_selector(".SelectMenu-icon.SelectMenu-icon--check.octicon." \
                "octicon-star")
            end
        end
      end
    end
  end

  def test_renders_with_items_using_specified_tag
    render_inline Primer::SelectMenuComponent.new(list_role: "menu") do |component|
      component.slot(:item, tag: :a, href: "#some-url") { "item 1" }
      component.slot(:item, tag: :div) { "item 2" }
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("div.SelectMenu-list[role='menu']") do
          assert_selector("a.SelectMenu-item[href='#some-url'][role='menuitem']",
            text: /item 1/)
          assert_selector("div.SelectMenu-item[role='menuitem']", text: /item 2/)
        end
      end
    end
  end

  def test_renders_with_blankslate
    render_inline Primer::SelectMenuComponent.new(blankslate: true) do
      "No results"
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("div.SelectMenu-list") do
          assert_selector("div.SelectMenu-blankslate", text: /No results/)
        end
      end
    end
  end

  def test_renders_with_message
    render_inline Primer::SelectMenuComponent.new(message: "Goodness me") do
      "hello world"
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("div.SelectMenu-list", text: /hello world/) do
          assert_selector("div.SelectMenu-message", text: /Goodness me/)
        end
      end
    end
  end

  def test_renders_with_header
    render_inline Primer::SelectMenuComponent.new do |component|
      component.slot(:header) { "A nice title" }
      "hello world"
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("header.SelectMenu-header") do
          assert_selector("h3.SelectMenu-title", text: /A nice title/)
        end
        assert_selector("div.SelectMenu-list", text: /hello world/)
      end
    end
  end

  def test_renders_with_header_and_close_button
    render_inline Primer::SelectMenuComponent.new do |component|
      component.slot(:header, closeable: true) { "A nice title" }
      "hello world"
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("header.SelectMenu-header") do
          assert_selector("h3.SelectMenu-title", text: /A nice title/)
          assert_selector("button.SelectMenu-closeButton") do
            assert_selector(".octicon.octicon-x")
          end
        end
        assert_selector("div.SelectMenu-list", text: /hello world/)
      end
    end
  end

  def test_renders_with_filter
    render_inline Primer::SelectMenuComponent.new do |component|
      component.slot(:filter) { "filter description" }
      "hello world"
    end

    assert_selector("div.SelectMenu.SelectMenu--hasFilter") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("div.SelectMenu-list", text: /hello world/)
        assert_selector("form.SelectMenu-filter", text: /filter description/) do
          assert_selector("input.SelectMenu-input.form-control[placeholder='Filter']" \
            "[aria-label='Filter']")
        end
      end
    end
  end

  def test_renders_with_filter_without_contents
    render_inline Primer::SelectMenuComponent.new do |component|
      component.slot(:filter)
      "hello world"
    end

    assert_selector("div.SelectMenu.SelectMenu--hasFilter") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("div.SelectMenu-list", text: /hello world/)
        assert_selector("form.SelectMenu-filter") do
          assert_selector("input.SelectMenu-input.form-control[placeholder='Filter']" \
            "[aria-label='Filter']")
        end
      end
    end
  end

  def test_renders_with_tabs
    render_inline Primer::SelectMenuComponent.new do |component|
      component.slot(:tab, selected: true) { "Tab 1" }
      component.slot(:tab) { "Tab 2" }
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("nav.SelectMenu-tabs") do
          assert_selector("button.SelectMenu-tab[aria-selected='true']", text: /Tab 1/)
          assert_selector("button.SelectMenu-tab", text: /Tab 2/)
        end
      end
    end
  end

  def test_renders_with_tabs_and_items_in_the_right_tab
    render_inline Primer::SelectMenuComponent.new do |component|
      component.slot(:tab) { "Tab 1" }
      component.slot(:tab, selected: true) { "Tab 2" }
      component.slot(:item, tab: 1) { "hello" }
      component.slot(:item, tab: 2) { "world" }
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("nav.SelectMenu-tabs") do
          assert_selector("button.SelectMenu-tab", text: /Tab 1/)
          assert_selector("button.SelectMenu-tab[aria-selected='true']", text: /Tab 2/)
        end
        assert_selector("div.SelectMenu-list[hidden='hidden']", visible: false) do
          assert_selector("button.SelectMenu-item", text: /hello/, visible: false)
        end
        assert_selector("div.SelectMenu-list") do
          assert_selector("button.SelectMenu-item", text: /world/)
        end
      end
    end
  end

  def test_renders_with_footer
    render_inline Primer::SelectMenuComponent.new do |component|
      component.slot(:footer) { "the end" }
      "hello world"
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("div.SelectMenu-list", text: /hello world/)
        assert_selector("footer.SelectMenu-footer", text: /the end/)
      end
    end
  end

  def test_passes_along_other_arguments
    render_inline Primer::SelectMenuComponent.new(
      classes: "my-class",
      mr: 3,
      display: :block,
      tag: :"details-menu",
      modal_classes: "my-modal-class",
      list_classes: "my-list-class",
      message: "Goodness me",
      message_classes: "my-message",
      tab_wrapper_classes: "my-tab-wrapper",
    ) do |component|
      component.slot(:header,
        tag: :div,
        classes: "my-header-class",
        mt: 1,
        title_tag: :h1,
        title_classes: "my-title-class",
        closeable: true,
        close_button_classes: "my-close-button",
      ) { "A nice title" }
      component.slot(:filter,
        tag: :div,
        input_classes: "my-input",
        classes: "my-filter",
        placeholder: "Search",
        py: 1,
        "aria-label": "A nice filter field"
      ) { "filter description" }
      component.slot(:footer,
        classes: "my-footer",
        tag: :div,
        mr: 3,
      ) { "the end" }
      component.slot(:tab,
        classes: "my-tab",
        selected: true,
        mr: 1,
      ) { "Tab 1" }
      component.slot(:item,
        classes: "my-item",
        role: "menuitemcheckbox",
        mt: 1,
        icon: "check",
        icon_classes: "my-icon",
        tab: 1,
        divider: true,
        divider_classes: "my-divider",
      ) { "item 1" }
    end

    assert_selector("details-menu.SelectMenu.SelectMenu--hasFilter.my-class.mr-3.d-block[role='menu']") do
      assert_selector("div.SelectMenu-modal.my-modal-class") do
        assert_selector("div.SelectMenu-header.my-header-class.mt-1") do
          assert_selector("h1.SelectMenu-title.my-title-class", text: /A nice title/)
          assert_selector("button.SelectMenu-closeButton.my-close-button .octicon.octicon-x")
        end
        assert_selector("div.SelectMenu-list.my-list-class") do
          assert_selector("div.SelectMenu-message.my-message", text: /Goodness me/)
          assert_selector("button.SelectMenu-item.my-item.mt-1[role='menuitemcheckbox']",
            text: /item 1/) do
              assert_selector(".SelectMenu-icon.SelectMenu-icon--check.octicon." \
                "octicon-check.my-icon")
          end
          assert_selector("hr.SelectMenu-divider.my-divider")
        end
        assert_selector("div.SelectMenu-filter.my-filter.py-1", text: /filter description/) do
          assert_selector("input.SelectMenu-input.my-input[placeholder='Search']" \
            "[aria-label='A nice filter field']")
        end
        assert_selector("nav.SelectMenu-tabs.my-tab-wrapper") do
          assert_selector("button.SelectMenu-tab[aria-selected='true']", text: /Tab 1/)
        end
        assert_selector("div.SelectMenu-footer.mr-3.my-footer", text: /the end/)
      end
    end
  end

  def test_omits_top_list_border_when_specified
    render_inline Primer::SelectMenuComponent.new(list_border: :omit_top) do |component|
      "hello world"
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("div.SelectMenu-list.border-top-0", text: /hello world/)
      end
    end
  end

  def test_omits_all_borders_when_specified
    render_inline Primer::SelectMenuComponent.new(list_border: :none) do |component|
      "hello world"
    end

    assert_selector("div.SelectMenu") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("div.SelectMenu-list.SelectMenu-list--borderless",
          text: /hello world/)
      end
    end
  end

  def test_supports_right_alignment_of_menu
    render_inline Primer::SelectMenuComponent.new(align_right: true) do
      "hello world"
    end

    assert_selector("div.SelectMenu.right-0") do
      assert_selector("div.SelectMenu-modal") do
        assert_selector("div.SelectMenu-list", text: /hello world/)
      end
    end
  end

  def test_prevents_rendering_without_content_or_items
    render_inline(Primer::SelectMenuComponent.new)
    refute_selector("div")
  end
end
