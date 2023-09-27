# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationActionMenuTest < System::TestCase
    ###### HELPER METHODS ######

    def click_on_invoker_button
      find("action-menu button[aria-controls]").click
    end

    def click_on_item(idx)
      find("action-menu ul li:nth-child(#{idx})").click
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

    def focus_on_invoker_button
      page.evaluate_script(<<~JS)
        document.querySelector('action-menu button[aria-controls]').focus()
      JS
    end

    def stub_clipboard!
      page.evaluate_script(<<~JS)
        (() => {
          navigator.clipboard.writeText = async (text) => {
            this.text = text;
            return Promise.resolve(null);
          };

          navigator.clipboard.readText = async () => {
            return Promise.resolve(this.text);
          };
        })()
      JS

      @clipboard_stubbed = true
    end

    def read_clipboard
      page.evaluate_async_script(<<~JS)
        const [done] = arguments;
        navigator.clipboard.readText().then(done).catch((e) => done(e));
      JS
    end

    def assert_no_alert(message = nil, &block)
      begin
        accept_alert(&block)
        assert false, message || "Unexpected alert dialog"
      rescue Capybara::ModalNotFound
        # expected behavior
      end
    end

    def capture_clipboard(&block)
      stub_clipboard! unless clipboard_stubbed?
      block.call
      read_clipboard
    end

    ########## TESTS ############

    def setup
      @clipboard_stubbed = false
    end

    def clipboard_stubbed?
      @clipboard_stubbed
    end

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

      assert_selector "modal-dialog#my-dialog"

      # opening the dialog should close the menu
      refute_selector "action-menu ul li"
    end

    def test_opens_dialog_on_keydown
      visit_preview(:opens_dialog)

      focus_on_invoker_button

      # open menu, arrow down to second item, "click" second item
      page.driver.browser.keyboard.type(:enter, :down, :enter)

      assert_selector "modal-dialog#my-dialog"
    end

    def test_opens_dialog_on_keydown_space
      visit_preview(:opens_dialog)

      focus_on_invoker_button

      # open menu, arrow down to second item, "click" second item
      page.driver.browser.keyboard.type(:enter, :down, :space)

      assert_selector "modal-dialog#my-dialog"
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
      visit_preview(:with_actions)

      click_on_invoker_button
      click_on_fourth_item

      assert_equal page.text, 'You selected "bar"'
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

      assert_selector "modal-dialog[open]"
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
  end
end
