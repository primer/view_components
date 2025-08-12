# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationActionMenuTest < System::TestCase
    include Primer::ClipboardTestHelpers
    include Primer::JsTestHelpers
    include Primer::KeyboardTestHelpers

    def self.errors_to_retry
      # The logic in primer/behaviors' focus-zone code can cause weird race conditions
      # that mess with `document.activeElement`, making it slightly unreliable in the
      # test environment.
      @errors_to_retry ||= [Minitest::Assertion].tap do |error_classes|
        if Primer::DriverTestHelpers.firefox?
          error_classes << Selenium::WebDriver::Error::UnexpectedAlertOpenError
        end
      end
    end

    ###### HELPER METHODS ######

    def click_on_invoker_button(expect_to_open: true)
      attempts = 0
      max_attempts = 3

      begin
        attempts += 1

        find("action-menu button[aria-controls]").click

        if expect_to_open
          assert_selector "anchored-position:popover-open"
        end

        STDERR.puts "Succeeded" if attempts > 1
      rescue Minitest::Assertion => e
        raise e if attempts >= max_attempts
        STDERR.puts "Menu failed to open, retrying (attempt #{attempts} of #{max_attempts})"
        retry
      end
    end

    def click_on_item(idx, level: 1)
      items = find_all("action-menu ul[data-level='#{level}'] > li")
      items[idx - 1].click
    end

    def click_on_item_by_id(id)
      find("li[data-item-id='#{id}']").click
    end

    def click_on_first_item(**kwargs)
      click_on_item(1, **kwargs)
    end

    def click_on_second_item(**kwargs)
      click_on_item(2, **kwargs)
    end

    def click_on_third_item(**kwargs)
      click_on_item(3, **kwargs)
    end

    def click_on_fourth_item(**kwargs)
      click_on_item(4, **kwargs)
    end

    def retry_block(max_attempts: 3)
      attempts = 1

      begin
        yield
      rescue Minitest::Assertion => e
        raise e if attempts >= max_attempts
        attempts += 1
        retry
      end
    end

    def open_menu_via_keyboard
      retry_block do
        focus_on_invoker_button

        # open menu, "click" on first item
        activate_via_enter
        assert_selector "anchored-position:popover-open" # wait for menu to open

        # make sure the first list item is the active element
        assert_selector "[role=menuitem], [role=menuitemradio], [role=menuitemcheckbox]" do |button|
          page.evaluate_script("document.activeElement === arguments[0]", button)
        end
      end
    end

    def close_dialog
      find("[data-close-dialog-id][aria-label=Close]").click
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

    def activate_via_enter(**kwargs)
      activate_via(:enter, **kwargs)
    end

    def activate_via_space(**kwargs)
      activate_via(:space, **kwargs)
    end

    def activate_via(*keys, expect_focus_change: true)
      current_item = page.evaluate_script("document.activeElement")
      sub_menu_id = current_item["popovertarget"]

      keyboard.type(*keys)

      return if !expect_focus_change || current_item["aria-disabled"]
      return unless sub_menu_id

      # make sure the first list item in the sub-menu is the active element
      assert_selector("##{sub_menu_id} ul > li [role=menuitem], [role=menuitemradio], [role=menuitemcheckbox]") do |element|
        page.evaluate_script("document.activeElement === arguments[0]", element)
      end
    end

    def arrow_down_to(label)
      counter = 0

      loop do
        break if page.evaluate_script("document.activeElement?.querySelector('.ActionListItem-label')?.textContent?.trim()") == label
        keyboard.type(:down)
        sleep 0.1

        counter += 1

        raise Minitest::Assertion, "Too many down arrows" if counter > 10
      end
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

    def test_sub_menu_action_js_onclick
      visit_preview(:with_actions, nest_in_sub_menu: true)

      click_on_invoker_button
      click_on_first_item # expand sub-menu

      accept_alert do
        click_on_first_item(level: 2)
      end
    end

    def test_action_js_keydown
      visit_preview(:with_actions)

      open_menu_via_keyboard

      accept_alert do
        # "click" on first item
        activate_via_enter(expect_focus_change: false)
      end
    end

    def test_sub_menu_action_js_keydown
      visit_preview(:with_actions, nest_in_sub_menu: true)

      open_menu_via_keyboard
      activate_via_enter # expand sub-menu

      accept_alert do
        # "click" on first item
        activate_via_enter(expect_focus_change: false)
      end
    end

    def test_action_js_keydown_space
      visit_preview(:with_actions)

      open_menu_via_keyboard

      accept_alert do
        # "click" on first item
        activate_via_space(expect_focus_change: false)
      end
    end

    def test_sub_menu_action_js_keydown_space
      visit_preview(:with_actions, nest_in_sub_menu: true)

      open_menu_via_keyboard
      activate_via_space # expand sub-menu

      accept_alert do
        # "click" on first item
        activate_via_space(expect_focus_change: false)
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

      open_menu_via_keyboard

      assert_no_alert do
        # "click" on first item
        activate_via_enter
      end
    end

    def test_sub_menu_action_js_disabled_keydown
      visit_preview(:with_actions, disable_items: true, nest_in_sub_menu: true)

      open_menu_via_keyboard
      activate_via_enter # expand sub-menu

      assert_no_alert do
        # "click" on first item
        activate_via_enter
      end
    end

    def test_action_js_disabled_keydown_space
      visit_preview(:with_actions, disable_items: true)

      open_menu_via_keyboard

      assert_no_alert do
        # open menu, "click" on first item
        activate_via_space
      end
    end

    def test_sub_menu_action_js_disabled_keydown_space
      visit_preview(:with_actions, disable_items: true, nest_in_sub_menu: true)

      open_menu_via_keyboard
      activate_via_space # expand sub-menu

      assert_no_alert do
        # "click" on first item
        activate_via_space
      end
    end

    def test_action_keydown_on_icon_button
      visit_preview(:with_icon_button)

      open_menu_via_keyboard

      assert_selector "anchored-position"
    end

    def test_action_anchor
      visit_preview(:with_actions)

      click_on_invoker_button
      click_on_second_item

      assert_selector ".action-menu-landing-page", text: "Hello world!"
    end

    def test_sub_menu_action_anchor
      visit_preview(:with_actions, nest_in_sub_menu: true)

      click_on_invoker_button
      click_on_first_item # expand sub-menu
      click_on_second_item(level: 2)

      assert_selector ".action-menu-landing-page", text: "Hello world!"
    end

    def test_action_anchor_keydown
      visit_preview(:with_actions)

      open_menu_via_keyboard

      # arrow down to second item, "click" second item
      arrow_down_to("Navigate")
      activate_via_enter(expect_focus_change: false)

      assert_selector ".action-menu-landing-page", text: "Hello world!"
    end

    def test_sub_menu_action_anchor_keydown
      visit_preview(:with_actions, nest_in_sub_menu: true)

      open_menu_via_keyboard
      activate_via_enter # expand sub-menu

      # arrow down to second item, "click" second item
      arrow_down_to("Navigate")
      activate_via_enter(expect_focus_change: false) # expand sub-menu

      assert_selector ".action-menu-landing-page", text: "Hello world!"
    end

    def test_action_anchor_keydown_space
      visit_preview(:with_actions)

      open_menu_via_keyboard

      # arrow down to second item, "click" second item
      arrow_down_to("Navigate")
      activate_via_space(expect_focus_change: false)

      assert_selector ".action-menu-landing-page", text: "Hello world!"
    end

    def test_sub_menu_action_anchor_keydown_space
      visit_preview(:with_actions, nest_in_sub_menu: true)

      open_menu_via_keyboard
      activate_via_space # expand sub-menu

      # arrow down to second item, "click" second item
      arrow_down_to("Navigate")
      activate_via_space(expect_focus_change: false)

      assert_selector ".action-menu-landing-page", text: "Hello world!"
    end

    def test_action_anchor_disabled
      visit_preview(:with_actions, disable_items: true)

      click_on_invoker_button
      click_on_second_item

      # assert no navigation took place
      refute_selector ".action-menu-landing-page", text: "Hello world!"
    end

    def test_sub_menu_action_anchor_disabled
      visit_preview(:with_actions, disable_items: true, nest_in_sub_menu: true)

      click_on_invoker_button
      click_on_first_item # expand sub-menu
      click_on_second_item(level: 2)

      # assert no navigation took place
      refute_selector ".action-menu-landing-page", text: "Hello world!"
    end

    def test_action_anchor_disabled_keydown
      visit_preview(:with_actions, disable_items: true)

      open_menu_via_keyboard

      # arrow down to second item, "click" second item
      arrow_down_to("Navigate")
      activate_via_enter

      # assert no navigation took place
      refute_selector ".action-menu-landing-page", text: "Hello world!"
    end

    def test_sub_menu_action_anchor_disabled_keydown
      visit_preview(:with_actions, disable_items: true, nest_in_sub_menu: true)

      open_menu_via_keyboard
      activate_via_enter # expand sub-menu

      # arrow down to second item, "click" second item
      arrow_down_to("Navigate")
      activate_via_enter(expect_focus_change: false)

      # assert no navigation took place
      refute_selector ".action-menu-landing-page", text: "Hello world!"
    end

    def test_action_anchor_disabled_keydown_space
      visit_preview(:with_actions, disable_items: true)

      open_menu_via_keyboard

      # arrow down to second item, "click" second item
      arrow_down_to("Navigate")
      activate_via_space

      # assert no navigation took place
      refute_selector ".action-menu-landing-page", text: "Hello world!"
    end

    def test_sub_menu_action_anchor_disabled_keydown_space
      visit_preview(:with_actions, disable_items: true, nest_in_sub_menu: true)

      open_menu_via_keyboard
      activate_via_space # expand sub-menu

      # arrow down to second item, "click" second item
      arrow_down_to("Navigate")
      activate_via_space

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

    def test_sub_menu_action_clipboard_copy
      visit_preview(:with_actions, nest_in_sub_menu: true)

      click_on_invoker_button
      click_on_first_item # expand sub-menu

      clipboard_text = capture_clipboard do
        click_on_third_item(level: 2)
      end

      assert_equal clipboard_text, "Text to copy"
    end

    def test_action_clipboard_copy_keydown
      visit_preview(:with_actions)

      open_menu_via_keyboard

      clipboard_text = capture_clipboard do
        # arrow down to third item, "click" third item
        arrow_down_to("Copy text")
        activate_via_enter
      end

      assert_equal clipboard_text, "Text to copy"
    end

    def test_sub_menu_action_clipboard_copy_keydown
      visit_preview(:with_actions, nest_in_sub_menu: true)

      open_menu_via_keyboard
      activate_via_enter # expand sub-menu

      clipboard_text = capture_clipboard do
        # arrow down to third item, "click" third item
        arrow_down_to("Copy text")
        activate_via_enter
      end

      assert_equal clipboard_text, "Text to copy"
    end

    def test_action_clipboard_copy_keydown_space
      visit_preview(:with_actions)

      open_menu_via_keyboard

      clipboard_text = capture_clipboard do
        # arrow down to third item, "click" third item
        arrow_down_to("Copy text")
        activate_via_space
      end

      assert_equal clipboard_text, "Text to copy"
    end

    def test_sub_menu_action_clipboard_copy_keydown_space
      visit_preview(:with_actions, nest_in_sub_menu: true)

      open_menu_via_keyboard
      activate_via_space

      clipboard_text = capture_clipboard do
        # arrow down to third item, "click" third item
        arrow_down_to("Copy text")
        activate_via_space
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

    def test_sub_menu_action_clipboard_copy_disabled
      visit_preview(:with_actions, disable_items: true, nest_in_sub_menu: true)

      click_on_invoker_button
      click_on_first_item

      clipboard_text = capture_clipboard do
        click_on_third_item(level: 2)
      end

      assert_nil clipboard_text
    end

    def test_action_clipboard_copy_disabled_keydown
      visit_preview(:with_actions, disable_items: true)

      open_menu_via_keyboard

      clipboard_text = capture_clipboard do
        # arrow down to third item, "click" third item
        arrow_down_to("Copy text")
        activate_via_enter
      end

      assert_nil clipboard_text
    end

    def test_sub_menu_action_clipboard_copy_disabled_keydown
      visit_preview(:with_actions, disable_items: true, nest_in_sub_menu: true)

      open_menu_via_keyboard
      activate_via_enter

      clipboard_text = capture_clipboard do
        # arrow down to third item, "click" third item
        arrow_down_to("Copy text")
        activate_via_enter
      end

      assert_nil clipboard_text
    end

    def test_action_clipboard_copy_disabled_keydown_space
      visit_preview(:with_actions, disable_items: true)

      open_menu_via_keyboard

      clipboard_text = capture_clipboard do
        # arrow down to third item, "click" third item
        arrow_down_to("Copy text")
        activate_via_space
      end

      assert_nil clipboard_text
    end

    def test_sub_menu_action_clipboard_copy_disabled_keydown_space
      visit_preview(:with_actions, disable_items: true)

      open_menu_via_keyboard
      activate_via_space

      clipboard_text = capture_clipboard do
        # arrow down to third item, "click" third item
        arrow_down_to("Copy text")
        activate_via_space
      end

      assert_nil clipboard_text
    end

    def test_first_item_is_focused_on_invoker_keydown
      visit_preview(:with_actions)

      open_menu_via_keyboard

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

    def test_open_then_closing_dialog_restores_focus
      visit_preview(:opens_dialog)

      click_on_invoker_button
      click_on_second_item

      assert_selector "dialog[open]"

      close_dialog

      assert_equal page.evaluate_script("document.activeElement").text, "Menu"
    end

    def test_opens_dialog_on_keydown
      visit_preview(:opens_dialog)

      open_menu_via_keyboard

      # arrow down to second item, "click" second item
      arrow_down_to("Show dialog")
      activate_via_enter

      assert_selector "dialog#my-dialog"
    end

    def test_opens_dialog_on_keydown_space
      visit_preview(:opens_dialog)

      open_menu_via_keyboard

      # arrow down to second item, "click" second item
      arrow_down_to("Show dialog")
      activate_via_space

      assert_selector "dialog#my-dialog"
    end

    def test_closes_sub_menus_when_dialog_opened
      visit_preview(:opens_dialog, nest_in_sub_menu: true)

      click_on_invoker_button
      click_on_first_item

      click_on_second_item(level: 2)

      assert_selector "dialog#my-dialog"
      click_on "Cancel"

      click_on_invoker_button
      refute_selector "action-menu ul li", text: "Show dialog"
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
      keyboard.type(:escape)

      find("input[type=submit]").click

      # for some reason the JSON response is wrapped in HTML, I have no idea why
      response = JSON.parse(find("pre").text)

      # "ours" is pre-selected
      assert_equal %w[fast_forward recursive ours], response["value"]
    end

    def test_multiple_select_form_submission_in_sub_menu
      visit_preview(:multiple_select_form, route_format: :json, nest_in_sub_menu: true)

      click_on_invoker_button
      click_on_first_item
      click_on_first_item(level: 2)
      click_on_second_item(level: 2)

      # close the menus to reveal the submit button
      keyboard.type(:escape, :escape)

      find("input[type=submit]").click

      # for some reason the JSON response is wrapped in HTML, I have no idea why
      response = JSON.parse(find("pre").text)

      # "ours" is pre-selected
      assert_equal %w[fast_forward recursive ours], response["value"]
    end

    def test_multiple_select_form_uses_label_if_no_value_provided
      visit_preview(:multiple_select_form, route_format: :json)

      click_on_invoker_button
      click_on_first_item
      click_on_fourth_item

      # close the menu to reveal the submit button
      keyboard.type(:escape)

      find("input[type=submit]").click

      # for some reason the JSON response is wrapped in HTML, I have no idea why
      response = JSON.parse(find("pre").text)

      # "ours" is pre-selected
      assert_equal %w[fast_forward ours Resolve], response["value"]
    end

    def test_multiple_select_does_not_set_dynamic_label_for_preselected_item
      visit_preview(:multiple_select_form, route_format: :json)
      assert_selector("action-menu[data-ready='true'] button[aria-controls]", exact_text: "Strategy")
    end

    def test_individual_items_can_submit_post_requests_via_forms
      visit_preview(:with_actions, route_format: :json)

      click_on_invoker_button
      click_on_fourth_item

      response = JSON.parse(find("pre").text)
      assert_equal "bar", response["value"]
    end

    def test_sub_menu_individual_items_can_submit_post_requests_via_forms
      visit_preview(:with_actions, route_format: :json, nest_in_sub_menu: true)

      click_on_invoker_button
      click_on_first_item
      click_on_fourth_item(level: 2)

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

      open_menu_via_keyboard

      # "click" first item
      activate_via_enter

      # for some reason the JSON response is wrapped in HTML, I have no idea why
      response = JSON.parse(find("pre").text)
      assert_equal "group-by-repository", response["value"]
    end

    def test_single_select_items_can_submit_forms_on_keydown_space
      visit_preview(:single_select_form_items, route_format: :json)

      open_menu_via_keyboard

      # "click" first item
      activate_via_space

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

      open_menu_via_keyboard

      # wait for menu to load
      assert_selector "action-menu ul li", text: "Copy link"
      assert_equal page.evaluate_script("document.activeElement").text, "Copy link"
    end

    def test_deferred_dialog_opens
      visit_preview(:with_deferred_content)

      click_on_invoker_button
      # wait for items to load
      assert_selector "action-menu ul li"
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

      # for whatever reason, using Capybara's click method causes the menu to open
      # and then close immediately, so we do it in JS instead
      page.evaluate_script("document.querySelector('#menu-2-button').click()")

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

    def test_single_select_item_checked_via_keyboard_enter
      visit_preview(:single_select)

      open_menu_via_keyboard
      activate_via_enter

      # activating item closes menu, so checked item is hidden
      assert_selector "[aria-checked=true]", text: "Fast forward", visible: :hidden

      open_menu_via_keyboard
      arrow_down_to("Recursive")
      activate_via_enter

      assert_selector "[aria-checked=true]", text: "Recursive", visible: :hidden
    end

    def test_single_select_item_checked_via_keyboard_space
      visit_preview(:single_select)

      open_menu_via_keyboard

      # "click" on first item
      activate_via_space

      # activating item closes menu, so checked item is hidden
      assert_selector "[aria-checked=true]", text: "Fast forward", visible: :hidden

      open_menu_via_keyboard

      arrow_down_to("Recursive")
      activate_via_space

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

    def test_multi_select_items_checked_in_sub_menu
      visit_preview(:multiple_select, nest_in_sub_menu: true)

      click_on_invoker_button
      click_on_first_item
      click_on_second_item(level: 2)
      click_on_third_item(level: 2)

      # clicking item closes menu, so checked item is hidden
      assert_selector "[aria-checked=true]", text: "jonrohan"
      assert_selector "[aria-checked=true]", text: "broccolinisoup"
    end

    def test_multi_select_items_checked_via_keyboard_enter
      visit_preview(:multiple_select)

      open_menu_via_keyboard

      # select first item
      activate_via_enter(expect_focus_change: false)

      assert_selector "[aria-checked=true]", text: "langermank"

      # select second item
      arrow_down_to("jonrohan")
      activate_via_enter(expect_focus_change: false)

      assert_selector "[aria-checked=true]", text: "langermank"
      assert_selector "[aria-checked=true]", text: "jonrohan"
    end

    def test_multi_select_items_checked_via_keyboard_enter_in_sub_menu
      visit_preview(:multiple_select, nest_in_sub_menu: true)

      open_menu_via_keyboard

      # select first item
      activate_via_enter(expect_focus_change: true)

      # select first item in sub-menu
      activate_via_enter(expect_focus_change: false)

      assert_selector "[aria-checked=true]", text: "langermank"

      # select second item
      arrow_down_to("jonrohan")
      activate_via_enter(expect_focus_change: false)

      assert_selector "[aria-checked=true]", text: "langermank"
      assert_selector "[aria-checked=true]", text: "jonrohan"
    end

    def test_multi_select_items_checked_via_keyboard_space
      visit_preview(:multiple_select)

      open_menu_via_keyboard

      # select first item
      activate_via_space(expect_focus_change: false)

      assert_selector "[aria-checked=true]", text: "langermank"

      # select second item
      arrow_down_to("jonrohan")
      activate_via_space(expect_focus_change: false)

      assert_selector "[aria-checked=true]", text: "langermank"
      assert_selector "[aria-checked=true]", text: "jonrohan"
    end

    def test_multi_select_items_checked_via_keyboard_space_in_sub_menu
      visit_preview(:multiple_select, nest_in_sub_menu: true)

      open_menu_via_keyboard
      click_on_first_item

      # select first item in sub-menu
      activate_via_space(expect_focus_change: false)

      assert_selector "[aria-checked=true]", text: "langermank"

      # select second item
      arrow_down_to("jonrohan")
      activate_via_space(expect_focus_change: false)

      assert_selector "[aria-checked=true]", text: "langermank"
      assert_selector "[aria-checked=true]", text: "jonrohan"
    end

    def test_multi_select_items_can_be_unchecked
      visit_preview(:multiple_select)

      click_on_invoker_button
      click_on_second_item
      click_on_third_item

      assert_selector "[aria-checked=true]", text: "jonrohan"
      assert_selector "[aria-checked=true]", text: "broccolinisoup"

      click_on_second_item
      click_on_third_item

      refute_selector "[aria-checked=true]"
    end

    def test_multi_select_items_can_be_unchecked_in_sub_menu
      visit_preview(:multiple_select, nest_in_sub_menu: true)

      click_on_invoker_button
      click_on_first_item
      click_on_second_item(level: 2)
      click_on_third_item(level: 2)

      assert_selector "[aria-checked=true]", text: "jonrohan"
      assert_selector "[aria-checked=true]", text: "broccolinisoup"

      click_on_second_item(level: 2)
      click_on_third_item(level: 2)

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
      click_on_invoker_button(expect_to_open: false)
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

    def test_sub_menu_opens_on_click
      visit_preview(:sub_menus)

      click_on_invoker_button

      refute_selector("[role=menuitem]", text: "Paste plain text")
      click_on_third_item
      assert_selector("[role=menuitem]", text: "Paste plain text")

      refute_selector("[role=menuitem]", text: "Current clipboard")
      click_on_fourth_item(level: 2)
      assert_selector("[role=menuitem]", text: "Current clipboard")
    end

    def test_sub_menu_opens_on_right_arrow
      visit_preview(:sub_menus)

      open_menu_via_keyboard
      arrow_down_to("Paste special")

      refute_selector("[role=menuitem]", text: "Paste plain text")
      keyboard.type(:right)
      assert_selector("[role=menuitem]", text: "Paste plain text")

      arrow_down_to("Paste from")

      refute_selector("[role=menuitem]", text: "Current clipboard")
      keyboard.type(:right)
      assert_selector("[role=menuitem]", text: "Current clipboard")
    end

    def test_sub_menu_closes_on_left_arrow
      visit_preview(:sub_menus)

      open_menu_via_keyboard
      arrow_down_to("Paste special")

      keyboard.type(:right)
      assert_selector("[role=menuitem]", text: "Paste plain text")

      keyboard.type(:left)
      refute_selector("[role=menuitem]", text: "Paste plain text")
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
          window.activatedItemText = event.detail.item.innerText
          window.activatedItemChecked = event.detail.checked
        })
      JS

      click_on_invoker_button
      click_on_first_item

      assert page.evaluate_script("window.activatedItemChecked")
      assert_equal "Fast forward", page.evaluate_script("window.activatedItemText")
    end
  end
end
