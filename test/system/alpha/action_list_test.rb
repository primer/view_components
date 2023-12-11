# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationActionListTest < System::TestCase
    include Primer::JsTestHelpers

    ###### HELPER METHODS ######

    def click_on_item_by_id(id)
      find("li[data-item-id='#{id}']").click
    end

    def click_on_item(idx)
      items = find_all("action-list ul li")
      items[idx - 1].click
    end

    def click_on_first_item
      click_on_item(1)
    end

    def click_on_second_item
      click_on_item(2)
    end

    def click_on_third_item
      click_on_item(3)
    end

    ########## TESTS ############

    def test_single_select_item_checked
      visit_preview(:single_select)
      click_on_second_item
      assert_selector "[aria-checked=true]", text: "Item two"
    end

    def test_single_select_item_unchecks_previously_checked_item
      visit_preview(:single_select)

      click_on_third_item
      assert_selector "[aria-checked=true]", text: "Item three"

      click_on_second_item
      refute_selector "[aria-checked=true]", text: "Item three"
      assert_selector "[aria-checked=true]", text: "Item two"
    end

    def test_single_selected_item_cannot_be_unchecked
      visit_preview(:single_select)

      click_on_second_item
      click_on_second_item
      assert_selector "[aria-checked=true]", text: "Item two"
    end

    def test_multi_select_items_checked
      visit_preview(:multiple_select)

      click_on_second_item
      click_on_third_item

      assert_selector "[aria-checked=true]", text: "Item two"
      assert_selector "[aria-checked=true]", text: "Item three"
    end

    def test_multi_select_items_can_be_unchecked
      visit_preview(:multiple_select)

      click_on_second_item
      click_on_third_item

      assert_selector "[aria-checked=true]", text: "Item two"
      assert_selector "[aria-checked=true]", text: "Item three"

      click_on_second_item
      click_on_third_item

      refute_selector "[aria-checked=true]"
    end

    def test_hide_item_via_js_api
      visit_preview(:single_select)

      assert_selector "li[data-item-id=item_two]"

      evaluate_multiline_script(<<~JS)
        const menu = document.querySelector('action-list')
        menu.hideItem(menu.getItemById('item_two'));
      JS

      refute_selector "li[data-item-id=item_two]"
    end

    def test_show_item_via_js_api
      visit_preview(:single_select)

      refute_selector "li[data-item-id=hidden]"

      evaluate_multiline_script(<<~JS)
        const menu = document.querySelector('action-list')
        menu.showItem(menu.getItemById('hidden'))
      JS

      assert_selector "li[data-item-id=hidden]"
    end

    def test_disable_item_via_js_api
      visit_preview(:single_select)

      refute_selector "li[data-item-id=resolve] [aria-disabled=true]"

      evaluate_multiline_script(<<~JS)
        const menu = document.querySelector('action-list')
        menu.disableItem(menu.getItemById('item_two'))
      JS

      assert_selector "li[data-item-id=item_two] [aria-disabled=true]"
    end

    def test_enable_item_via_js_api
      visit_preview(:single_select)

      assert_selector "li[data-item-id=disabled] [aria-disabled=true]"

      evaluate_multiline_script(<<~JS)
        const menu = document.querySelector('action-list')
        menu.enableItem(menu.getItemById('disabled'))
      JS

      refute_selector "li[data-item-id=disabled] [aria-disabled=true]"
    end

    def test_check_item_via_js_api
      visit_preview(:single_select)

      refute_selector "li[data-item-id=item_two] [aria-checked=true]"

      evaluate_multiline_script(<<~JS)
        const menu = document.querySelector('action-list')
        menu.checkItem(menu.getItemById('item_two'))
      JS

      assert_selector "li[data-item-id=item_two] [aria-checked=true]"
    end

    def test_uncheck_item_via_js_api
      # use multiple_select preview here because single-select menus do not allow unchecking checked items
      visit_preview(:multiple_select)

      click_on_item_by_id("item_two")
      assert_selector "li[data-item-id=item_two] [aria-checked=true]"

      evaluate_multiline_script(<<~JS)
        const menu = document.querySelector('action-list')
        menu.uncheckItem(menu.getItemById('item_two'))
      JS

      refute_selector "li[data-item-id=item_two] [aria-checked=true]"
    end

    def test_fires_event_on_activation
      visit_preview(:single_select)

      evaluate_multiline_script(<<~JS)
        window.activatedItemText = null
        window.activatedItemChecked = false

        document.querySelector('action-list').addEventListener('itemActivated', (event) => {
          window.activatedItemText = event.detail.item.innerText.trim()
          window.activatedItemChecked = event.detail.checked
        })
      JS

      click_on_first_item

      assert page.evaluate_script("window.activatedItemChecked")
      assert_equal "Item one", page.evaluate_script("window.activatedItemText")
    end
  end
end
