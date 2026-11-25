# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationDialogTest < System::TestCase
    include Primer::KeyboardTestHelpers
    include Primer::MouseTestHelpers
    include Primer::WindowTestHelpers

    def click_on_initial_dialog_close_button
      # this simulates capybara's #trigger method, which isn't supported with selenium drivers
      page.evaluate_script(<<~JS)
        document.querySelector("button[data-close-dialog-id='dialog-one']").dispatchEvent(new Event('click'))
      JS
    end

    def click_on_nested_dialog_close_button
      find("button[data-close-dialog-id='dialog-two']").click
    end

    def click_on_nested_dialog_button
      find("#dialog-show-dialog-two").click
    end

    def test_modal_has_accessible_name
      visit_preview(:default)

      click_button("Show Dialog")

      assert_selector("dialog[aria-labelledby]")
      assert_equal(find("dialog")["aria-labelledby"], find("h1")["id"])
    end

    def test_focuses_close_button
      visit_preview(:default)

      click_button("Show Dialog")

      assert_equal page.evaluate_script("document.activeElement")["aria-label"], "Close"
    end

    def test_focuses_autofocus_elements_inside_dialog
      visit_preview(:autofocus_element)

      click_button("Show Dialog")

      assert_equal page.evaluate_script("document.activeElement")["placeholder"], "This element is focused on open"
    end

    def test_closes_top_level_dialog
      visit_preview(:nested_dialog)

      click_button("Show Dialog")
      click_on_nested_dialog_button

      assert_equal(find("dialog#dialog-two")["open"].to_s, "true")

      click_on_nested_dialog_close_button

      assert_selector "dialog#dialog-two", visible: :hidden
      assert_selector "dialog#dialog-one"
    end

    def test_closes_dialog_that_is_not_top_level
      visit_preview(:nested_dialog)

      click_button("Show Dialog")
      click_on_nested_dialog_button

      assert_equal(find("dialog#dialog-two")["open"].to_s, "true")

      click_on_initial_dialog_close_button

      assert_selector "dialog#dialog-one", visible: :hidden
    end

    # We're just opening the dialog with a scrollable body
    # so the Axe scan can ensure the scrollable region is compliant
    def test_with_scrollable_body
      visit_preview(:long_text)
      click_button("Show Dialog")
    end

    def test_outside_click_closes_dialog
      visit_preview(:default)

      click_button("Show Dialog")
      mouse.click(x: 0, y: 0)

      refute_selector "dialog[open]"
    end

    def test_outside_click_does_not_close_dialog_with_form
      visit_preview(:with_form)

      click_button("Show Dialog")
      mouse.click(x: 0, y: 0)

      assert_selector "dialog[open]"
    end

    def test_outside_menu_click_does_not_close_dialog
      visit_preview(:with_auto_complete)

      click_button("Show Dialog")
      fill_in "input", with: "a"

      find(".ActionListItem", text: "Avocado").click
      assert_selector "dialog[open]"
    end

    def test_auto_complete_keyboard_reflow_at_normal_viewport
      assert_auto_complete_keyboard_reflow(width: 1280, height: 800)
    end

    def test_auto_complete_keyboard_reflow_at_320_by_256_css_pixels
      assert_auto_complete_keyboard_reflow(width: 320, height: 256)
    end

    def test_auto_complete_keyboard_reflow_at_200_percent_zoom_equivalent
      # A 1280x512 viewport at 200% zoom is equivalent to 640x256 CSS pixels.
      assert_auto_complete_keyboard_reflow(width: 640, height: 256)
    end

    def test_auto_complete_keyboard_reflow_when_open_results_grow
      window.resize(width: 320, height: 256)
      visit_preview(:with_auto_complete)
      click_button("Show Dialog")

      fill_in "input", with: "app"
      assert_selector "#list [role='option']", count: 1
      find("#input").evaluate_script("this.focus()")
      assert_selector "#list:popover-open"

      fill_in "input", with: "a"
      assert_selector "#list [role='option']", minimum: 2
      assert_selector "#list:popover-open"

      all("#list [role='option']").each do |option|
        keyboard.type(:down)
        assert_auto_complete_option_in_view(option)
      end
    end

    def test_auto_complete_active_option_stays_visible_after_viewport_resize
      window.resize(width: 1280, height: 800)
      visit_preview(:with_auto_complete)
      click_button("Show Dialog")
      fill_in "input", with: "a"
      assert_selector "#list [role='option']", minimum: 2
      find("#input").evaluate_script("this.focus()")

      options = all("#list [role='option']").to_a
      options.each do |option|
        keyboard.type(:down)
        assert_auto_complete_option_in_view(option)
      end

      window.resize(width: 320, height: 256)

      assert_field "input", with: "a"
      assert_auto_complete_option_in_view(options.last)
    end

    def test_auto_complete_repositions_after_input_width_resize
      ApplicationController.helpers.color_themes.each do |theme|
        assert_auto_complete_anchor_resize(dimension: :width, theme: theme)
      end
    end

    def test_auto_complete_repositions_after_input_height_resize
      ApplicationController.helpers.color_themes.each do |theme|
        assert_auto_complete_anchor_resize(dimension: :height, theme: theme)
      end
    end

    def test_auto_complete_tracks_visual_viewport_resize_and_scroll
      ApplicationController.helpers.color_themes.each do |theme|
        options = open_auto_complete_results(height: 640, theme: theme)
        keyboard.type(:up)
        assert_auto_complete_option_in_view(options.last)

        # Simulate keyboard/pinch-zoom bounds without changing the layout viewport.
        document_height = page.evaluate_script("document.documentElement.clientHeight")
        set_visual_viewport(event: "resize", width: 224, height: 180, left_offset: 32, top_offset: -112)

        assert_equal document_height, page.evaluate_script("document.documentElement.clientHeight")
        assert_auto_complete_popup_in_view
        assert_auto_complete_option_in_view(options.last)

        # Pan the visible area so the popup must change sides and horizontal alignment.
        set_visual_viewport(event: "scroll", width: 224, height: 180, left_offset: -48, top_offset: -48)

        assert_auto_complete_popup_in_view
        assert_auto_complete_option_in_view(options.last)
        assert_field "input", with: "a"

        keyboard.type(:enter)
        assert_field "input", with: options.last["data-autocomplete-value"]
        refute_selector "#list", visible: true
        assert_selector "dialog[open]"
      end
    end

    def test_auto_complete_stays_anchored_when_input_leaves_visual_viewport
      options = open_auto_complete_results
      keyboard.type(:up)
      assert_auto_complete_option_in_view(options.last)
      anchor_width = page.evaluate_script("document.querySelector('#input').getBoundingClientRect().width")
      anchor_height = page.evaluate_script("document.querySelector('#input').getBoundingClientRect().height")
      set_visual_viewport(event: "resize", width: 224, height: 180, left_offset: -16, top_offset: -112)
      assert_auto_complete_popup_in_view
      assert_auto_complete_option_in_view(options.last)

      [[anchor_width + 16, -112], [-16, anchor_height + 16]].each do |left_offset, top_offset|
        set_visual_viewport(event: "scroll", width: 224, height: 180, left_offset: left_offset, top_offset: top_offset)

        geometry = nil
        anchored = page.has_selector?("#list:popover-open") do |list|
          geometry = page.evaluate_script(<<~JS, list)
            (function(list) {
              const popup = list.getBoundingClientRect();
              const anchor = document.querySelector("#input").getBoundingClientRect();
              const viewport = window.visualViewport;
              return {
                anchored: Math.abs(popup.top - anchor.bottom - list.anchorOffset) <= 1 &&
                  Math.abs(popup.left - anchor.left - list.alignmentOffset) <= 1,
                offscreen: anchor.right <= viewport.offsetLeft || anchor.bottom <= viewport.offsetTop,
                popup: {top: popup.top, left: popup.left},
                expected: {top: anchor.bottom + list.anchorOffset, left: anchor.left + list.alignmentOffset}
              };
            })(arguments[0])
          JS
          geometry["anchored"] && geometry["offscreen"]
        end

        assert anchored, "Offscreen AutoComplete input loses its anchored popup: #{geometry.inspect}"
        assert_selector "#input[aria-activedescendant='#{options.last['id']}']"
        assert_selector "#list [role='option']", count: 18
      end
    end

    def test_auto_complete_configured_width_fits_visual_viewport
      assert_auto_complete_width_reflow(visual_width: 224)
    end

    def test_auto_complete_width_fits_below_192_pixels
      assert_auto_complete_width_reflow(visual_width: 160)
    end

    def test_auto_complete_keyboard_access_with_horizontal_placement
      [-20, -240].each do |left_offset|
        open_auto_complete_results
        update_auto_complete_and_wait(<<~JS)
          document.querySelector("#input").style.height = "40px";
          document.querySelector("#list").update();
        JS
        anchor_width = page.evaluate_script("document.querySelector('#input').getBoundingClientRect().width")
        set_visual_viewport(event: "resize", width: anchor_width + 260, height: 100, left_offset: left_offset, top_offset: -30)

        [:down, :up].each_with_index do |direction, index|
          if index.positive?
            fill_in "input", with: "a"
            assert_selector "#list [role='option']", count: 18
            find("#input").evaluate_script("this.focus()")
          end
          options = all("#list [role='option']").to_a
          options.reverse! if direction == :up

          options.each do |option|
            keyboard.type(direction)
            assert_auto_complete_option_in_view(option)
            assert_auto_complete_popup_in_view
          end

          keyboard.type(:enter)
          assert_field "input", with: options.last["data-autocomplete-value"]
          refute_selector "#list", visible: true
          assert_selector "dialog[open]"
        end
      end
    end

    def test_auto_complete_preserves_manual_results_scroll_on_updates
      options = open_auto_complete_results(width: 320, height: 256)
      keyboard.type(:up)
      assert_auto_complete_option_in_view(options.last)

      update_auto_complete_and_wait(<<~JS)
        document.body.classList.remove("has-modal-disable-scroll");
        document.body.style.minHeight = "2400px";
        document.querySelector("#list").scrollTop = 0;
        document.querySelector("#list").update();
      JS
      assert_equal 0, page.evaluate_script("document.querySelector('#list').scrollTop")

      update_auto_complete_and_wait("window.scrollTo(0, 80);")
      assert_equal 80, page.evaluate_script("window.scrollY")
      assert_equal 0, page.evaluate_script("document.querySelector('#list').scrollTop")

      previous_height = page.evaluate_script("document.querySelector('#list').clientHeight")
      window.resize(width: 1280, height: 800)
      assert_selector "#list:popover-open" do |list|
        list.evaluate_script("this.clientHeight") > previous_height
      end
      update_auto_complete_and_wait("document.querySelector('#list').update();")

      assert_equal 0, page.evaluate_script("document.querySelector('#list').scrollTop")
      assert_selector "#input[aria-activedescendant='#{options.last['id']}']"
    end

    def test_auto_complete_height_shrink_scrolls_only_the_results
      options = open_auto_complete_results
      keyboard.type(:up)
      assert_auto_complete_option_in_view(options.last)

      scroll_auto_complete_ancestors
      before = auto_complete_scroll_positions
      assert_operator before["body"], :>, 0
      assert_operator before["pageY"], :>, 0

      update_auto_complete_and_wait(<<~JS)
        document.querySelector("#list").style.maxHeight = "64px";
        document.querySelector("#list").update();
      JS
      assert_auto_complete_option_in_view(options.last)
      after = auto_complete_scroll_positions

      assert_operator after["results"], :>, before["results"]
      assert_equal before.except("results"), after.except("results")
    end

    def test_auto_complete_reflows_without_visual_viewport
      options = open_auto_complete_results
      keyboard.type(:up)
      assert_auto_complete_option_in_view(options.last)

      page.execute_script("Object.defineProperty(window, 'visualViewport', {configurable: true, value: undefined});")
      window.resize(width: 320, height: 256)

      assert_auto_complete_popup_in_view
      assert_auto_complete_option_in_view(options.last)
    end

    def test_auto_complete_updates_without_check_visibility
      options = open_auto_complete_results do
        page.execute_script(<<~JS)
          window.autoCompleteVisibilityDescriptor = Object.getOwnPropertyDescriptor(Element.prototype, "checkVisibility");
          window.autoCompleteVisibilityErrors = [];
          window.autoCompleteVisibilityErrorHandler = event => {
            window.autoCompleteVisibilityErrors.push(event.message);
            event.preventDefault();
          };
          window.addEventListener("error", window.autoCompleteVisibilityErrorHandler);
          Object.defineProperty(Element.prototype, "checkVisibility", {configurable: true, value: undefined});
        JS
      end
      assert_empty page.evaluate_script("window.autoCompleteVisibilityErrors")
      assert_auto_complete_popup_in_view
      keyboard.type(:up)
      assert_auto_complete_option_in_view(options.last)
      update_auto_complete_and_wait(<<~JS)
        document.querySelector("#list").style.position = "fixed";
        window.dispatchEvent(new Event("resize"));
      JS
      assert_nil page.evaluate_script("document.querySelector('#list').offsetParent")
      assert_auto_complete_popup_in_view
      assert_auto_complete_option_in_view(options.last)
      update_auto_complete_and_wait(<<~JS)
        document.querySelector("#list").style.position = "absolute";
        window.dispatchEvent(new Event("resize"));
      JS
      scroll_auto_complete_ancestors

      set_visual_viewport(event: "resize", width: 224, height: 180, left_offset: -16, top_offset: -112)
      assert_auto_complete_popup_in_view
      assert_auto_complete_option_in_view(options.last)
      set_visual_viewport(event: "scroll", width: 224, height: 180, left_offset: -48, top_offset: -48)
      assert_auto_complete_popup_in_view
      assert_auto_complete_option_in_view(options.last)
      keyboard.type(:enter)
      assert_field "input", with: options.last["data-autocomplete-value"]
      update_auto_complete_and_wait(<<~JS)
        for (const property of ["width", "height", "offsetLeft", "offsetTop"]) delete window.visualViewport[property];
        window.visualViewport.dispatchEvent(new Event("resize"));
      JS
      fill_in "input", with: "a"
      assert_selector "#list [role='option']", count: 18
      find("#input").evaluate_script("this.focus()")
      assert_auto_complete_update_lifecycle
      update_auto_complete_and_wait("")
      assert_empty page.evaluate_script("window.autoCompleteVisibilityErrors")
    ensure
      page.execute_script(<<~JS)
        if (window.autoCompleteVisibilityDescriptor) {
          Object.defineProperty(Element.prototype, "checkVisibility", window.autoCompleteVisibilityDescriptor);
        }
        window.removeEventListener("error", window.autoCompleteVisibilityErrorHandler);
      JS
    end

    def test_auto_complete_uses_full_height_of_small_layout_viewport
      options = open_auto_complete_results
      window.resize(width: 1280, height: 100)
      layout_height = page.evaluate_script("document.documentElement.clientHeight")
      assert_operator layout_height, :>, 40
      assert_operator layout_height, :<, 160

      update_auto_complete_and_wait(<<~JS)
        const height = document.documentElement.clientHeight;
        Object.assign(document.querySelector("dialog").style, {animation: "none", transform: "none"});
        Object.assign(document.querySelector("#input").style, {
          position: "fixed", top: `${(height - 40) / 2}px`, left: "400px", width: "196px", height: "40px"
        });
        const option = document.querySelector("#list [role='option']");
        option.textContent = `${option.dataset.autocompleteValue}\\nA ripe fruit\\nA green fruit\\nReady to select`;
        Object.assign(option.style, {
          padding: "0", whiteSpace: "pre-wrap", lineHeight: `${Math.floor((height - 4) / 4)}px`, flexShrink: "0"
        });
        document.querySelector("#list").update();
      JS
      option_height = options.first.evaluate_script("this.getBoundingClientRect().height")
      assert_operator option_height, :<=, layout_height
      assert_operator option_height, :>, layout_height - 32
      assert_selector "#list:popover-open" do |list|
        list.evaluate_script("parseFloat(this.style.getPropertyValue('--anchored-position-available-height'))") == layout_height
      end

      keyboard.type(:down)
      assert_auto_complete_option_in_view(options.first)
      assert_auto_complete_popup_in_view
      keyboard.type(:enter)
      assert_field "input", with: options.first["data-autocomplete-value"]
    end

    def test_auto_complete_recovers_after_popup_loses_intersection
      open_auto_complete_results
      update_auto_complete_and_wait(<<~JS)
        const list = document.querySelector("#list");
        window.popupIntersectionObserver = new IntersectionObserver(entries => {
          for (const entry of entries) entry.target.dataset.testIntersection = `${entry.isIntersecting}`;
        });
        window.popupIntersectionObserver.observe(list);
        Object.assign(document.querySelector("dialog").style, {animation: "none", transform: "none"});
        Object.assign(document.querySelector("#input").style, {
          position: "fixed", left: "400px", top: `${document.documentElement.clientHeight + 24}px`
        });
        list.update();
      JS
      assert_selector "#list:popover-open[data-test-intersection='false']", visible: :all
      assert_operator page.evaluate_script("document.querySelector('#list').getBoundingClientRect().top"),
                      :>=, page.evaluate_script("document.documentElement.clientHeight")
      update_auto_complete_and_wait("")

      update_auto_complete_and_wait(<<~JS)
        document.querySelector("#input").style.top = "100px";
        window.visualViewport.dispatchEvent(new Event("resize"));
      JS

      assert_auto_complete_popup_in_view
      assert_selector "#list:popover-open[data-test-intersection='true']"
      assert_selector "#list [role='option']", count: 18
    ensure
      page.execute_script("window.popupIntersectionObserver?.disconnect(); delete window.popupIntersectionObserver;")
    end

    def test_auto_complete_visual_width_reflow_keeps_active_option_visible
      assert_auto_complete_wrapping_reflow(layout_resize: false, manually_scrolled: false)
    end

    def test_auto_complete_layout_width_reflow_keeps_active_option_visible
      assert_auto_complete_wrapping_reflow(layout_resize: true, manually_scrolled: false)
    end

    def test_auto_complete_layout_width_reflow_preserves_manual_scroll
      assert_auto_complete_wrapping_reflow(layout_resize: true, manually_scrolled: true)
    end

    def test_auto_complete_content_reflow_keeps_active_option_visible
      assert_auto_complete_content_reflow(manually_scrolled: false)
    end

    def test_auto_complete_content_reflow_preserves_manual_scroll
      assert_auto_complete_content_reflow(manually_scrolled: true)
    end

    def test_auto_complete_row_resize_keeps_active_option_visible
      assert_auto_complete_content_reflow(manually_scrolled: false, mutations: [:description, :padding])
    end

    def test_auto_complete_row_resize_preserves_manual_scroll
      assert_auto_complete_content_reflow(manually_scrolled: true, mutations: [:description, :padding])
    end

    def test_auto_complete_fractional_bounds_preserve_active_visibility
      options = open_auto_complete_results(results_width: :medium)
      scroll_auto_complete_ancestors
      update_auto_complete_and_wait(<<~JS)
        const list = document.querySelector("#list");
        Object.assign(list.style, {
          width: "319.25px", minWidth: "0", maxWidth: "319.25px",
          height: "96px", maxHeight: "96px", padding: "0", border: "0"
        });
        list.update();
      JS
      keyboard.type(:up)
      assert_auto_complete_option_in_view(options.last)
      geometry = page.evaluate_script(<<~JS)
        (function() {
          const list = document.querySelector("#list");
          const popup = list.getBoundingClientRect();
          const option = list.querySelector("[role='option']:last-child").getBoundingClientRect();
          return {
            roundedOverflow: option.right - popup.left - list.clientLeft - list.clientWidth,
            paintedOverflow: option.right - popup.right
          };
        })()
      JS
      assert_operator geometry["roundedOverflow"], :>, 0
      assert_operator geometry["roundedOverflow"], :<=, 1
      assert_operator geometry["paintedOverflow"], :<=, 0
      before = auto_complete_scroll_positions
      count_auto_complete_updates

      update_auto_complete_and_wait(<<~JS)
        Object.assign(document.querySelector("#list").style, {height: "64px", maxHeight: "64px"});
        window.dispatchEvent(new Event("resize"));
      JS

      assert_auto_complete_option_in_view(options.last)
      assert_equal before.except("results"), auto_complete_scroll_positions.except("results")
      assert_auto_complete_geometry_settles
      keyboard.type(:enter)
      assert_field "input", with: options.last["data-autocomplete-value"]
    end

    def test_auto_complete_unbroken_labels_wrap_inside_narrow_results
      ApplicationController.helpers.color_themes.each do |theme|
        options = open_auto_complete_results(width: 224, height: 640, theme: theme)
        update_auto_complete_and_wait(<<~JS)
          const labels = document.querySelectorAll("#list .ActionListItem-label");
          for (const label of [labels[0], labels[1]]) label.textContent = "fruit-" + "abcdefghijklmnopqrstuvwxyz0123456789".repeat(3);
          labels[1].classList.add("ActionListItem-label--truncate");
        JS
        keyboard.type(:down)
        geometry = nil
        wrapped = page.has_selector?("#list:popover-open") do |list|
          geometry = list.evaluate_script(<<~JS)
            (function(list) {
              const label = list.querySelector(".ActionListItem-label");
              const range = document.createRange();
              range.selectNodeContents(label);
              const lines = [...range.getClientRects()];
              const popup = list.getBoundingClientRect();
              const left = popup.left + list.clientLeft;
              return {
                fits: lines.length > 1 && lines.every(rect => rect.left >= left - 1 &&
                  rect.right <= left + list.clientWidth + 1) && list.scrollWidth <= list.clientWidth + 1,
                lines: lines.map(rect => ({left: rect.left, right: rect.right})),
                clientWidth: list.clientWidth, scrollWidth: list.scrollWidth,
                height: label.getBoundingClientRect().height,
                truncatedHeight: list.querySelector(".ActionListItem-label--truncate").getBoundingClientRect().height
              };
            })(this)
          JS
          geometry["fits"]
        end
        assert wrapped, "An unbroken AutoComplete label is clipped in #{theme}: #{geometry.inspect}"
        assert_operator geometry["height"], :>, geometry["truncatedHeight"]
        assert_auto_complete_option_in_view(options.first)
        assert_auto_complete_popup_in_view
        keyboard.type(:enter)
        assert_field "input", with: options.first["data-autocomplete-value"]
      end
    end

    def test_auto_complete_temporary_undersizing_restores_active_option
      assert_auto_complete_temporary_undersizing(action: :none)
    end

    def test_auto_complete_temporary_undersizing_preserves_manual_scroll
      assert_auto_complete_temporary_undersizing(action: :scroll)
    end

    def test_auto_complete_temporary_undersizing_does_not_transfer_selection
      assert_auto_complete_temporary_undersizing(action: :selection)
    end

    def test_auto_complete_temporary_undersizing_resets_after_reopen
      assert_auto_complete_temporary_undersizing(action: :reopen)
    end

    def test_auto_complete_oversized_reflow_above_keeps_active_option_partly_visible
      assert_auto_complete_oversized_reflow(direction: :above, action: :none)
    end

    def test_auto_complete_oversized_reflow_below_keeps_active_option_partly_visible
      assert_auto_complete_oversized_reflow(direction: :below, action: :none)
    end

    def test_auto_complete_oversized_reflow_preserves_manual_scroll
      [:above, :below].each do |direction|
        assert_auto_complete_oversized_reflow(direction: direction, action: :scroll)
      end
    end

    def test_auto_complete_oversized_reflow_preserves_partial_visibility
      [:above, :below].each do |direction|
        assert_auto_complete_oversized_reflow(direction: direction, action: :partial)
      end
    end

    def test_auto_complete_layout_widening_keeps_active_option_visible
      assert_auto_complete_wrapping_reflow(layout_resize: true, manually_scrolled: false, widening: true)
    end

    def test_auto_complete_layout_widening_preserves_manual_scroll
      assert_auto_complete_wrapping_reflow(layout_resize: true, manually_scrolled: true, widening: true)
    end

    def test_auto_complete_visual_widening_keeps_active_option_visible
      assert_auto_complete_wrapping_reflow(layout_resize: false, manually_scrolled: false, widening: true)
    end

    def test_auto_complete_no_results_message_fits_short_viewport
      assert_auto_complete_no_results_fit(height: 100)
    end

    def test_auto_complete_no_results_message_fits_padding_boundary
      ApplicationController.helpers.color_themes.each do |theme|
        assert_auto_complete_no_results_fit(height: 128, theme: theme)
      end
    end

    def test_auto_complete_no_results_message_fits_bordered_padding_boundary
      assert_auto_complete_no_results_fit(height: 128, border_width: 2)
    end

    def test_auto_complete_keyboard_selection_reconsiders_narrowed_side_placement
      ApplicationController.helpers.color_themes.each do |theme|
        assert_auto_complete_mixed_height_placement(theme: theme, manually_scrolled: false)
      end
    end

    def test_auto_complete_mixed_height_placement_preserves_manual_scroll
      assert_auto_complete_mixed_height_placement(theme: "light", manually_scrolled: true)
    end

    def test_auto_complete_css_height_shrink_preserves_manual_scroll
      options = open_auto_complete_results
      scroll_auto_complete_ancestors
      update_auto_complete_and_wait(<<~JS)
        const style = document.createElement("style");
        style.textContent = `
          #list { height: 96px; max-height: 96px; }
          @media (max-height: 650px) { #list { height: 64px; max-height: 64px; } }
        `;
        document.head.append(style);
        document.querySelector("#list").update();
      JS
      keyboard.type(:up)
      assert_auto_complete_option_in_view(options.last)
      update_auto_complete_and_wait("document.querySelector('#list').scrollTop = 0;")
      before = auto_complete_scroll_positions
      height = page.evaluate_script("document.querySelector('#list').clientHeight")
      count_auto_complete_updates

      window.resize(width: 1280, height: 600)

      assert_selector "#list:popover-open" do |list|
        list.evaluate_script("this.clientHeight") < height
      end
      update_auto_complete_and_wait("")
      assert_equal before, auto_complete_scroll_positions
      assert_selector "#input[aria-activedescendant='#{options.last['id']}']"
      assert_auto_complete_geometry_settles
    end

    def test_auto_complete_ancestor_height_shrink_preserves_manual_scroll
      options = open_auto_complete_results(height: 600)
      update_auto_complete_and_wait(<<~JS)
        Object.assign(document.querySelector("dialog").style, {
          animation: "none", transform: "none", top: `${document.documentElement.clientHeight / 2 - 80}px`,
          bottom: "auto", margin: "0 auto"
        });
      JS
      scroll_auto_complete_ancestors
      keyboard.type(:up)
      assert_auto_complete_option_in_view(options.last)
      update_auto_complete_and_wait("document.querySelector('#list').scrollTop = 0;")
      before = auto_complete_scroll_positions
      geometry_before = ancestor_scroll_geometry
      count_auto_complete_updates

      update_auto_complete_and_wait("document.querySelector('dialog .Overlay-body').scrollTop += 40;")

      geometry_after = nil
      shrank = page.has_selector?("#list:popover-open") do
        geometry_after = ancestor_scroll_geometry
        geometry_after["height"] < geometry_before["height"]
      end
      assert shrank, "Ancestor scrolling does not shrink the popup: #{geometry_before.inspect} -> #{geometry_after.inspect}"
      after = auto_complete_scroll_positions
      assert_in_delta before["body"] + 40, after["body"], 1
      assert_equal before.except("body"), after.except("body")
      assert_selector "#input[aria-activedescendant='#{options.last['id']}']"
      assert_auto_complete_popup_in_view
      assert_auto_complete_geometry_settles
    end

    def test_auto_complete_follows_real_ancestor_scrolling
      open_auto_complete_results
      update_auto_complete_and_wait(<<~JS)
        Object.assign(document.querySelector("dialog").style, {
          animation: "none", transform: "none", top: `${document.documentElement.clientHeight / 2 - 80}px`,
          bottom: "auto", margin: "0 auto"
        });
        const body = document.querySelector("dialog .Overlay-body");
        for (const position of ["afterbegin", "beforeend"]) {
          const spacer = document.createElement("div");
          spacer.style.height = "160px";
          body.insertAdjacentElement(position, spacer);
        }
        body.style.maxHeight = "160px";
        body.scrollTop = 112;
        document.querySelector("#list").update();
      JS
      assert_auto_complete_popup_in_view
      assert_selector "#list:popover-open" do |list|
        list.evaluate_script("this.getBoundingClientRect().bottom <= document.querySelector('#input').getBoundingClientRect().top - this.anchorOffset + 1")
      end
      before = ancestor_scroll_geometry
      assert_operator before["body"], :>, 0
      count_auto_complete_updates

      update_auto_complete_and_wait("document.querySelector('dialog .Overlay-body').scrollTop += 40;")
      after = ancestor_scroll_geometry
      assert_in_delta before["body"] + 40, after["body"], 1
      assert_in_delta before["inputTop"] - 40, after["inputTop"], 1
      assert_auto_complete_popup_in_view
      refute_equal before["availableHeight"], ancestor_scroll_geometry["availableHeight"]

      update_auto_complete_and_wait("")
      updates = page.evaluate_script("window.autoCompleteUpdateCount")
      update_auto_complete_and_wait("")
      assert_equal updates, page.evaluate_script("window.autoCompleteUpdateCount"), "Popup scrolling starts an update loop"

      update_auto_complete_and_wait("document.querySelector('#list').displayInViewport = false;")
      update_auto_complete_and_wait("window.autoCompleteUpdateCount = 0;")
      update_auto_complete_and_wait("document.querySelector('dialog .Overlay-body').scrollTop -= 20;")
      assert_equal 0, page.evaluate_script("window.autoCompleteUpdateCount"), "Ancestor scrolling updates a non-opted-in popup"
    end

    def test_auto_complete_uses_horizontal_space_with_oversized_option
      [0, 1].each_with_index do |selected_index, iteration|
        if iteration.zero?
          open_auto_complete_results
        else
          fill_in "input", with: "a"
          assert_selector "#list [role='option']", count: 18
          find("#input").evaluate_script("this.focus()")
        end
        options = all("#list [role='option']").to_a
        update_auto_complete_and_wait(<<~JS)
          document.querySelector("#input").style.height = "40px";
          const options = document.querySelectorAll("#list [role='option']");
          Object.assign(options[0].style, {height: "32px", minHeight: "0", padding: "0", flexShrink: "0"});
          Object.assign(options[1].style, {height: "120px", minHeight: "0", padding: "0", flexShrink: "0"});
          document.querySelector("#list").update();
        JS
        anchor_width = page.evaluate_script("document.querySelector('#input').getBoundingClientRect().width")
        set_visual_viewport(event: "resize", width: anchor_width + 260, height: 100, left_offset: -20, top_offset: -30)

        assert_selector "#list [role='option']", count: 18
        assert_equal 32, options.first.evaluate_script("this.getBoundingClientRect().height")
        assert_operator options[1].evaluate_script("this.getBoundingClientRect().height"),
                        :>, page.evaluate_script("window.visualViewport.height")
        keyboard.type(:down)
        assert_auto_complete_option_in_view(options.first)
        assert_auto_complete_popup_in_view
        if selected_index.positive?
          keyboard.type(:down)
          assert_selector "#input[aria-activedescendant='#{options[1]['id']}']"
        end
        keyboard.type(:enter)
        assert_field "input", with: options[selected_index]["data-autocomplete-value"]
      end
    end

    def test_auto_complete_offscreen_anchor_without_visual_viewport
      open_auto_complete_results
      update_auto_complete_and_wait(<<~JS)
        Object.defineProperty(window, "visualViewport", {configurable: true, value: undefined});
        document.querySelector("#list").update();
      JS
      assert_auto_complete_popup_in_view

      ["left", "top"].each do |side|
        update_auto_complete_and_wait(<<~JS)
          Object.assign(document.querySelector("dialog").style, {animation: "none", transform: "none"});
          Object.assign(document.querySelector("#input").style, {
            position: "fixed", left: "400px", top: "100px",
            #{side}: `${document.documentElement.#{side == "left" ? "clientWidth" : "clientHeight"} + 24}px`
          });
          document.querySelector("#list").update();
        JS
        assert_auto_complete_popup_anchored_to_offscreen_input
        assert_selector "#list [role='option']", count: 18
      end

      update_auto_complete_and_wait("document.querySelector('#list').allowOutOfBounds = true;")
      assert_auto_complete_popup_anchored_to_offscreen_input

      update_auto_complete_and_wait(<<~JS)
        const list = document.querySelector("#list");
        list.displayInViewport = false;
        list.allowOutOfBounds = false;
      JS
      assert_selector "#list:popover-open" do |list|
        list.evaluate_script(<<~JS)
          (function(list) {
            const rect = list.getBoundingClientRect();
            return rect.top >= -1 && rect.left >= -1 &&
              rect.bottom <= document.documentElement.clientHeight + 1 &&
              rect.right <= document.documentElement.clientWidth + 1;
          })(this)
        JS
      end
    end

    def test_auto_complete_classic_scrollbar_placement_settles
      skip "The custom scrollbar geometry test requires Chrome" unless Primer::DriverTestHelpers.chrome?

      with_visible_scrollbars do
        open_auto_complete_results(results_width: :medium, query: "grape", result_count: 2)
        center_auto_complete_input(width: 1280, height: 150)
        update_auto_complete_and_wait(<<~JS)
          const list = document.querySelector("#list");
          const style = document.createElement("style");
          style.textContent = "#list::-webkit-scrollbar { width: 16px; }";
          document.head.append(style);
          Object.assign(list.style, {padding: "0", scrollbarGutter: "auto"});
          list.style.setProperty("overflow-y", "hidden", "important");
          const anchor = document.querySelector("#input").getBoundingClientRect();
          const available = Math.max(anchor.top - list.anchorOffset,
            document.documentElement.clientHeight - anchor.bottom - list.anchorOffset);
          const lineHeight = Math.min(20, Math.ceil(available * 0.75));
          const padding = Math.max(0, (available - 2 * lineHeight + 1) / 2);
          const options = list.querySelectorAll("[role='option']");
          for (const option of options) {
            option.textContent = option.dataset.autocompleteValue;
            Object.assign(option.style, {
              display: "block", flexShrink: "0", minHeight: "0", padding: `${padding}px 0`,
              font: `${Math.min(16, lineHeight)}px/${lineHeight}px monospace`, overflowWrap: "anywhere"
            });
          }
          const label = document.createElement("span");
          label.textContent = "M";
          Object.assign(label.style, {display: "block", whiteSpace: "normal", overflowWrap: "anywhere"});
          const range = document.createRange();
          options[0].replaceChildren(label);
          range.selectNodeContents(label);
          const glyphWidth = range.getBoundingClientRect().width;
          label.textContent = "M".repeat(Math.floor(list.clientWidth / glyphWidth));
          const withoutScrollbar = options[0].getBoundingClientRect().height;
          const withoutScrollbarWidth = list.clientWidth;
          list.style.setProperty("overflow-y", "scroll", "important");
          window.scrollbarCalibration = {
            available, withoutScrollbar, withoutScrollbarWidth, withScrollbarWidth: list.clientWidth,
            withScrollbar: options[0].getBoundingClientRect().height,
            gutter: list.offsetWidth - list.clientWidth
          };
          list.style.removeProperty("scrollbar-gutter");
          list.style.removeProperty("overflow-y");
          list.update();
        JS
        calibration = page.evaluate_script("window.scrollbarCalibration")
        assert_operator calibration["gutter"], :>, 0, "The browser does not provide a measurable classic scrollbar"
        assert_operator calibration["withoutScrollbar"], :<=, calibration["available"]
        assert_operator calibration["withScrollbar"], :>, calibration["available"], calibration.inspect
        count_auto_complete_updates

        assert_auto_complete_geometry_settles
        keyboard.type(:down)
        assert_auto_complete_option_in_view(find("#list [role='option']", match: :first))
        assert_auto_complete_popup_in_view
        keyboard.type(:enter)
        assert_field "input", with: "Grapes"
      end
    end

    def test_auto_complete_reconsiders_capped_placement_after_content_replacement
      open_auto_complete_results(results_width: :medium)
      update_auto_complete_and_wait(<<~JS)
        const list = document.querySelector("#list");
        list.style.padding = "0";
        for (const option of list.querySelectorAll("[role='option']")) {
          option.textContent = option.dataset.autocompleteValue;
          Object.assign(option.style, {display: "block", flexShrink: "0", padding: "0", lineHeight: "20px"});
        }
        list.update();
      JS
      center_auto_complete_input(width: 1280, height: 100)
      keyboard.type(:down)
      assert_auto_complete_option_in_view(find("#list [role='option']", match: :first))
      before = page.evaluate_script("document.querySelector('#list').clientHeight")
      assert_operator before, :<, 60
      count_auto_complete_updates

      update_auto_complete_and_wait(<<~JS)
        const list = document.querySelector("#list");
        const before = {width: list.clientWidth, height: list.clientHeight};
        for (const [index, option] of [...list.querySelectorAll("[role='option']")].entries()) {
          const replacement = option.cloneNode(true);
          if (index === 0) {
            replacement.style.whiteSpace = "pre-wrap";
            replacement.textContent = `${replacement.dataset.autocompleteValue}\\nA ripe fruit\\nReady to select`;
          }
          option.replaceWith(replacement);
        }
        window.contentReplacementGeometry = {
          before, after: {width: list.clientWidth, height: list.clientHeight}
        };
      JS
      geometry = page.evaluate_script("window.contentReplacementGeometry")
      assert_equal geometry["before"], geometry["after"], "Replacing content changes the observed popup box"
      first_option = find("#list [role='option']", match: :first)
      assert_auto_complete_option_in_view(first_option)
      assert_auto_complete_popup_in_view
      assert_operator page.evaluate_script("document.querySelector('#list').clientHeight"), :>, before
      assert_auto_complete_geometry_settles

      update_auto_complete_and_wait(<<~JS)
        const option = document.querySelector("#list [role='option']");
        option.firstChild.data = option.dataset.autocompleteValue;
      JS
      assert_selector "#list:popover-open" do |list|
        list.evaluate_script("this.clientHeight") == before
      end
      keyboard.type(:up, :up)
      options = all("#list [role='option']").to_a
      assert_auto_complete_option_in_view(options.last)
      update_auto_complete_and_wait("document.querySelector('#list').scrollTop = 0;")
      scroll_before = auto_complete_scroll_positions
      updates = page.evaluate_script("window.autoCompleteUpdateCount")
      update_auto_complete_and_wait(<<~JS)
        const option = document.querySelector("#list [role='option']");
        option.firstChild.data = `Fresh ${option.dataset.autocompleteValue}`;
      JS
      assert_selector "#list:popover-open" do
        page.evaluate_script("window.autoCompleteUpdateCount") > updates
      end
      assert_equal scroll_before, auto_complete_scroll_positions
      assert_selector "#input[aria-activedescendant='#{options.last['id']}']"
      assert_selector "#list [role='option']", count: 18
      keyboard.type(:down, :down)
      assert_auto_complete_option_in_view(first_option)
      keyboard.type(:enter)
      assert_field "input", with: first_option["data-autocomplete-value"]
    end

    def test_auto_complete_medium_width_uses_narrower_horizontal_space
      options = open_auto_complete_results(results_width: :medium)
      update_auto_complete_and_wait(<<~JS)
        const option = document.querySelector("#list [role='option']");
        const label = document.createElement("span");
        label.textContent = "A crisp apple picked this morning.";
        Object.assign(label.style, {
          display: "block", font: "12px/16px monospace", whiteSpace: "normal", overflowWrap: "anywhere"
        });
        option.replaceChildren(label);
        Object.assign(option.style, {display: "block", flexShrink: "0", padding: "8px"});
      JS
      configured_width = page.evaluate_script("document.querySelector('#list').getBoundingClientRect().width")
      original_option_height = options.first.evaluate_script("this.getBoundingClientRect().height")
      center_auto_complete_input(width: 640, height: 100)
      keyboard.type(:down)
      assert_auto_complete_option_in_view(options.first)
      assert_auto_complete_popup_in_view
      assert_operator page.evaluate_script("document.querySelector('#list').getBoundingClientRect().width"),
                      :<, configured_width
      assert_operator options.first.evaluate_script("this.getBoundingClientRect().height"), :>, original_option_height

      keyboard.type(:up, :up)
      assert_auto_complete_option_in_view(options.last)
      scroll_before = auto_complete_scroll_positions
      count_auto_complete_updates
      update_auto_complete_and_wait("document.querySelector('#list').update();")
      assert_auto_complete_option_in_view(options.last)
      assert_equal scroll_before, auto_complete_scroll_positions
      assert_auto_complete_geometry_settles

      update_auto_complete_and_wait("document.querySelector('#list').scrollTop = 0;")
      scroll_before = auto_complete_scroll_positions
      update_auto_complete_and_wait("document.querySelector('#list').update();")
      assert_equal scroll_before, auto_complete_scroll_positions
      assert_selector "#input[aria-activedescendant='#{options.last['id']}']"

      window.resize(width: 1280, height: 800)
      assert_selector "#list:popover-open" do |list|
        (list.evaluate_script("this.getBoundingClientRect().width") - configured_width).abs <= 1
      end
      assert_in_delta original_option_height, options.first.evaluate_script("this.getBoundingClientRect().height"), 1
      center_auto_complete_input(width: 640, height: 100)
      keyboard.type(:down, :down)
      assert_auto_complete_option_in_view(options.first)
      assert_auto_complete_popup_in_view
      keyboard.type(:enter)
      assert_field "input", with: options.first["data-autocomplete-value"]
    end

    def test_auto_complete_horizontal_sizing_preserves_minimum_and_opt_outs
      open_auto_complete_results(results_width: :medium)
      configured_width = page.evaluate_script("document.querySelector('#list').getBoundingClientRect().width")
      center_auto_complete_input(width: 560, height: 100)
      assert_selector "#list:popover-open" do |list|
        (list.evaluate_script("this.getBoundingClientRect().width") - configured_width).abs <= 1
      end
      assert_operator page.evaluate_script("parseFloat(getComputedStyle(document.querySelector('#list')).minWidth)"),
                      :>=, 192
      constrained_height = page.evaluate_script("document.querySelector('#list').clientHeight")
      assert_operator constrained_height, :<,
                      page.evaluate_script("document.querySelector('#list [role=\"option\"]').getBoundingClientRect().height")

      update_auto_complete_and_wait("document.querySelector('#list').allowOutOfBounds = true;")
      center_auto_complete_input(width: 640, height: 100)
      height = nil
      recovered = page.has_selector?("#list:popover-open") do |list|
        height = list.evaluate_script("this.clientHeight")
        height > constrained_height
      end
      assert recovered, "allowOutOfBounds keeps the dynamic height cap: #{constrained_height} -> #{height}"
      assert_operator height, :>=,
                      page.evaluate_script("document.querySelector('#list [role=\"option\"]').getBoundingClientRect().height")
      assert_operator height, :<=, page.evaluate_script("document.documentElement.clientHeight")
      assert_selector "#list:popover-open" do |list|
        list.evaluate_script(<<~JS, configured_width)
          Math.abs(this.getBoundingClientRect().width - arguments[0]) <= 1 &&
            Math.abs(this.getBoundingClientRect().top -
              document.querySelector("#input").getBoundingClientRect().bottom - this.anchorOffset) <= 1
        JS
      end
      update_auto_complete_and_wait("document.querySelector('#list').allowOutOfBounds = false;")
      center_auto_complete_input(width: 560, height: 100)
      assert_selector "#list:popover-open" do |list|
        list.evaluate_script("this.clientHeight") == constrained_height
      end
      update_auto_complete_and_wait(<<~JS)
        const list = document.querySelector("#list");
        list.displayInViewport = false;
        list.allowOutOfBounds = false;
      JS
      assert_selector "#list:popover-open" do |list|
        (list.evaluate_script("this.getBoundingClientRect().width") - configured_width).abs <= 1
      end
      assert_selector "#list [role='option']", count: 18
    end

    def test_auto_complete_updates_only_open_connected_popups
      open_auto_complete_results do
        track_auto_complete_resize_observations
      end
      assert_auto_complete_update_lifecycle
    ensure
      page.execute_script("if (window.autoCompleteResizeObserver) window.ResizeObserver = window.autoCompleteResizeObserver;")
    end

    def test_auto_complete_releases_replaced_anchor_observation
      [:attribute, :property].each do |assignment|
        open_auto_complete_results { track_auto_complete_resize_observations }
        assert_selector "#list:popover-open" do
          page.evaluate_script("window.autoCompleteObservedAnchors.has(document.querySelector('#input'))")
        end
        update_auto_complete_and_wait(<<~JS)
          const original = document.querySelector("#input");
          window.originalAutoCompleteInput = original;
          const replacement = original.cloneNode();
          replacement.id = "replacement-input";
          replacement.setAttribute("aria-label", "Replacement anchor");
          Object.assign(replacement.style, {position: "fixed", left: "100px", top: "80px", width: "200px"});
          original.parentElement.append(replacement);
          const list = document.querySelector("#list");
          if ("#{assignment}" === "attribute") list.anchor = replacement.id;
          else list.anchorElement = replacement;
        JS
        assert_selector "#list:popover-open" do
          page.evaluate_script(<<~JS)
            window.autoCompleteObservedAnchors.size === 1 &&
              window.autoCompleteObservedAnchors.has(document.querySelector("#replacement-input")) &&
              !window.autoCompleteObservedAnchors.has(window.originalAutoCompleteInput)
          JS
        end
        count_auto_complete_updates
        assert_auto_complete_geometry_settles
        update_auto_complete_and_wait("window.originalAutoCompleteInput.style.height = '80px';")
        assert_auto_complete_geometry_settles
        assert_equal 0, page.evaluate_script("window.autoCompleteUpdateCount"), "Resizing the old anchor updates its popup"
        update_auto_complete_and_wait("document.querySelector('#replacement-input').style.height = '80px';")
        assert_selector "#list:popover-open" do
          page.evaluate_script("window.autoCompleteUpdateCount") > 0
        end
        assert_auto_complete_geometry_settles
      end
    ensure
      page.execute_script(<<~JS)
        document.querySelector("#replacement-input")?.remove();
        if (window.autoCompleteResizeObserver) window.ResizeObserver = window.autoCompleteResizeObserver;
      JS
    end

    def test_click_events_can_be_added_to_invoker_buttons
      # use this preview because it assigns a static ID to the invoker button
      visit_preview(:with_header)

      page.evaluate_script(<<~JS)
        document.querySelector('#dialog-show-my-dialog').addEventListener('click', () => {
          window.dialogInvokerClicked = true
        })
      JS

      click_button("Show Dialog")

      assert page.evaluate_script("window.dialogInvokerClicked"), "click event was not fired"
    end

    def test_dialog_inside_overlay_opens_when_clicked
      visit_preview(:dialog_inside_overlay)

      click_button("Show overlay")
      # This preview has script that automatically opens the dialog when the overlay is clicked
      assert_selector "dialog[open]"

      click_button("Cancel")

      refute_selector "dialog[open]"

      click_button("Show Dialog")

      assert_selector "dialog[open]"
    end

    private

    def open_auto_complete_results(width: 1280, height: 800, theme: "light", results_width: :auto, query: "a", result_count: 18)
      window.resize(width: width, height: height)
      visit_preview(:with_auto_complete, theme: theme, width: results_width)
      yield if block_given?
      click_button("Show Dialog")
      fill_in "input", with: query
      assert_selector "#list [role='option']", count: result_count
      find("#input").evaluate_script("this.focus()")
      assert_selector "#list:popover-open"
      all("#list [role='option']").to_a
    end

    def assert_auto_complete_anchor_resize(dimension:, theme:)
      height = dimension == :width ? 128 : 800
      options = open_auto_complete_results(height: height, theme: theme, results_width: :medium)
      center_auto_complete_input(width: 1280, height: height)
      update_auto_complete_and_wait(<<~JS)
        Object.assign(document.querySelector("#input").style, {left: "100px", top: "#{dimension == :width ? 44 : 80}px"});
        document.querySelector("#list").update();
      JS
      keyboard.type(:down)
      assert_auto_complete_option_in_view(options.first)
      assert_auto_complete_popup_in_view
      count_auto_complete_updates
      assert_auto_complete_geometry_settles
      before = auto_complete_anchor_geometry
      scroll_before = auto_complete_scroll_positions.except("results")
      update_auto_complete_and_wait(<<~JS)
        document.querySelector("#input").style.#{dimension} = "#{dimension == :width ? 350 : 80}px";
      JS
      repositioned = page.has_selector?("#list:popover-open") do
        geometry = auto_complete_anchor_geometry
        if dimension == :width
          geometry["popup"]["left"] >= geometry["anchor"]["right"] + 3
        else
          (geometry["popup"]["top"] - geometry["anchor"]["bottom"] - 4).abs <= 1
        end
      end
      after = auto_complete_anchor_geometry
      assert_equal before.values_at("document", "viewport"), after.values_at("document", "viewport")
      assert_equal before["popup"].values_at("width", "height"), after["popup"].values_at("width", "height")
      assert_operator after["anchor"][dimension.to_s], :>, before["anchor"][dimension.to_s]
      assert repositioned, "Input-only #{dimension} resize does not reposition the popup in #{theme}: #{before.inspect} -> #{after.inspect}"
      assert_operator page.evaluate_script("window.autoCompleteUpdateCount"), :>, 0
      assert_auto_complete_option_in_view(options.first)
      assert_auto_complete_popup_in_view
      assert_equal scroll_before, auto_complete_scroll_positions.except("results")
      assert_auto_complete_geometry_settles
      keyboard.type(:enter)
      assert_field "input", with: options.first["data-autocomplete-value"]
    end

    def auto_complete_anchor_geometry
      page.evaluate_script(<<~JS)
        (function() {
          const list = document.querySelector("#list");
          const rectangle = element => {
            const rect = element.getBoundingClientRect();
            return {top: rect.top, bottom: rect.bottom, left: rect.left, right: rect.right,
              width: rect.width, height: rect.height};
          };
          return {
            anchor: rectangle(list.anchorElement),
            popup: rectangle(list),
            document: {width: document.documentElement.clientWidth, height: document.documentElement.clientHeight},
            viewport: {
              width: window.visualViewport.width, height: window.visualViewport.height,
              left: window.visualViewport.offsetLeft, top: window.visualViewport.offsetTop
            }
          };
        })()
      JS
    end

    def track_auto_complete_resize_observations
      page.execute_script(<<~JS)
        window.autoCompleteObservedRows = new Set();
        window.autoCompleteObservedAnchors = new Set();
        window.autoCompleteResizeObserver = window.ResizeObserver;
        const rows = window.autoCompleteObservedRows;
        const anchors = window.autoCompleteObservedAnchors;
        window.ResizeObserver = class extends window.ResizeObserver {
          targets = new Set();
          observe(target, options) {
            super.observe(target, options);
            if (target.matches("#list [role='option']")) rows.add(target);
            else if (target.matches("#input, #replacement-input")) anchors.add(target);
            else return;
            this.targets.add(target);
          }
          unobserve(target) {
            super.unobserve(target);
            this.targets.delete(target);
            rows.delete(target);
            anchors.delete(target);
          }
          disconnect() {
            super.disconnect();
            for (const target of this.targets) {
              rows.delete(target);
              anchors.delete(target);
            }
            this.targets.clear();
          }
        };
      JS
    end

    def assert_auto_complete_no_results_fit(height:, theme: "light", border_width: 0)
      open_auto_complete_results(results_width: :medium, theme: theme)
      page.execute_script("document.querySelector('auto-complete').src = '/auto_complete_no_results';")
      fill_in "input", with: "no matching fruits"
      assert_selector "#list [data-no-result-found='true'][aria-hidden='true']", text: "No results!"
      find("#input").evaluate_script("this.focus()")
      page.execute_script(<<~JS)
        Object.assign(document.querySelector("#list").style, {borderStyle: "solid", borderWidth: "#{border_width}px"});
      JS
      center_auto_complete_input(width: 1280, height: height)
      assert_auto_complete_popup_in_view

      geometry = nil
      in_view = page.has_selector?("#list [data-no-result-found='true']") do |message|
        geometry = message.evaluate_script(<<~JS)
          (function(message) {
            const list = message.closest("anchored-position");
            const rect = message.getBoundingClientRect();
            const popup = list.getBoundingClientRect();
            const style = getComputedStyle(list);
            const top = popup.top + list.clientTop;
            const left = popup.left + list.clientLeft;
            return {
              visible: rect.height > 0 && rect.width > 0 &&
                rect.top >= top && rect.bottom <= top + list.clientHeight &&
                rect.left >= left && rect.right <= left + list.clientWidth &&
                rect.top >= 0 && rect.bottom <= document.documentElement.clientHeight &&
                rect.left >= 0 && rect.right <= document.documentElement.clientWidth,
              message: {top: rect.top, bottom: rect.bottom, height: rect.height},
              popup: {
                top, height: list.clientHeight, paddingTop: style.paddingTop, paddingBottom: style.paddingBottom,
                borderTop: style.borderTopWidth, borderBottom: style.borderBottomWidth
              }
            };
          })(this)
        JS
        geometry["visible"]
      end
      assert in_view, "The no-results message is clipped in #{theme}: #{geometry.inspect}"

      keyboard.type(:down, :up, :enter)
      assert_selector "#input:not([aria-activedescendant])"
      assert_field "input", with: "no matching fruits"
      assert_selector "#list [data-no-result-found='true'][aria-hidden='true']", count: 1
      refute_selector "#list [role='option']", visible: :all
      assert_accessible
    end

    def assert_auto_complete_mixed_height_placement(theme:, manually_scrolled:)
      options = open_auto_complete_results(width: 1400, results_width: :xxlarge, theme: theme)
      update_auto_complete_and_wait(<<~JS)
        const labels = document.querySelectorAll("#list .ActionListItem-label");
        labels[0].replaceChildren("Fresh ripe fruit picked this morning", document.createElement("br"),
          "Red", document.createElement("br"), "Sweet");
        labels[1].textContent = "M";
        const range = document.createRange();
        range.selectNodeContents(labels[1]);
        labels[1].textContent = "M".repeat(Math.floor(labels[1].clientWidth / range.getBoundingClientRect().width * 0.98));
      JS
      configured = wrapping_option_geometry(index: 1)
      first_configured = wrapping_option_geometry(index: 0)
      center_auto_complete_input(width: 1400, height: 128)
      update_auto_complete_and_wait(<<~JS)
        const list = document.querySelector("#list");
        Object.assign(document.querySelector("#input").style, {left: "200px", width: "1000px", top: "60px"});
        const anchor = document.querySelector("#input").getBoundingClientRect();
        const style = getComputedStyle(list);
        window.mixedHeightGeometry = {
          available: Math.max(anchor.top - list.anchorOffset,
            document.documentElement.clientHeight - anchor.bottom - list.anchorOffset),
          sideSpace: Math.max(anchor.left - list.anchorOffset,
            document.documentElement.clientWidth - anchor.right - list.anchorOffset),
          insets: ["paddingTop", "paddingBottom", "borderTopWidth", "borderBottomWidth"].reduce(
            (sum, property) => sum + parseFloat(style[property]), 0)
        };
        list.update();
      JS
      setup_geometry = page.evaluate_script("window.mixedHeightGeometry")
      assert_operator configured["optionHeight"] + setup_geometry["insets"], :<=, setup_geometry["available"]
      assert_in_delta 196, setup_geometry["sideSpace"], 1

      keyboard.type(:down)
      assert_auto_complete_option_in_view(options.first)
      assert_auto_complete_popup_in_view
      narrowed = wrapping_option_geometry(index: 1)
      assert_operator narrowed["width"], :<, configured["width"]
      assert_operator narrowed["optionHeight"], :>, narrowed["clientHeight"], narrowed.inspect
      assert_operator wrapping_option_geometry(index: 0)["optionHeight"], :>, first_configured["optionHeight"]
      count_auto_complete_updates
      assert_auto_complete_geometry_settles
      updates = page.evaluate_script("window.autoCompleteUpdateCount")
      scroll_before = auto_complete_scroll_positions.except("results")

      keyboard.type(:down)

      assert_auto_complete_option_in_view(options[1], context: { configured: configured, narrowed: narrowed, slots: setup_geometry })
      assert_auto_complete_popup_in_view
      widened = wrapping_option_geometry(index: 1)
      assert_in_delta configured["width"], widened["width"], 1
      assert_in_delta configured["optionHeight"], widened["optionHeight"], 1
      assert_operator page.evaluate_script("window.autoCompleteUpdateCount"), :>, updates
      assert_equal scroll_before, auto_complete_scroll_positions.except("results")
      assert_auto_complete_geometry_settles
      if manually_scrolled
        update_auto_complete_and_wait("document.querySelector('#list').scrollTop = 0;")
        before = auto_complete_scroll_positions
        update_auto_complete_and_wait(<<~JS)
          document.querySelectorAll("#list .ActionListItem-label")[2].append(" fresh");
        JS
        assert_auto_complete_geometry_settles
        assert_equal before, auto_complete_scroll_positions
        geometry = wrapping_option_geometry(index: 1)
        assert_operator geometry["optionBottom"], :>, geometry["popupBottom"]
        assert_selector "#input[aria-activedescendant='#{options[1]['id']}']"
      else
        keyboard.type(:up)
        assert_auto_complete_option_in_view(options.first)
        assert_operator wrapping_option_geometry["width"], :<, configured["width"]
        assert_auto_complete_geometry_settles
        window.resize(width: 1400, height: 800)
        assert_selector "#list:popover-open" do |list|
          (list.evaluate_script("this.getBoundingClientRect().width") - configured["width"]).abs <= 1
        end
        assert_auto_complete_option_in_view(options.first)
        assert_in_delta configured["width"], wrapping_option_geometry["width"], 1
        assert_equal scroll_before, auto_complete_scroll_positions.except("results")
        assert_auto_complete_geometry_settles
        keyboard.type(:down)
        assert_auto_complete_option_in_view(options[1])
      end
      keyboard.type(:enter)
      assert_field "input", with: options[1]["data-autocomplete-value"]
    end

    def assert_auto_complete_width_reflow(visual_width:)
      open_auto_complete_results(results_width: :medium)
      original_width = page.evaluate_script("document.querySelector('#list').getBoundingClientRect().width")
      assert_operator original_width, :>, visual_width

      set_visual_viewport(event: "resize", width: visual_width, height: 180, left_offset: 0, top_offset: 0)
      assert_auto_complete_popup_in_view
      assert_selector "#list [role='option']", count: 18

      page.execute_script(<<~JS)
        for (const property of ["width", "height", "offsetLeft", "offsetTop"]) {
          delete window.visualViewport[property];
        }
        window.visualViewport.dispatchEvent(new Event("resize"));
      JS
      assert_selector "#list:popover-open" do |list|
        (list.evaluate_script("this.getBoundingClientRect().width") - original_width).abs <= 1
      end
    end

    def scroll_auto_complete_ancestors
      update_auto_complete_and_wait(<<~JS)
        const body = document.querySelector("dialog .Overlay-body");
        for (const position of ["afterbegin", "beforeend"]) {
          const spacer = document.createElement("div");
          spacer.style.height = "160px";
          body.insertAdjacentElement(position, spacer);
        }
        body.style.maxHeight = "160px";
        body.scrollTop = 112;
        document.body.classList.remove("has-modal-disable-scroll");
        document.body.style.minHeight = "2400px";
        window.scrollTo(0, 80);
        document.querySelector("#list").update();
      JS
    end

    def assert_auto_complete_content_reflow(manually_scrolled:, mutations: [:text, :children])
      mutations.each do |mutation|
        options = open_auto_complete_results(results_width: :medium)
        scroll_auto_complete_ancestors
        update_auto_complete_and_wait(<<~JS)
          const list = document.querySelector("#list");
          Object.assign(list.style, {height: "96px", minHeight: "96px", maxHeight: "96px"});
          for (const option of list.querySelectorAll("[role='option']")) {
            const label = document.createElement("span");
            label.textContent = option.dataset.autocompleteValue;
            Object.assign(label.style, {whiteSpace: "pre-wrap", font: "12px/16px monospace", display: "block"});
            option.replaceChildren(label);
            Object.assign(option.style, {padding: "8px", flexShrink: "0"});
            if ("#{mutation}" === "description") {
              option.style.display = "block";
              const description = document.createElement("span");
              description.className = "ActionListItem-description";
              description.textContent = "A ripe fruit\\nReady to select";
              Object.assign(description.style, {whiteSpace: "pre-wrap", font: "12px/16px monospace"});
              description.hidden = true;
              option.append(description);
            }
          }
          list.update();
        JS
        8.times { keyboard.type(:down) }
        option = options[7]
        assert_auto_complete_option_in_view(option)
        if manually_scrolled
          update_auto_complete_and_wait("document.querySelector('#list').scrollTop = 0;")
        end
        before = wrapping_option_geometry(index: 7)
        scroll_before = auto_complete_scroll_positions
        count_auto_complete_updates

        update_auto_complete_and_wait(<<~JS)
          const option = document.querySelectorAll("#list [role='option']")[7];
          const label = option.firstElementChild;
          const text = `${option.dataset.autocompleteValue}\\nA ripe fruit\\nReady to select`;
          if ("#{mutation}" === "text") label.firstChild.data = text;
          else if ("#{mutation}" === "children") label.replaceChildren(document.createTextNode(text));
          else if ("#{mutation}" === "padding") option.style.paddingBlock = "24px";
          else option.querySelector(".ActionListItem-description").hidden = false;
        JS
        after = wrapping_option_geometry(index: 7)
        assert_equal before.values_at("clientWidth", "clientHeight"), after.values_at("clientWidth", "clientHeight")
        assert_operator after["optionHeight"], :>, before["optionHeight"]
        if [:text, :children].include?(mutation)
          assert_operator after["labelHeight"], :>, before["labelHeight"]
        end
        assert_selector "#input[aria-activedescendant='#{option['id']}']"
        assert_selector "#list [role='option']", count: 18
        scroll_after = auto_complete_scroll_positions
        if manually_scrolled
          assert_equal scroll_before, scroll_after
          assert_operator after["optionBottom"], :>, after["popupBottom"]
        else
          assert_auto_complete_option_in_view(option)
          assert_operator scroll_after["results"], :>, scroll_before["results"]
          assert_equal scroll_before.except("results"), scroll_after.except("results")
        end
        assert_selector "#list:popover-open" do
          page.evaluate_script("window.autoCompleteUpdateCount") > 0
        end
        assert_auto_complete_geometry_settles
        keyboard.type(:enter)
        assert_field "input", with: option["data-autocomplete-value"]
      end
    end

    def assert_auto_complete_temporary_undersizing(action:)
      options = open_auto_complete_results
      scroll_auto_complete_ancestors
      update_auto_complete_and_wait(<<~JS)
        const list = document.querySelector("#list");
        Object.assign(list.style, {height: "96px", maxHeight: "96px", overflowAnchor: "none"});
        for (const option of list.querySelectorAll("[role='option']")) {
          Object.assign(option.style, {height: "64px", minHeight: "64px", flexShrink: "0"});
        }
        list.update();
      JS
      9.times { keyboard.type(:down) }
      option = options[8]
      assert_auto_complete_option_in_view(option)
      before = auto_complete_scroll_positions
      count_auto_complete_updates

      update_auto_complete_and_wait(<<~JS)
        Object.assign(document.querySelector("#list").style, {height: "40px", maxHeight: "40px"});
        window.dispatchEvent(new Event("resize"));
      JS
      assert_operator page.evaluate_script("document.querySelector('#list').clientHeight"),
                      :<, option.evaluate_script("this.getBoundingClientRect().height")
      case action
      when :scroll
        update_auto_complete_and_wait("document.querySelector('#list').scrollTop = 0;")
      when :selection
        keyboard.type(:down)
        option = options[9]
      when :reopen
        update_auto_complete_and_wait("document.querySelector('#list').hidePopover();")
        update_auto_complete_and_wait("document.querySelector('#list').showPopover();")
      end
      update_auto_complete_and_wait(<<~JS)
        const option = document.querySelector("#list [role='option']");
        Object.assign(option.style, {height: "160px", minHeight: "160px"});
      JS
      assert_selector "#input[aria-activedescendant='#{option['id']}']"
      undersized = auto_complete_scroll_positions
      assert_equal before.except("results"), undersized.except("results")

      update_auto_complete_and_wait(<<~JS)
        Object.assign(document.querySelector("#list").style, {height: "96px", maxHeight: "96px"});
        window.dispatchEvent(new Event("resize"));
      JS

      assert_equal 96, page.evaluate_script("document.querySelector('#list').clientHeight")
      assert_selector "#input[aria-activedescendant='#{option['id']}']"
      assert_equal before.except("results"), auto_complete_scroll_positions.except("results")
      if action == :none
        assert_auto_complete_option_in_view(option)
      else
        assert_equal undersized, auto_complete_scroll_positions
        geometry = wrapping_option_geometry(index: action == :selection ? 9 : 8)
        assert_operator geometry["optionBottom"], :>, geometry["popupBottom"] + 1
      end
      assert_auto_complete_geometry_settles
      keyboard.type(:enter)
      assert_field "input", with: option["data-autocomplete-value"]
    end

    def assert_auto_complete_oversized_reflow(direction:, action:)
      options = open_auto_complete_results(results_width: :medium)
      scroll_auto_complete_ancestors
      update_auto_complete_and_wait(<<~JS)
        const list = document.querySelector("#list");
        Object.assign(list.style, {height: "96px", minHeight: "96px", maxHeight: "96px", overflowAnchor: "none"});
        for (const [index, option] of Array.from(list.querySelectorAll("[role='option']")).entries()) {
          const label = document.createElement("span");
          label.className = "ActionListItem-label";
          label.textContent = Array("#{direction}" === "above" && index < 8 ? 7 : 3).fill(option.dataset.autocompleteValue).join("\\n");
          Object.assign(label.style, {whiteSpace: "pre-wrap", font: "12px/16px monospace", display: "block"});
          option.replaceChildren(label);
          Object.assign(option.style, {padding: "8px", flexShrink: "0"});
        }
        list.update();
      JS
      9.times { keyboard.type(:down) }
      option = options[8]
      assert_auto_complete_option_in_view(option)
      update_auto_complete_and_wait(<<~JS)
        const list = document.querySelector("#list");
        const option = list.querySelectorAll("[role='option']")[8];
        list.scrollTop += option.getBoundingClientRect().top - list.getBoundingClientRect().top - list.clientTop - 16;
      JS
      assert_auto_complete_option_in_view(option)
      if action == :scroll
        update_auto_complete_and_wait("document.querySelector('#list').scrollTop = 0;")
      end
      count_auto_complete_updates
      assert_auto_complete_geometry_settles
      before = wrapping_option_geometry(index: 8)
      scroll_before = auto_complete_scroll_positions

      update_auto_complete_and_wait(<<~JS)
        const options = document.querySelectorAll("#list [role='option']");
        if ("#{direction}" === "above") {
          for (const option of Array.from(options).slice(0, "#{action}" === "partial" ? 1 : 8)) {
            option.firstElementChild.textContent = option.dataset.autocompleteValue;
          }
        } else if ("#{action}" !== "partial") {
          options[0].firstElementChild.textContent = Array(13).fill(options[0].dataset.autocompleteValue).join("\\n");
        }
        options[8].firstElementChild.textContent = Array(11).fill(options[8].dataset.autocompleteValue).join("\\n");
      JS
      assert_selector "#list:popover-open" do
        page.evaluate_script("window.autoCompleteUpdateCount") > 0
      end
      assert_auto_complete_geometry_settles
      after = wrapping_option_geometry(index: 8)
      assert_equal before.values_at("clientWidth", "clientHeight"), after.values_at("clientWidth", "clientHeight")
      assert_operator after["optionHeight"], :>, after["clientHeight"]
      assert_selector "#input[aria-activedescendant='#{option['id']}']"
      assert_equal scroll_before.except("results"), auto_complete_scroll_positions.except("results")
      if action == :scroll
        assert_equal scroll_before, auto_complete_scroll_positions
        assert_operator after["optionTop"], :>=, after["popupBottom"]
      else
        assert_operator after["optionTop"], :<, after["popupBottom"], "#{direction}/#{action}: #{before.inspect} -> #{after.inspect}"
        assert_operator after["optionBottom"], :>, after["popupTop"], "#{direction}/#{action}: #{before.inspect} -> #{after.inspect}"
        if action == :partial
          assert_equal scroll_before, auto_complete_scroll_positions
        else
          assert_in_delta after["popupTop"], after["optionTop"], 1
          assert_operator (after["scrollTop"] - scroll_before["results"]).abs, :>, 1
        end
      end

      update_auto_complete_and_wait(<<~JS)
        Object.assign(document.querySelector("#list").style, {height: "256px", minHeight: "256px", maxHeight: "256px"});
      JS
      assert_equal scroll_before.except("results"), auto_complete_scroll_positions.except("results")
      if action == :scroll
        assert_equal scroll_before, auto_complete_scroll_positions
      else
        assert_auto_complete_option_in_view(option)
      end
      assert_auto_complete_geometry_settles
      keyboard.type(:enter)
      assert_field "input", with: option["data-autocomplete-value"]
    end

    def assert_auto_complete_update_lifecycle
      observing_rows = page.evaluate_script("!!window.autoCompleteObservedRows")
      if observing_rows
        assert_selector "#list:popover-open" do
          page.evaluate_script("window.autoCompleteObservedRows.size") == 18
        end
        assert_equal 1, page.evaluate_script("window.autoCompleteObservedAnchors.size")
      end
      update_auto_complete_and_wait(<<~JS)
        window.removedAutoCompleteRow = document.querySelector("#list [role='option']");
        window.removedAutoCompleteRow.replaceWith(window.removedAutoCompleteRow.cloneNode(true));
      JS
      if observing_rows
        assert_equal 18, page.evaluate_script("window.autoCompleteObservedRows.size")
        refute page.evaluate_script("window.autoCompleteObservedRows.has(window.removedAutoCompleteRow)")
      end
      count_auto_complete_updates
      update_auto_complete_and_wait("document.querySelector('#list').hidePopover();")
      update_auto_complete_and_wait(<<~JS)
        window.autoCompleteUpdateCount = 0;
        const option = document.querySelector("#list [role='option']");
        option.append(" fresh");
        option.style.paddingBlock = "24px";
        document.querySelector("#input").style.height = "48px";
        window.dispatchEvent(new Event("resize"));
        window.visualViewport.dispatchEvent(new Event("resize"));
      JS
      assert_equal 0, page.evaluate_script("window.autoCompleteUpdateCount"), "Events or content changes update a closed popup"
      assert_equal 0, page.evaluate_script("window.autoCompleteObservedRows.size") if observing_rows
      assert_equal 0, page.evaluate_script("window.autoCompleteObservedAnchors.size") if observing_rows

      update_auto_complete_and_wait("document.querySelector('#list').showPopover();")
      assert_auto_complete_popup_in_view
      update_auto_complete_and_wait("document.querySelector('#list').displayInViewport = false;")
      update_auto_complete_and_wait(<<~JS)
        window.autoCompleteUpdateCount = 0;
        const option = document.querySelector("#list [role='option']");
        option.replaceWith(option.cloneNode(true));
        document.querySelector("#input").style.height = "64px";
      JS
      assert_equal 0, page.evaluate_script("window.autoCompleteUpdateCount"), "Content changes update a non-opted-in popup"
      assert_equal 0, page.evaluate_script("window.autoCompleteObservedRows.size") if observing_rows
      assert_equal 0, page.evaluate_script("window.autoCompleteObservedAnchors.size") if observing_rows
      update_auto_complete_and_wait("document.querySelector('#list').displayInViewport = true;")
      update_auto_complete_and_wait(<<~JS)
        window.detachedPopup = document.querySelector("#list");
        window.detachedPopupParent = window.detachedPopup.parentElement;
        window.detachedPopup.remove();
        window.autoCompleteUpdateCount = 0;
        window.detachedPopup.querySelector("[role='option']").append(" fresh");
        window.dispatchEvent(new Event("resize"));
        window.visualViewport.dispatchEvent(new Event("resize"));
      JS
      assert_equal 0, page.evaluate_script("window.autoCompleteUpdateCount")
      assert_equal 0, page.evaluate_script("window.autoCompleteObservedRows.size") if observing_rows
      assert_equal 0, page.evaluate_script("window.autoCompleteObservedAnchors.size") if observing_rows
    ensure
      page.execute_script(<<~JS)
        if (window.detachedPopup && window.detachedPopupParent) {
          window.detachedPopupParent.append(window.detachedPopup);
          delete window.detachedPopup;
          delete window.detachedPopupParent;
        }
      JS
    end

    def assert_auto_complete_wrapping_reflow(layout_resize:, manually_scrolled:, widening: false)
      options = open_auto_complete_results(results_width: :medium, width: widening && layout_resize ? 224 : 1280)
      scroll_auto_complete_ancestors if widening
      update_auto_complete_and_wait(<<~JS)
        const list = document.querySelector("#list");
        Object.assign(list.style, {height: "96px", minHeight: "96px", maxHeight: "96px"});
        const options = [...list.querySelectorAll("[role='option']")];
        for (const option of #{widening} ? options : [options[17]]) {
          const label = document.createElement("span");
          label.textContent = #{widening} ? "A crisp apple picked this morning." :
            "A longer selected fruit name that wraps when the results popup becomes narrow.";
          Object.assign(label.style, {whiteSpace: "normal", lineHeight: "16px", display: "block", width: "100%"});
          if (#{widening}) label.style.font = "12px/16px monospace";
          option.replaceChildren(label);
          Object.assign(option.style, {padding: "8px", flexShrink: "0"});
        }
        list.update();
      JS
      if widening && !layout_resize
        top_offset = -page.evaluate_script("document.querySelector('#input').getBoundingClientRect().top")
        set_visual_viewport(event: "resize", width: 224, height: 800, left_offset: 0, top_offset: top_offset)
      end
      index = widening ? 8 : 17
      option = options[index]
      if widening
        9.times { keyboard.type(:down) }
      else
        keyboard.type(:up)
      end
      assert_auto_complete_option_in_view(option)
      if manually_scrolled
        update_auto_complete_and_wait("document.querySelector('#list').scrollTop = 0;")
        assert_selector "#input[aria-activedescendant='#{option['id']}']"
      end
      before = wrapping_option_geometry(index: index)
      scroll_before = auto_complete_scroll_positions
      count_auto_complete_updates if widening
      if layout_resize
        window.resize(width: widening ? 1280 : 224, height: 800)
      elsif widening
        page.execute_script(<<~JS)
          for (const property of ["width", "height", "offsetLeft", "offsetTop"]) delete window.visualViewport[property];
          window.visualViewport.dispatchEvent(new Event("resize"));
        JS
      else
        top_offset = -page.evaluate_script("document.querySelector('#input').getBoundingClientRect().top")
        set_visual_viewport(event: "resize", width: 224, height: 800, left_offset: 0, top_offset: top_offset)
      end
      after = nil
      assert_selector "#list:popover-open" do
        after = wrapping_option_geometry(index: index)
        if widening
          after["width"] > before["width"] && after["optionHeight"] < before["optionHeight"]
        else
          after["width"] < before["width"] && after["optionHeight"] > before["optionHeight"]
        end
      end
      assert_equal before["clientHeight"], after["clientHeight"]
      assert_operator after["labelHeight"], widening ? :< : :>, before["labelHeight"]
      assert_selector "#input[aria-activedescendant='#{option['id']}']"
      if manually_scrolled
        assert_equal scroll_before, auto_complete_scroll_positions
        assert_operator after["optionBottom"], :>, after["popupBottom"]
      else
        assert_auto_complete_option_in_view(option)
        scroll_after = auto_complete_scroll_positions
        assert_operator scroll_after["results"], widening ? :< : :>, scroll_before["results"]
        assert_equal scroll_before.except("results"), scroll_after.except("results")
      end
      assert_auto_complete_geometry_settles if widening
      unless manually_scrolled && !widening
        keyboard.type(:enter)
        assert_field "input", with: option["data-autocomplete-value"]
      end
    end

    def wrapping_option_geometry(index: 17)
      page.evaluate_script(<<~JS, index)
        (function(index) {
          const list = document.querySelector("#list");
          const option = list.querySelectorAll("[role='option']")[index];
          return {
            width: list.getBoundingClientRect().width, clientWidth: list.clientWidth, clientHeight: list.clientHeight,
            optionHeight: option.getBoundingClientRect().height, optionBottom: option.getBoundingClientRect().bottom,
            optionTop: option.getBoundingClientRect().top, scrollTop: list.scrollTop,
            labelHeight: option.firstElementChild.getBoundingClientRect().height,
            popupTop: list.getBoundingClientRect().top + list.clientTop,
            popupBottom: list.getBoundingClientRect().top + list.clientTop + list.clientHeight
          };
        })(arguments[0])
      JS
    end

    def ancestor_scroll_geometry
      page.evaluate_script(<<~JS)
        ({
          body: document.querySelector("dialog .Overlay-body").scrollTop,
          inputTop: document.querySelector("#input").getBoundingClientRect().top,
          height: document.querySelector("#list").clientHeight,
          availableHeight: parseFloat(document.querySelector("#list").style.getPropertyValue("--anchored-position-available-height"))
        })
      JS
    end

    def count_auto_complete_updates
      page.execute_script(<<~JS)
        const list = document.querySelector("#list");
        const update = list.update;
        window.autoCompleteUpdateCount = 0;
        list.update = function() {
          window.autoCompleteUpdateCount++;
          return update.call(this);
        };
      JS
    end

    def center_auto_complete_input(width:, height:)
      window.resize(width: width, height: height)
      update_auto_complete_and_wait(<<~JS)
        Object.assign(document.querySelector("dialog").style, {animation: "none", transform: "none"});
        Object.assign(document.querySelector("#input").style, {
          position: "fixed", left: "calc(50vw - 100px)", top: "calc(50vh - 20px)", width: "200px", height: "40px"
        });
        document.querySelector("#list").update();
      JS
    end

    def with_visible_scrollbars
      # Ferrum hides scrollbars by default, including their layout geometry.
      options = driver.options.except(:extensions).merge(
        ignore_default_browser_options: true,
        browser_options: Ferrum::Browser::Options::Chrome::DEFAULT_OPTIONS.except("hide-scrollbars").merge(
          driver.options.fetch(:browser_options)
        )
      )
      Capybara.register_driver(:primer_cuprite_visible_scrollbars) do |app|
        Capybara::Cuprite::Driver.new(app, options)
      end
      original_window = @window
      original_keyboard = @keyboard
      Capybara.using_driver(:primer_cuprite_visible_scrollbars) do
        @window = @keyboard = nil
        yield
      ensure
        @window = original_window
        @keyboard = original_keyboard
      end
    end

    def assert_auto_complete_geometry_settles
      samples = driver.evaluate_async_script(<<~JS)
        const callback = arguments[arguments.length - 1];
        const samples = [];
        function sample() {
          const list = document.querySelector("#list");
          const rect = list.getBoundingClientRect();
          samples.push({
            top: rect.top, left: rect.left, width: rect.width, height: rect.height,
            clientWidth: list.clientWidth, clientHeight: list.clientHeight, scrollHeight: list.scrollHeight,
            optionHeight: list.querySelector("[role='option']").getBoundingClientRect().height,
            updates: window.autoCompleteUpdateCount
          });
          if (samples.length < 16) requestAnimationFrame(sample);
          else callback(samples);
        }
        requestAnimationFrame(sample);
      JS
      assert_equal 1, samples.last(8).uniq.length, "Popup geometry does not settle: #{samples.inspect}"
    end

    def assert_auto_complete_popup_anchored_to_offscreen_input
      geometry = nil
      anchored = page.has_selector?("#list:popover-open", visible: :all) do |list|
        geometry = page.evaluate_script(<<~JS, list)
          (function(list) {
            const popup = list.getBoundingClientRect();
            const anchor = document.querySelector("#input").getBoundingClientRect();
            return {
              anchored: Math.abs(popup.top - anchor.bottom - list.anchorOffset) <= 1 &&
                Math.abs(popup.left - anchor.left - list.alignmentOffset) <= 1,
              offscreen: anchor.left >= document.documentElement.clientWidth ||
                anchor.top >= document.documentElement.clientHeight,
              popup: {top: popup.top, left: popup.left},
              expected: {top: anchor.bottom + list.anchorOffset, left: anchor.left + list.alignmentOffset}
            };
          })(arguments[0])
        JS
        geometry["anchored"] && geometry["offscreen"]
      end
      assert anchored, "Offscreen input without VisualViewport loses its anchored popup: #{geometry.inspect}"
    end

    def set_visual_viewport(event:, width:, height:, left_offset:, top_offset:)
      update_auto_complete_and_wait("")
      page.execute_script(<<~JS, event, width, height, left_offset, top_offset)
        const [event, width, height, leftOffset, topOffset] = arguments;
        const anchor = document.querySelector("#input").getBoundingClientRect();
        Object.defineProperties(window.visualViewport, {
          width: {configurable: true, value: width},
          height: {configurable: true, value: height},
          offsetLeft: {configurable: true, value: anchor.left + leftOffset},
          offsetTop: {configurable: true, value: anchor.top + topOffset}
        });
        window.visualViewport.dispatchEvent(new Event(event));
      JS
    end

    def update_auto_complete_and_wait(script)
      driver.evaluate_async_script(<<~JS)
        const callback = arguments[arguments.length - 1];
        #{script}
        requestAnimationFrame(() => requestAnimationFrame(() => callback(true)));
      JS
    end

    def auto_complete_scroll_positions
      page.evaluate_script(<<~JS)
        ({
          results: document.querySelector("#list").scrollTop,
          body: document.querySelector("dialog .Overlay-body").scrollTop,
          pageX: window.scrollX,
          pageY: window.scrollY
        })
      JS
    end

    def assert_auto_complete_popup_in_view
      geometry = nil
      in_view = page.has_selector?("#list:popover-open") do |list|
        geometry = page.evaluate_script(<<~JS, list)
          (function(list) {
            const rect = list.getBoundingClientRect();
            const anchor = document.querySelector("#input").getBoundingClientRect();
            const viewport = window.visualViewport;
            const left = viewport?.offsetLeft ?? 0;
            const top = viewport?.offsetTop ?? 0;
            const right = left + (viewport?.width ?? document.documentElement.clientWidth);
            const bottom = top + (viewport?.height ?? document.documentElement.clientHeight);
            return {
              visible: rect.width > 0 && rect.height > 0 &&
                rect.left >= left - 1 && rect.right <= right + 1 &&
                rect.top >= top - 1 && rect.bottom <= bottom + 1 &&
                (rect.bottom <= anchor.top - list.anchorOffset + 1 ||
                 rect.top >= anchor.bottom + list.anchorOffset - 1 ||
                 rect.right <= anchor.left - list.anchorOffset + 1 ||
                 rect.left >= anchor.right + list.anchorOffset - 1),
              popup: {top: rect.top, left: rect.left, right: rect.right, bottom: rect.bottom},
              bounds: {top, left, right, bottom}
            };
          })(arguments[0])
        JS
        geometry["visible"]
      end

      assert in_view, "AutoComplete popup is clipped or covers its input: #{geometry.inspect}"
    end

    def assert_auto_complete_keyboard_reflow(width:, height:)
      window.resize(width: width, height: height)
      visit_preview(:with_auto_complete)
      click_button("Show Dialog")

      [:down, :up].each do |direction|
        fill_in "input", with: "a"
        assert_selector "#list [role='option']", minimum: 2
        # Cuprite's fill_in does not move keyboard focus to the input.
        find("#input").evaluate_script("this.focus()")

        options = all("#list [role='option']").map do |option|
          { id: option["id"], value: option["data-autocomplete-value"] }
        end
        options.reverse! if direction == :up

        options.each_with_index do |option, index|
          if index.positive?
            fill_in "input", with: "a"
            assert_selector "#list [role='option']", minimum: 2
            find("#input").evaluate_script("this.focus()")
          end

          options.take(index + 1).each do |active_option|
            keyboard.type(direction)
            assert_auto_complete_option_in_view(find("#list [role='option'][id='#{active_option[:id]}']"))
          end

          keyboard.type(:enter)

          assert_field "input", with: option[:value]
          refute_selector "#list", visible: true
          assert_selector "dialog[open]"
        end
      end
    end

    def assert_auto_complete_option_in_view(option, context: nil)
      assert_selector "#input[aria-activedescendant='#{option['id']}']"

      geometry = nil
      in_view = page.has_selector?("#list [role='option'][id='#{option['id']}']") do |active_option|
        geometry = page.evaluate_script(<<~JS, active_option)
          (function(option) {
            const rect = option.getBoundingClientRect();
            const viewport = window.visualViewport;
            const bounds = {
              top: viewport?.offsetTop ?? 0,
              left: viewport?.offsetLeft ?? 0,
              right: (viewport?.offsetLeft ?? 0) + (viewport?.width ?? document.documentElement.clientWidth),
              bottom: (viewport?.offsetTop ?? 0) + (viewport?.height ?? document.documentElement.clientHeight)
            };

            for (let ancestor = option.parentElement; ancestor; ancestor = ancestor.parentElement) {
              const style = getComputedStyle(ancestor);
              const ancestorRect = ancestor.getBoundingClientRect();
              const left = ancestorRect.left + ancestor.clientLeft;
              const top = ancestorRect.top + ancestor.clientTop;

              if (/^(auto|scroll|hidden|clip)$/.test(style.overflowX)) {
                bounds.left = Math.max(bounds.left, left);
                bounds.right = Math.min(bounds.right, left + ancestor.clientWidth);
              }
              if (/^(auto|scroll|hidden|clip)$/.test(style.overflowY)) {
                bounds.top = Math.max(bounds.top, top);
                bounds.bottom = Math.min(bounds.bottom, top + ancestor.clientHeight);
              }

              // Top-layer elements escape clipping from their DOM ancestors.
              if (ancestor.matches(':popover-open, :modal')) break;
            }

            return {
              visible: rect.width > 0 && rect.height > 0 &&
                rect.top >= bounds.top - 1 && rect.left >= bounds.left - 1 &&
                rect.right <= bounds.right + 1 && rect.bottom <= bounds.bottom + 1,
              option: {top: rect.top, left: rect.left, right: rect.right, bottom: rect.bottom},
              bounds,
              viewport: {width: window.innerWidth, height: window.innerHeight},
              documentWidth: document.documentElement.scrollWidth
            };
          })(arguments[0])
        JS
        geometry["visible"]
      end

      assert in_view, "Active AutoComplete option #{option['id']} is clipped: #{geometry.inspect} #{context.inspect if context}"
      assert_operator geometry["documentWidth"], :<=, geometry["viewport"]["width"],
                      "AutoComplete causes horizontal viewport overflow"
      assert_selector "dialog[open]"
    end
  end
end
