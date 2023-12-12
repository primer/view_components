# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationActionMenuTest < System::TestCase
    include Primer::ClipboardTestHelpers
    include Primer::JsTestHelpers

    ###### HELPER METHODS ######

    def click_on_invoker_button
      find("action-menu button[aria-controls]").click
    end

    def click_on_item(idx)
      items = find_all("action-menu ul li")
      items[idx - 1].click
    end

    def click_on_item_by_id(id)
      find("li[data-item-id='#{id}']").click
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

    def click_on_fourth_item
      click_on_item(4)
    end

    def click_on_fifth_item
      click_on_item(5)
    end

    def focus_on_invoker_button
      page.evaluate_script(<<~JS)
        document.querySelector('action-menu button[aria-controls]').focus()
      JS
    end

    def assert_no_alert(message = nil, &block)
      accept_alert(&block)
      assert false, message || "Unexpected alert dialog"
    rescue Capybara::ModalNotFound
      # expected behavior
    end

    ########## TESTS ############

    def test_dynamic_labels
      visit_preview(:single_select_with_internal_label)
      assert_selector("action-menu button[aria-controls]", text: "Menu: Quote reply")

      click_on_invoker_button
      click_on_first_item

      assert_selector("action-menu button[aria-controls]", text: "Menu: Copy link")

      click_on_invoker_button
      click_on_first_item

      assert_selector("action-menu button[aria-controls]", text: "Menu")
    end

    def test_anchor_align
      visit_preview(:align_end)

      click_on_invoker_button

      assert_selector("anchored-position[align=end]")
    end

    def test_action_js_onclick
      visit_preview(:with_actions)

      click_on_invoker_button

      accept_alert do
        click_on_first_item
      end
    end

    def test_action_js_keydown
      visit_preview(:with_actions)

      focus_on_invoker_button

      accept_alert do
        # open menu, "click" on first item
        page.driver.browser.keyboard.type(:enter, :enter)
      end
    end

    def test_action_js_keydown_space
      visit_preview(:with_actions)

      focus_on_invoker_button

      accept_alert do
        # open menu, "click" on first item
        page.driver.browser.keyboard.type(:enter, :space)
      end
    end

    def test_action_js_disabled
      visit_preview(:with_actions, disable_items: true)

      click_on_invoker_button

      assert_no_alert do
        click_on_first_item
      end
    end

    def test_action_js_disabled_keydown
      visit_preview(:with_actions, disable_items: true)

      focus_on_invoker_button

      assert_no_alert do
        # open menu, "click" on first item
        page.driver.browser.keyboard.type(:enter, :enter)
      end
    end

    def test_action_js_disabled_keydown_space
      visit_preview(:with_actions, disable_items: true)

      focus_on_invoker_button

      assert_no_alert do
        # open menu, "click" on first item
        page.driver.browser.keyboard.type(:enter, :space)
      end
    end

    def test_action_keydown_on_icon_button
      visit_preview(:with_icon_button)

      focus_on_invoker_button

      page.driver.browser.keyboard.type(:enter)

      assert_selector "anchored-position"
    end

    def test_action_anchor
      visit_preview(:with_actions)

      click_on_invoker_button
      click_on_second_item

      assert_selector ".action-menu-landing-page", text: "Hello world!"
    end

    def test_action_anchor_keydown
      visit_preview(:with_actions)

      focus_on_invoker_button

      # open menu, arrow down to second item, "click" second item
      page.driver.browser.keyboard.type(:enter, :down, :enter)

      assert_selector ".action-menu-landing-page", text: "Hello world!"
    end

    def test_action_anchor_keydown_space
      visit_preview(:with_actions)

      focus_on_invoker_button

      # open menu, arrow down to second item, "click" second item
      page.driver.browser.keyboard.type(:enter, :down, :space)

      assert_selector ".action-menu-landing-page", text: "Hello world!"
    end

    def test_action_anchor_disabled
      visit_preview(:with_actions, disable_items: true)

      click_on_invoker_button
      click_on_second_item

      # assert no navigation took place
      refute_selector ".action-menu-landing-page", text: "Hello world!"
    end

    def test_action_anchor_disabled_keydown
      visit_preview(:with_actions, disable_items: true)

      focus_on_invoker_button

      # open menu, arrow down to second item, "click" second item
      page.driver.browser.keyboard.type(:enter, :down, :enter)

      # assert no navigation took place
      refute_selector ".action-menu-landing-page", text: "Hello world!"
    end

    def test_action_anchor_disabled_keydown_space
      visit_preview(:with_actions, disable_items: true)

      focus_on_invoker_button

      # open menu, arrow down to second item, "click" second item
      page.driver.browser.keyboard.type(:enter, :down, :space)

      # assert no navigation took place
      refute_selector ".action-menu-landing-page", text: "Hello world!"
    end

    def test_action_clipboard_copy
      visit_preview(:with_actions)

      click_on_invoker_button

      clipboard_text = capture_clipboard do
        click_on_third_item
      end

      assert_equal clipboard_text, "Text to copy"
    end

    def test_action_clipboard_copy_keydown
      visit_preview(:with_actions)

      focus_on_invoker_button

      clipboard_text = capture_clipboard do
        # open menu, arrow down to third item, "click" third item
        page.driver.browser.keyboard.type(:enter, :down, :down, :enter)
      end

      assert_equal clipboard_text, "Text to copy"
    end

    def test_action_clipboard_copy_keydown_space
      visit_preview(:with_actions)

      focus_on_invoker_button

      clipboard_text = capture_clipboard do
        # open menu, arrow down to third item, "click" third item
        page.driver.browser.keyboard.type(:enter, :down, :down, :space)
      end

      assert_equal clipboard_text, "Text to copy"
    end

    def test_action_clipboard_copy_disabled
      visit_preview(:with_actions, disable_items: true)

      click_on_invoker_button

      clipboard_text = capture_clipboard do
        click_on_third_item
      end

      assert_nil clipboard_text
    end

    def test_action_clipboard_copy_disabled_keydown
      visit_preview(:with_actions, disable_items: true)

      focus_on_invoker_button

      clipboard_text = capture_clipboard do
        # open menu, arrow down to third item, "click" third item
        page.driver.browser.keyboard.type(:enter, :down, :down, :enter)
      end

      assert_nil clipboard_text
    end

    def test_action_clipboard_copy_disabled_keydown_space
      visit_preview(:with_actions, disable_items: true)

      focus_on_invoker_button

      clipboard_text = capture_clipboard do
        # open menu, arrow down to third item, "click" third item
        page.driver.browser.keyboard.type(:enter, :down, :down, :space)
      end

      assert_nil clipboard_text
    end

    def test_first_item_is_focused_on_invoker_keydown
      visit_preview(:with_actions)

      focus_on_invoker_button

      # open menu
      page.driver.browser.keyboard.type(:enter)

      assert_equal page.evaluate_script("document.activeElement").text, "Alert"
    end

    def test_first_item_is_focused_on_invoker_click
      visit_preview(:with_actions)

      click_on_invoker_button

      assert_equal page.evaluate_script("document.activeElement").text, "Alert"
    end

    def test_opens_dialog
      visit_preview(:opens_dialog)

      click_on_invoker_button
      click_on_second_item

      assert_selector "dialog[open]"

      # opening the dialog should close the menu
      refute_selector "action-menu ul li"
    end

    def test_opens_dialog_on_keydown
      visit_preview(:opens_dialog)

      focus_on_invoker_button

      # open menu, arrow down to second item, "click" second item
      page.driver.browser.keyboard.type(:enter, :down, :enter)

      assert_selector "dialog#my-dialog"
    end

    def test_opens_dialog_on_keydown_space
      visit_preview(:opens_dialog)

      focus_on_invoker_button

      # open menu, arrow down to second item, "click" second item
      page.driver.browser.keyboard.type(:enter, :down, :space)

      assert_selector "dialog#my-dialog"
    end

    def test_single_select_form_submission
      visit_preview(:single_select_form, route_format: :json)

      click_on_invoker_button
      click_on_first_item

      find("input[type=submit]").click

      # for some reason the JSON response is wrapped in HTML, I have no idea why
      response = JSON.parse(find("pre").text)
      assert_equal "fast_forward", response["value"]
    end

    def test_single_select_form_uses_label_if_no_value_provided
      visit_preview(:single_select_form, route_format: :json)

      click_on_invoker_button
      click_on_fourth_item

      find("input[type=submit]").click

      # for some reason the JSON response is wrapped in HTML, I have no idea why
      response = JSON.parse(find("pre").text)
      assert_equal "Resolve", response["value"]
    end

    def test_multiple_select_form_submission
      visit_preview(:multiple_select_form, route_format: :json)

      click_on_invoker_button
      click_on_first_item
      click_on_second_item

      # close the menu to reveal the submit button
      page.driver.browser.keyboard.type(:escape)

      find("input[type=submit]").click

      # for some reason the JSON response is wrapped in HTML, I have no idea why
      response = JSON.parse(find("pre").text)
      assert_equal %w[fast_forward recursive], response["value"]
    end

    def test_multiple_select_form_uses_label_if_no_value_provided
      visit_preview(:multiple_select_form, route_format: :json)

      click_on_invoker_button
      click_on_first_item
      click_on_fourth_item

      # close the menu to reveal the submit button
      page.driver.browser.keyboard.type(:escape)

      find("input[type=submit]").click

      # for some reason the JSON response is wrapped in HTML, I have no idea why
      response = JSON.parse(find("pre").text)
      assert_equal %w[fast_forward Resolve], response["value"]
    end

    def test_individual_items_can_submit_post_requests_via_forms
      visit_preview(:with_actions, route_format: :json)

      click_on_invoker_button
      click_on_fourth_item

      response = JSON.parse(find("pre").text)
      assert_equal "bar", response["value"]
    end

    def test_single_select_items_can_submit_forms
      visit_preview(:single_select_form_items, route_format: :json)

      click_on_invoker_button
      click_on_first_item

      # for some reason the JSON response is wrapped in HTML, I have no idea why
      response = JSON.parse(find("pre").text)
      assert_equal "group-by-repository", response["value"]
    end

    def test_single_select_items_can_submit_forms_on_enter
      visit_preview(:single_select_form_items, route_format: :json)

      focus_on_invoker_button

      # open menu, "click" first item
      page.driver.browser.keyboard.type(:enter, :enter)

      # for some reason the JSON response is wrapped in HTML, I have no idea why
      response = JSON.parse(find("pre").text)
      assert_equal "group-by-repository", response["value"]
    end

    def test_single_select_items_can_submit_forms_on_keydown_space
      visit_preview(:single_select_form_items, route_format: :json)

      focus_on_invoker_button

      # open menu, "click" first item
      page.driver.browser.keyboard.type(:enter, :space)

      # for some reason the JSON response is wrapped in HTML, I have no idea why
      response = JSON.parse(find("pre").text)
      assert_equal "group-by-repository", response["value"]
    end

    def test_single_select_items_can_submit_forms_with_multiple_fields
      visit_preview(:single_select_form_items, route_format: :json)

      click_on_invoker_button
      click_on_first_item

      # for some reason the JSON response is wrapped in HTML, I have no idea why
      response = JSON.parse(find("pre").text)
      assert_equal "query", response.dig("other_params", "query")
    end

    def test_deferred_loading
      visit_preview(:with_deferred_content)

      click_on_invoker_button

      assert_selector "action-menu ul li", text: "Copy link"
      assert_selector "action-menu ul li", text: "Quote reply"
      assert_selector "action-menu ul li", text: "Reference in new issue"

      assert_equal page.evaluate_script("document.activeElement").text, "Copy link"
    end

    def test_deferred_loading_on_keydown
      visit_preview(:with_deferred_content)

      focus_on_invoker_button

      page.driver.browser.keyboard.type(:enter)

      # wait for menu to load
      assert_selector "action-menu ul li", text: "Copy link"
      assert_equal page.evaluate_script("document.activeElement").text, "Copy link"
    end

    def test_deferred_dialog_opens
      visit_preview(:with_deferred_content)

      click_on_invoker_button
      click_on_fourth_item

      assert_selector "dialog[open]"

      # menu should close
      refute_selector "action-menu ul li"
    end

    def test_opening_second_menu_closes_first_menu
      visit_preview(:two_menus)

      find("#menu-1-button").click

      assert_selector "action-menu ul li", text: "Eat a dot"
      refute_selector "action-menu ul li", text: "Stomp a turtle"

      find("#menu-2-button").click

      refute_selector "action-menu ul li", text: "Eat a dot"
      assert_selector "action-menu ul li", text: "Stomp a turtle"
    end

    def test_single_select_item_checked
      visit_preview(:single_select)

      click_on_invoker_button
      click_on_second_item

      # clicking item closes menu, so checked item is hidden
      assert_selector "[aria-checked=true]", text: "Recursive", visible: :hidden
    end

    def test_single_select_item_unchecks_previously_checked_item
      visit_preview(:single_select)

      click_on_invoker_button
      click_on_third_item

      # clicking item closes menu, so checked item is hidden
      refute_selector "[aria-checked=true]", text: "Recursive", visible: :hidden

      click_on_invoker_button
      click_on_second_item

      # clicking item closes menu, so checked item is hidden
      assert_selector "[aria-checked=true]", text: "Recursive", visible: :hidden
    end

    def test_single_selected_item_cannot_be_unchecked
      visit_preview(:single_select)

      click_on_invoker_button
      click_on_second_item

      click_on_invoker_button
      click_on_second_item

      # clicking item closes menu, so checked item is hidden
      assert_selector "[aria-checked=true]", text: "Recursive", visible: :hidden
    end

    def test_multi_select_items_checked
      visit_preview(:multiple_select)

      click_on_invoker_button
      click_on_second_item
      click_on_third_item

      # clicking item closes menu, so checked item is hidden
      assert_selector "[aria-checked=true]", text: "jonrohan"
      assert_selector "[aria-checked=true]", text: "broccolinisoup"
    end

    def test_multi_select_items_can_be_unchecked
      visit_preview(:multiple_select)

      click_on_invoker_button
      click_on_second_item
      click_on_third_item

      # clicking item closes menu, so checked item is hidden
      assert_selector "[aria-checked=true]", text: "jonrohan"
      assert_selector "[aria-checked=true]", text: "broccolinisoup"

      click_on_second_item
      click_on_third_item

      refute_selector "[aria-checked=true]"
    end

    def test_closes_menu_on_focus_out
      visit_preview(:default)

      # open menu
      click_on_invoker_button
      assert_selector "action-menu ul li"

      # focus on invoker element
      focus_on_invoker_button

      # list items should no longer be visible
      refute_selector "action-menu ul li"
    end

    def test_closes_menu_when_open_on_invoker_click
      visit_preview(:default)

      click_on_invoker_button
      assert_selector "action-menu ul li"

      # clicking the invoker a second time should close the menu
      click_on_invoker_button
      refute_selector "action-menu ul li"
    end

    def test_unhidden_disabled_item_cannot_be_checked
      visit_preview(:single_select)

      click_on_invoker_button
      refute_selector "li[data-item-id=hidden]"

      evaluate_multiline_script(<<~JS)
        const menu = document.querySelector('action-menu')
        menu.showItem(menu.getItemById('hidden'))
      JS

      assert_selector "li[data-item-id=hidden]"

      click_on_item_by_id("hidden")
      refute_selector "li [aria-checked=true]"
    end

    def test_hide_item_via_js_api
      visit_preview(:single_select)

      click_on_invoker_button
      assert_selector "li[data-item-id=recursive]"

      evaluate_multiline_script(<<~JS)
        const menu = document.querySelector('action-menu')
        menu.hideItem(menu.getItemById('recursive'));
      JS

      refute_selector "li[data-item-id=recursive]"
    end

    def test_show_item_via_js_api
      visit_preview(:single_select)

      click_on_invoker_button
      refute_selector "li[data-item-id=hidden]"

      evaluate_multiline_script(<<~JS)
        const menu = document.querySelector('action-menu')
        menu.showItem(menu.getItemById('hidden'))
      JS

      assert_selector "li[data-item-id=hidden]"
    end

    def test_disable_item_via_js_api
      visit_preview(:single_select)

      click_on_invoker_button
      refute_selector "li[data-item-id=resolve] [aria-disabled=true]"

      evaluate_multiline_script(<<~JS)
        const menu = document.querySelector('action-menu')
        menu.disableItem(menu.getItemById('resolve'))
      JS

      assert_selector "li[data-item-id=resolve] [aria-disabled=true]"
    end

    def test_enable_item_via_js_api
      visit_preview(:single_select)

      click_on_invoker_button
      assert_selector "li[data-item-id=disabled] [aria-disabled=true]"

      evaluate_multiline_script(<<~JS)
        const menu = document.querySelector('action-menu')
        menu.enableItem(menu.getItemById('disabled'))
      JS

      refute_selector "li[data-item-id=disabled] [aria-disabled=true]"
    end

    def test_check_item_via_js_api
      visit_preview(:single_select)

      click_on_invoker_button
      refute_selector "li[data-item-id=recursive] [aria-checked=true]"

      evaluate_multiline_script(<<~JS)
        const menu = document.querySelector('action-menu')
        menu.checkItem(menu.getItemById('recursive'))
      JS

      click_on_invoker_button
      assert_selector "li[data-item-id=recursive] [aria-checked=true]"
    end

    def test_uncheck_item_via_js_api
      # use multiple_select preview here because single-select menus do not allow unchecking checked items
      visit_preview(:multiple_select)

      click_on_invoker_button
      click_on_item_by_id("jon")

      assert_selector "li[data-item-id=jon] [aria-checked=true]"

      evaluate_multiline_script(<<~JS)
        const menu = document.querySelector('action-menu')
        menu.uncheckItem(menu.getItemById('jon'))
      JS

      refute_selector "li[data-item-id=jon] [aria-checked=true]"
    end

    def test_fires_event_on_activation
      visit_preview(:single_select)

      evaluate_multiline_script(<<~JS)
        window.activatedItemText = null
        window.activatedItemChecked = false

        document.querySelector('action-menu').addEventListener('itemActivated', (event) => {
          window.activatedItemText = event.detail.item.innerText.trim()
          window.activatedItemChecked = event.detail.checked
        })
      JS

      click_on_invoker_button
      click_on_first_item

      assert page.evaluate_script("window.activatedItemChecked")
      assert_equal "Fast forward", page.evaluate_script("window.activatedItemText")
    end

    def test_single_select_works_with_groups
      visit_preview(:single_select_with_groups)

      click_on_invoker_button
      click_on_first_item

      # clicking item closes menu, so checked item is hidden
      assert_selector "[aria-checked=true]", text: "William Adama", visible: :hidden

      click_on_invoker_button
      click_on_fifth_item  # 5th item is in a different group

      # clicking item closes menu, so checked item is hidden
      refute_selector "[aria-checked=true]", text: "William Adama", visible: :hidden
      assert_selector "[aria-checked=true]", text: "Capt. Jean-luc Picard", visible: :hidden
    end
  end
end
