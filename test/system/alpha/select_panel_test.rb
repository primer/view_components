
# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationSelectPanelTest < System::TestCase
    include Primer::KeyboardTestHelpers
    include Primer::JsTestHelpers

    ###### HELPER METHODS ######

    def click_on_invoker_button(expect_to_open: true)
      attempts = 0
      max_attempts = 3

      begin
        attempts += 1

        find("select-panel button[aria-controls]").click

        if expect_to_open
          assert_selector "dialog[open]"
        end

        STDERR.puts "Succeeded" if attempts > 1
      rescue Minitest::Assertion => e
        raise e if attempts >= max_attempts
        STDERR.puts "Panel failed to open, retrying (attempt #{attempts} of #{max_attempts})"
        retry
      end
    end

    def focus_on_invoker_button
      page.evaluate_script(<<~JS)
        document.querySelector('select-panel button[aria-controls]').focus()
      JS
    end

    def click_on_x_button
      find("[data-close-dialog-id]").click
    end

    def click_on_item(idx)
      items = find_all("select-panel ul li")
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

    def click_on_item_by_id(id)
      find("li[data-item-id='#{id}']").click
    end

    def wait_for_items_to_load
      # manually set data-ready=false so this method can be used multiple times in the same test
      page.evaluate_script(<<~JS)
        document.querySelector('select-panel').setAttribute('data-ready', 'false')
      JS

      yield

      assert_selector "select-panel[data-ready=true]", wait: 5
    end

    def wait_for_dialog_ready
      begin
        assert_selector "dialog[data-ready]"
      rescue Minitest::Assertion
        # if we've waited this long, assume everything is fine
      end
    end

    def filter_results(query:)
      find("input").fill_in(with: query)
    end

    def assert_announces(message:)
      yield

      assert_selector "[data-target='select-panel.ariaLiveContainer']" do |element|
        assert_includes element.text, message
      end
    end

    def active_element
      page.evaluate_script("document.activeElement")
    end

    ########## TESTS ############

    def test_invoker_opens_panel
      visit_preview(:default)

      refute_selector "select-panel dialog[open]"
      click_on_invoker_button
      assert_selector "select-panel dialog[open]"
    end

    def test_escape_closes_panel
      visit_preview(:default)

      click_on_invoker_button
      assert_selector "select-panel dialog[open]"

      keyboard.type(:escape)

      refute_selector "select-panel dialog[open]"
    end

    def test_x_closes_panel
      visit_preview(:default)

      click_on_invoker_button
      assert_selector "select-panel dialog[open]"

      click_on_x_button

      refute_selector "select-panel dialog[open]"
    end

    def test_invoker_opens_panel_on_enter
      visit_preview(:default)

      refute_selector "select-panel dialog[open]"

      focus_on_invoker_button
      keyboard.type(:enter)

      assert_selector "select-panel dialog[open]"
    end

    def test_invoker_opens_panel_on_space
      visit_preview(:default)

      refute_selector "select-panel dialog[open]"

      focus_on_invoker_button
      keyboard.type(:space)

      assert_selector "select-panel dialog[open]"
    end

    def test_focuses_filter_input_on_open
      visit_preview(:default)

      click_on_invoker_button

      assert_equal active_element.tag_name, "input"
      assert_includes active_element["class"], "FormControl-input"
    end

    def test_focuses_first_checked_item_when_tabbing_to_list
      visit_preview(:single_select)

      click_on_invoker_button
      click_on_second_item
      click_on_invoker_button

      # demonstrate that item 1 is first in the list
      assert_selector "select-panel ul li:first-child", text: "Item 1"

      keyboard.type(:tab)

      assert_includes active_element.text, "Item 2"
    end

    def test_remembers_selections_on_filter
      visit_preview(:remote_fetch)

      wait_for_items_to_load do
        click_on_invoker_button
      end

      # Phaser should already be selected
      assert_selector "[aria-checked=true]", text: "Phaser"

      click_on "Photon torpedo"

      assert_selector "[aria-checked=true]", text: "Phaser"
      assert_selector "[aria-checked=true]", text: "Photon torpedo"

      wait_for_items_to_load do
        filter_results(query: "ph")
      end

      assert_selector "[aria-checked=true]", count: 2
    end

    def test_pressing_down_arrow_in_filter_input_focuses_first_item
      visit_preview(:default)

      click_on_invoker_button

      assert_equal active_element.tag_name, "input"

      keyboard.type(:down)

      assert_equal active_element.tag_name, "button"
      assert_equal active_element.text, "Item 1"
    end

    def test_pressing_home_in_filter_input_focuses_first_item
      visit_preview(:default)

      click_on_invoker_button

      assert_equal active_element.tag_name, "input"

      keyboard.type(:home)

      assert_equal active_element.tag_name, "button"
      assert_equal active_element.text, "Item 1"
    end

    def test_pressing_end_in_filter_input_focuses_first_item
      visit_preview(:default)

      click_on_invoker_button

      assert_equal active_element.tag_name, "input"

      keyboard.type(:end)

      assert_equal active_element.tag_name, "button"
      assert_equal active_element.text, "Item 4"
    end

    def test_pressing_enter_in_filter_input_checks_first_item
      visit_preview(:default)

      click_on_invoker_button

      # nothing is checked initially
      refute_selector "[aria-checked=true]"
      refute_selector "[aria-selected=true]"

      assert_equal active_element.tag_name, "input"

      keyboard.type(:enter)

      # pressing enter in the filter input does not close the panel
      assert_selector "[aria-checked=true]", text: "Item 1"
      refute_selector "[aria-selected]"
    end

    def test_pressing_enter_in_filter_input_navigates_if_first_item_is_link
      visit_preview(:list_of_links)

      click_on_invoker_button

      assert_equal active_element.tag_name, "input"

      keyboard.type(:enter)

      assert_current_path "https://github.com"
    end

    def test_selecting_without_data_values
      visit_preview(:no_values)

      click_on_invoker_button
      click_on_first_item
      assert_selector "[aria-selected=true]", text: "Item 1", count: 1, visible: :hidden

      click_on_invoker_button
      click_on_second_item
      assert_selector "[aria-selected=true]", text: "Item 2", count: 1, visible: :hidden
    end

    ########## SINGLE SELECT TESTS ############

    def test_single_select_item_checked
      visit_preview(:single_select)

      click_on_invoker_button
      click_on_second_item

      # clicking item closes panel, so checked item is hidden
      assert_selector "[aria-selected=true]", text: "Item 2", visible: :hidden
      refute_selector "[aria-checked]", visible: :hidden
    end

    def test_single_select_remote_fetch_item_checked
      visit_preview(:playground)

      click_on_invoker_button
      click_on_first_item

      # clicking item closes panel, so checked item is hidden
      assert_selector "[aria-selected=true]", text: "Photon torpedo", visible: :hidden
      refute_selector "[aria-checked]", visible: :hidden
    end

    def test_single_select_item_checked_via_keyboard_enter
      visit_preview(:single_select)

      focus_on_invoker_button

      # open panel
      keyboard.type(:enter)

      # wait for the panel to adjust focus (to work around a Safari issue)
      wait_for_dialog_ready

      # "click" on first item
      keyboard.type(:tab, :enter)

      # activating item closes panel, so checked item is hidden
      assert_selector "[aria-selected=true]", text: "Item 1", visible: :hidden

      focus_on_invoker_button

      # open panel
      keyboard.type(:enter)

      # wait for the panel to adjust focus (to work around a Safari issue)
      wait_for_dialog_ready

      # "click" on second item
      keyboard.type(:tab, :down, :enter)

      assert_selector "[aria-selected=true]", text: "Item 2", visible: :hidden
      refute_selector "[aria-checked]", visible: :hidden
    end

    def test_single_select_item_checked_via_keyboard_space
      visit_preview(:single_select)

      focus_on_invoker_button

      # open panel
      keyboard.type(:enter)

      # wait for the panel to adjust focus (to work around a Safari issue)
      wait_for_dialog_ready

      # "click" on first item
      keyboard.type(:tab, :space)

      # activating item closes panel, so checked item is hidden
      assert_selector "[aria-selected=true]", text: "Item 1", visible: :hidden

      focus_on_invoker_button

      # open panel
      keyboard.type(:enter)

      # wait for the panel to adjust focus (to work around a Safari issue)
      wait_for_dialog_ready

      # "click" second item
      keyboard.type(:tab, :down, :space)

      assert_selector "[aria-selected=true]", text: "Item 2", visible: :hidden
      refute_selector "[aria-checked]", visible: :hidden
    end

    def test_single_select_item_unchecks_previously_checked_item
      visit_preview(:single_select)

      click_on_invoker_button
      click_on_third_item

      # clicking item closes panel, so checked item is hidden
      assert_selector "[aria-selected=true]", text: "Item 3", visible: :hidden
      refute_selector "[aria-checked]", visible: :hidden

      click_on_invoker_button
      click_on_second_item

      # clicking item closes panel, so checked item is hidden
      assert_selector "[aria-selected=true]", text: "Item 2", visible: :hidden
      refute_selector "[aria-checked]", visible: :hidden
    end

    def test_single_select_item_unchecks_previously_checked_item_after_filtering
      visit_preview(:playground)

      click_on_invoker_button

      # clicking item closes panel, so checked item is hidden
      assert_selector "[aria-selected=true]", text: "Phaser"
      refute_selector "[aria-checked]"

      wait_for_items_to_load do
        filter_results(query: "ph")
      end

      click_on "Photon torpedo"

      click_on_invoker_button
      # clicking item closes panel, so checked item is hidden
      assert_selector "[aria-selected=false]", text: "Phaser"
      assert_selector "[aria-selected=true]", text: "Photon torpedo"
      refute_selector "[aria-checked]"
    end

    def test_single_selected_item_cannot_be_unchecked
      visit_preview(:single_select)

      click_on_invoker_button
      click_on_second_item

      click_on_invoker_button
      click_on_second_item

      # clicking item closes panel, so checked item is hidden
      assert_selector "[aria-selected=true]", text: "Item 2", visible: :hidden
      refute_selector "[aria-checked]", visible: :hidden
    end

    def test_single_select_disabled_item_cannot_be_checked
      visit_preview(:single_select)

      click_on_invoker_button

      click_on_item_by_id("disabled")

      refute_selector "[aria-selected=true]"
    end

    def test_single_select_does_not_allow_server_to_check_items_on_filter_if_selections_already_made
      # playground is single-select
      visit_preview(:playground)

      wait_for_items_to_load do
        click_on_invoker_button
      end

      # Phaser should already be selected
      assert_selector "[aria-selected=true]", text: "Phaser"

      click_on "Photon torpedo"
      click_on_invoker_button

      wait_for_items_to_load do
        filter_results(query: "ph")
      end

      # server will render this item checked, but since the user has already made selections,
      # the server-rendered selections should be ignored
      refute_selector "[aria-selected=true]", text: "Phaser"
      assert_selector "[aria-selected=true]", text: "Photon torpedo"
    end

    def test_single_select_remembers_only_one_checked_item_and_ignores_checked_items_from_server
      # playground is single-select
      visit_preview(:playground)

      wait_for_items_to_load do
        click_on_invoker_button
      end

      # Phaser should already be selected
      assert_selector "[aria-selected=true]", text: "Phaser"

      wait_for_items_to_load do
        filter_results(query: "light")
      end

      click_on "Lightsaber"

      click_on_invoker_button

      wait_for_items_to_load do
        filter_results(query: "")
      end

      refute_selector "[aria-selected=true]", text: "Phaser"
      assert_selector "[aria-selected=true]", text: "Lightsaber"
    end

    def test_single_select_handles_all_options_unselected_by_default
      # playground is single-select
      visit_preview(:playground, selected_items: "")

      wait_for_items_to_load do
        click_on_invoker_button
      end

      # Phaser should note already be selected
      refute_selector "[aria-selected=true]", text: "Phaser"

      wait_for_items_to_load do
        filter_results(query: "light")
      end

      click_on "Lightsaber"

      click_on_invoker_button

      wait_for_items_to_load do
        filter_results(query: "")
      end

      refute_selector "[aria-selected=true]", text: "Phaser"
      assert_selector "[aria-selected=true]", text: "Lightsaber"


      wait_for_items_to_load do
        filter_results(query: "ph")
      end

      click_on "Phaser"

      click_on_invoker_button

      wait_for_items_to_load do
        filter_results(query: "")
      end

      assert_selector "[aria-selected=true]", text: "Phaser"
      refute_selector "[aria-selected=true]", text: "Lightsaber"
    end

    ########## MULTISELECT TESTS ############

    def test_multi_select_items_checked
      visit_preview(:multiselect)

      click_on_invoker_button
      click_on_second_item
      click_on_third_item

      # clicking item closes panel, so checked item is hidden
      assert_selector "[aria-checked=true]", text: "Item 2"
      assert_selector "[aria-checked=true]", text: "Item 3"
      refute_selector "[aria-selected]", visible: :hidden
    end

    def test_multi_select_items_checked_via_keyboard_enter
      visit_preview(:multiselect)

      focus_on_invoker_button

      # open panel
      keyboard.type(:enter)

      # wait for the panel to adjust focus (to work around a Safari issue)
      wait_for_dialog_ready

      # select first item
      keyboard.type(:tab, :enter)

      assert_selector "[aria-checked=true]", count: 1
      assert_selector "[aria-checked=true]", text: "Item 1"

      # select second item
      keyboard.type(:down, :enter)

      assert_selector "[aria-checked=true]", count: 2
      assert_selector "[aria-checked=true]", text: "Item 1"
      assert_selector "[aria-checked=true]", text: "Item 2"

      refute_selector "[aria-selected]", visible: :hidden
    end

    def test_multi_select_items_checked_via_keyboard_space
      visit_preview(:multiselect)

      focus_on_invoker_button

      # open panel
      keyboard.type(:enter)

      # wait for the panel to adjust focus (to work around a Safari issue)
      wait_for_dialog_ready

      # select first item
      keyboard.type(:tab, :space)

      assert_selector "[aria-checked=true]", count: 1
      assert_selector "[aria-checked=true]", text: "Item 1"

      # select second item
      keyboard.type(:down, :space)

      assert_selector "[aria-checked=true]", count: 2
      assert_selector "[aria-checked=true]", text: "Item 1"
      assert_selector "[aria-checked=true]", text: "Item 2"

      refute_selector "[aria-selected]", visible: :hidden
    end

    def test_multi_select_items_can_be_unchecked
      visit_preview(:multiselect)

      click_on_invoker_button
      click_on_second_item
      click_on_third_item

      assert_selector "[aria-checked=true]", text: "Item 2"
      assert_selector "[aria-checked=true]", text: "Item 3"

      click_on_second_item
      click_on_third_item

      refute_selector "[aria-checked=true]"
    end

    def test_multi_select_disabled_item_cannot_be_checked
      visit_preview(:multiselect)

      click_on_invoker_button

      click_on_item_by_id("disabled")

      refute_selector "[aria-checked=true]"
    end

    def test_multi_select_does_not_allow_server_to_check_items_on_filter_if_selections_already_made
      # remote_fetch is multi-select
      visit_preview(:remote_fetch)

      wait_for_items_to_load do
        click_on_invoker_button
      end

      # Phaser should already be selected
      assert_selector "[aria-checked=true]", text: "Phaser"

      # check torpedo, uncheck phaser
      click_on "Photon torpedo"
      click_on "Phaser"

      wait_for_items_to_load do
        filter_results(query: "ph")
      end

      # server will render phaser checked, but since the user has already made selections,
      # the server-rendered selections should be ignored
      refute_selector "[aria-checked=true]", text: "Phaser"
      assert_selector "[aria-checked=true]", text: "Photon torpedo"
    end

    def test_multi_select_allows_server_to_check_multiple_items
      # "ph" should match two items, i.e. the server should respond with two checked items
      visit_preview(:remote_fetch, selected_items: "ph")

      wait_for_items_to_load do
        click_on_invoker_button
      end

      assert_selector "[aria-checked=true]", text: "Phaser"
      assert_selector "[aria-checked=true]", text: "Photon torpedo"
    end

    ########## JAVASCRIPT API TESTS ############

    def test_disable_item_via_js_api
      visit_preview(:single_select)

      click_on_invoker_button
      refute_selector "li[data-item-id=item1] [aria-disabled=true]"

      evaluate_multiline_script(<<~JS)
        const panel = document.querySelector('select-panel')
        panel.disableItem(panel.getItemById('item1'))
      JS

      assert_selector "li[data-item-id=item1] [aria-disabled=true]"
    end

    def test_enable_item_via_js_api
      visit_preview(:single_select)

      click_on_invoker_button
      assert_selector "li[data-item-id=disabled] [aria-disabled=true]"

      evaluate_multiline_script(<<~JS)
        const panel = document.querySelector('select-panel')
        panel.enableItem(panel.getItemById('disabled'))
      JS

      refute_selector "li[data-item-id=disabled] [aria-disabled=true]"
    end

    def test_check_item_via_js_api
      visit_preview(:single_select)

      click_on_invoker_button
      refute_selector "li[data-item-id=item1] [aria-selected=true]"

      evaluate_multiline_script(<<~JS)
        const panel = document.querySelector('select-panel')
        panel.checkItem(panel.getItemById('item1'))
      JS

      click_on_invoker_button
      assert_selector "li[data-item-id=item1] [aria-selected=true]"
    end

    def test_uncheck_item_via_js_api
      # use multiselect preview here because single-select panels do not allow unchecking checked items
      visit_preview(:multiselect)

      click_on_invoker_button
      click_on_item_by_id("item1")

      assert_selector "li[data-item-id=item1] [aria-checked=true]"

      evaluate_multiline_script(<<~JS)
        const panel = document.querySelector('select-panel')
        panel.uncheckItem(panel.getItemById('item1'))
      JS

      refute_selector "li[data-item-id=item1] [aria-selected=true]"
    end

    def test_fires_event_before_activation
      visit_preview(:single_select)

      evaluate_multiline_script(<<~JS)
        window.activatedItemText = null
        window.activatedItemChecked = false
        window.activatedItemValue = null

        document.querySelector('select-panel').addEventListener('beforeItemActivated', (event) => {
          window.activatedItemText = event.detail.item.innerText
          window.activatedItemChecked = event.detail.checked
          window.activatedItemValue = event.detail.value
        })
      JS

      click_on_invoker_button
      click_on_first_item

      assert page.evaluate_script("window.activatedItemChecked")
      assert_equal "Item 1", page.evaluate_script("window.activatedItemText")
      assert_equal "1", page.evaluate_script("window.activatedItemValue")
    end

    def test_fires_event_on_activation
      visit_preview(:single_select)

      evaluate_multiline_script(<<~JS)
        window.activatedItemText = null
        window.activatedItemChecked = false
        window.activatedItemValue = null

        document.querySelector('select-panel').addEventListener('itemActivated', (event) => {
          window.activatedItemText = event.detail.item.innerText
          window.activatedItemChecked = event.detail.checked
          window.activatedItemValue = event.detail.value
        })
      JS

      click_on_invoker_button
      click_on_first_item

      assert page.evaluate_script("window.activatedItemChecked")
      assert_equal "Item 1", page.evaluate_script("window.activatedItemText")
      assert_equal "1", page.evaluate_script("window.activatedItemValue")
    end

    def test_cancelling_before_item_activated_event_prevents_selection
      visit_preview(:single_select)

      evaluate_multiline_script(<<~JS)
        document.querySelector('select-panel').addEventListener('beforeItemActivated', (event) => {
          event.preventDefault()
        })
      JS

      click_on_invoker_button
      click_on_first_item

      refute_selector "[aria-selected=true]", visible: :all
    end

    def test_open_event
      visit_preview(:single_select)

      evaluate_multiline_script(<<~JS)
        window.panelOpened = false

        document.querySelector('select-panel').addEventListener('dialog:open', (_event) => {
          window.panelOpened = true
        })
      JS

      refute page.evaluate_script("window.panelOpened")

      click_on_invoker_button

      assert page.evaluate_script("window.panelOpened")
    end

    def test_closed_event
      visit_preview(:single_select)

      evaluate_multiline_script(<<~JS)
        window.panelClosed = false

        document.querySelector('select-panel').addEventListener('panelClosed', (_event) => {
          window.panelClosed = true
        })
      JS

      refute page.evaluate_script("window.panelClosed")

      click_on_invoker_button
      keyboard.type(:escape)

      assert page.evaluate_script("window.panelClosed")
    end

    ########### LOCAL FETCH TESTS ############

    def test_local_fetch_no_results
      visit_preview(:local_fetch_no_results)

      click_on_invoker_button

      refute_selector "select-panel ul li"
      assert_selector "select-panel", text: "No results"
    end

    ########## EVENTUALLY LOCAL TESTS ############

    def test_ev_loc_items_load
      visit_preview(:eventually_local_fetch)

      wait_for_items_to_load do
        click_on_invoker_button
      end

      assert_selector "select-panel ul li", text: "Photon torpedo"
    end

    def test_ev_loc_no_results
      visit_preview(:eventually_local_fetch_no_results)

      wait_for_items_to_load do
        click_on_invoker_button
      end

      refute_selector "select-panel ul li"
      assert_selector "select-panel", text: "No results"
    end

    def test_ev_loc_no_results_after_filter
      visit_preview(:eventually_local_fetch)

      wait_for_items_to_load do
        click_on_invoker_button
      end

      assert_selector "select-panel ul li"

      filter_results(query: "foobar")

      refute_selector "select-panel ul li"
      assert_selector "select-panel", text: "No results"
    end

    def test_ev_loc_initial_failure
      visit_preview(:eventually_local_fetch_initial_failure)

      wait_for_items_to_load do
        click_on_invoker_button
      end

      refute_selector "select-panel ul li"
      assert_selector "[data-target='select-panel.fragmentErrorElement']", text: "Sorry, something went wrong"
      refute_selector "[data-target='select-panel.bannerErrorElement']"
    end

    def test_ev_loc_items_load_without_filter
      visit_preview(:eventually_local_fetch, show_filter: false)

      wait_for_items_to_load do
        click_on_invoker_button
      end

      # items should render without error
      assert_selector "select-panel ul li"
    end

    ########## REMOTE TESTS ############

    def test_remote_items_load
      visit_preview(:remote_fetch)

      wait_for_items_to_load do
        click_on_invoker_button
      end

      assert_selector "select-panel ul li", text: "Photon torpedo"
    end

    def test_remote_no_results
      visit_preview(:remote_fetch_no_results)

      wait_for_items_to_load do
        click_on_invoker_button
      end

      refute_selector "select-panel ul li"
      assert_selector "select-panel", text: "No results"
    end

    def test_remote_no_results_after_filter
      visit_preview(:remote_fetch)

      wait_for_items_to_load do
        click_on_invoker_button
      end

      assert_selector "select-panel ul li"

      wait_for_items_to_load do
        filter_results(query: "foobar")
      end

      refute_selector "select-panel ul li"
      assert_selector "select-panel", text: "No results"
    end

    def test_remote_initial_failure
      visit_preview(:remote_fetch_initial_failure)

      wait_for_items_to_load do
        click_on_invoker_button
      end

      refute_selector "select-panel ul li"

      # only the error message in the list body should appear
      assert_selector "[data-target='select-panel.fragmentErrorElement']", text: "Sorry, something went wrong"
      refute_selector "[data-target='select-panel.bannerErrorElement']"
    end

    def test_remote_filter_failure
      visit_preview(:remote_fetch_filter_failure)

      wait_for_items_to_load do
        click_on_invoker_button
      end

      assert_selector "select-panel ul li"

      wait_for_items_to_load do
        filter_results(query: "foobar")
      end

      # items should still be visible
      assert_selector "select-panel ul li"

      # only the banner-based error message should appear
      assert_selector "[data-target='select-panel.bannerErrorElement']", text: "Sorry, something went wrong"
      refute_selector "[data-target='select-panel.fragmentErrorElement']"
    end

    ########## TAB INDEX TESTS ############

    def test_tab_indices
      visit_preview(:default)

      click_on_invoker_button

      # tab to list
      keyboard.type(:tab)

      assert_equal active_element.tag_name, "button"
      assert_includes active_element["class"], "ActionListContent"

      # tab out of list
      keyboard.type(:tab)

      # focus is no longer on the list
      assert_equal active_element.tag_name, "body"
    end

    def test_arrowing_through_items
      visit_preview(:default)

      click_on_invoker_button
      keyboard.type(:tab)  # tab to list

      1.upto(4) do |i|
        assert_equal active_element.text, "Item #{i}"
        keyboard.type(:down)
      end
    end

    def test_arrowing_down_on_last_item_wraps_to_top
      visit_preview(:default)

      click_on_invoker_button

      # tab to list and down to 4th item
      keyboard.type(:tab, :down, :down, :down)

      assert_equal active_element.text, "Item 4"

      keyboard.type(:down)

      assert_equal active_element.text, "Item 1"
    end

    def test_arrowing_up_on_first_item_wraps_to_bottom
      visit_preview(:default)

      click_on_invoker_button

      # tab to list and down to 4th item
      keyboard.type(:tab)

      assert_equal active_element.text, "Item 1"

      keyboard.type(:up)

      assert_equal active_element.text, "Item 4"
    end

    def test_arrowing_skips_filtered_items
      visit_preview(:eventually_local_fetch)

      wait_for_items_to_load do
        click_on_invoker_button
      end

      assert_selector "select-panel ul li", count: 8

      # photon torpedo and phaser should match
      filter_results(query: "ph")

      assert_selector "select-panel ul li", count: 2

      # tab to list
      keyboard.type(:tab)

      # Run this twice to ensure arrowing wraps back around.
      # Note that the controller renders items in a predictable order.
      2.times do |i|
        ["Photon torpedo", "Phaser"].each do |item_text|
          assert_includes active_element.text, item_text
          keyboard.type(:down)
        end
      end
    end

    def test_single_select_form
      visit_preview(:single_select_form, route_format: :json)

      click_on_invoker_button
      click_on_second_item

      click_on "Submit"

      # for some reason the JSON response is wrapped in HTML, I have no idea why
      response = JSON.parse(find("pre").text)
      assert_equal "item2", response.dig(*%w(form_params item))
    end

    def test_single_select_form_submits_pre_selected_item
      visit_preview(:single_select_form, route_format: :json)

      # the first item has been pre-selected, so there's no need to select any items
      click_on "Submit"

      # for some reason the JSON response is wrapped in HTML, I have no idea why
      response = JSON.parse(find("pre").text)
      assert_equal "item1", response.dig(*%w(form_params item))
    end

    def test_multi_select_form
      visit_preview(:multiselect_form, route_format: :json)

      click_on_invoker_button
      click_on_second_item
      keyboard.type(:escape) # close panel

      click_on "Submit"

      # for some reason the JSON response is wrapped in HTML, I have no idea why
      response = JSON.parse(find("pre").text)

      # first item is pre-selected
      assert_equal ["item1", "item2"], response.dig(*%w(form_params item))
    end

    ########## ANNOUNCEMENT TESTS ############

    def test_ev_loc_announces_items
      visit_preview(:eventually_local_fetch)

      assert_announces(message: "8 results tab for results") do
        wait_for_items_to_load do
          click_on_invoker_button
        end
      end
    end

    def test_remote_fetch_announces_items
      visit_preview(:remote_fetch)

      assert_announces(message: "8 results tab for results") do
        wait_for_items_to_load do
          click_on_invoker_button
        end
      end
    end

    def test_ev_loc_announces_no_results
      visit_preview(:eventually_local_fetch_no_results)

      assert_announces(message: "No results found") do
        wait_for_items_to_load do
          click_on_invoker_button
        end
      end
    end

    def test_remote_fetch_announces_no_results
      visit_preview(:remote_fetch_no_results)

      assert_announces(message: "No results found") do
        wait_for_items_to_load do
          click_on_invoker_button
        end
      end
    end
  end
end
