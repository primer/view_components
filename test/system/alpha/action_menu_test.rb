# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationActionMenuTest < System::TestCase
    def test_dynamic_labels
      visit_preview(:single_select_with_internal_label)
      assert_selector("action-menu button[aria-controls]", text: "Menu: Quote reply")

      find("action-menu button[aria-controls]").click
      find("action-menu ul li:first-child").click

      assert_selector("action-menu button[aria-controls]", text: "Menu: Copy link")

      find("action-menu button[aria-controls]").click
      find("action-menu ul li:first-child").click

      assert_selector("action-menu button[aria-controls]", text: "Menu")
    end

    def test_anchor_align
      visit_preview(:align_end)

      find("action-menu button[aria-controls]").click

      assert_selector("anchored-position[align=end]")
    end

    def test_action_onclick
      visit_preview(:with_actions)

      find("action-menu button[aria-controls]").click

      accept_alert do
        find("action-menu ul li:first-child").click
      end
    end

    def test_action_keydown
      visit_preview(:with_actions)

      page.evaluate_script(<<~JS)
        document.querySelector('action-menu button[aria-controls]').focus()
      JS

      accept_alert do
        # open menu, "click" on first item
        page.driver.browser.keyboard.type(:enter, :enter)
      end
    end

    def test_action_anchor
      visit_preview(:with_actions)

      find("action-menu button[aria-controls]").click
      find("action-menu ul li:nth-child(2)").click

      assert_selector ".action-menu-landing-page", text: "Hello world!"
    end

    def test_action_anchor_keydown
      visit_preview(:with_actions)

      page.evaluate_script(<<~JS)
        document.querySelector('action-menu button[aria-controls]').focus()
      JS

      # open menu, arrow down to second item, "click" second item
      page.driver.browser.keyboard.type(:enter, :down, :enter)

      assert_selector ".action-menu-landing-page", text: "Hello world!"
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
    end

    def read_clipboard
      page.evaluate_async_script(<<~JS)
        const [done] = arguments;
        navigator.clipboard.readText().then(done).catch((e) => done(e));
      JS
    end

    def test_action_clipboard_copy
      visit_preview(:with_actions)

      stub_clipboard!

      find("action-menu button[aria-controls]").click
      find("action-menu ul li:nth-child(3)").click

      assert_equal read_clipboard, "Text to copy"
    end

    def test_action_clipboard_copy_keydown
      visit_preview(:with_actions)

      stub_clipboard!

      page.evaluate_script(<<~JS)
        document.querySelector('action-menu button[aria-controls]').focus()
      JS

      # open menu, arrow down to third item, "click" third item
      page.driver.browser.keyboard.type(:enter, :down, :down, :enter)

      assert_equal read_clipboard, "Text to copy"
    end

    def test_first_item_is_focused_on_invoker_keydown
      visit_preview(:with_actions)

      page.evaluate_script(<<~JS)
        document.querySelector('action-menu button[aria-controls]').focus()
      JS

      # open menu
      page.driver.browser.keyboard.type(:enter)

      assert_equal page.evaluate_script("document.activeElement").text, "Alert"
    end
  end
end
