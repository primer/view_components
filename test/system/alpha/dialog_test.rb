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

    def test_auto_complete_tracks_visual_viewport_resize_and_scroll
      ApplicationController.helpers.color_themes.each do |theme|
        options = open_auto_complete_results(theme: theme)
        keyboard.type(:up)
        assert_auto_complete_option_in_view(options.last)

        # Simulate keyboard/pinch-zoom bounds without changing Chrome's layout viewport.
        set_visual_viewport(event: "resize", width: 224, height: 180, left_offset: 32, top_offset: -112)

        assert_equal 800, page.evaluate_script("document.documentElement.clientHeight")
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

    def open_auto_complete_results(width: 1280, height: 800, theme: "light")
      window.resize(width: width, height: height)
      visit_preview(:with_auto_complete, theme: theme)
      click_button("Show Dialog")
      fill_in "input", with: "a"
      assert_selector "#list [role='option']", count: 18
      find("#input").evaluate_script("this.focus()")
      assert_selector "#list:popover-open"
      all("#list [role='option']").to_a
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
                 rect.top >= anchor.bottom + list.anchorOffset - 1),
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

    def assert_auto_complete_option_in_view(option)
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

      assert in_view, "Active AutoComplete option #{option['id']} is clipped: #{geometry.inspect}"
      assert_operator geometry["documentWidth"], :<=, geometry["viewport"]["width"],
                      "AutoComplete causes horizontal viewport overflow"
      assert_selector "dialog[open]"
    end
  end
end
