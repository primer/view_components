# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationActionMenuTest < System::TestCase
    def test_dynamic_labels
      visit_preview(:single_select_with_internal_label)
      assert_selector("action-menu button[aria-controls]", text: "Menu:\nQuote reply")

      find("action-menu button[aria-controls]").click
      find("action-menu ul li:first-child").click

      assert_selector("action-menu button[aria-controls]", text: "Menu:\nCopy link")

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

    def test_action_anchor
      visit_preview(:with_actions)

      find("action-menu button[aria-controls]").click
      find("action-menu ul li:nth-child(2)").click

      assert_selector ".action-menu-landing-page", text: "Hello world!"
    end

    def test_action_clipboard_copy
      visit_preview(:with_actions)

      # Stub out the clipboard b/c configuring Cuprite with the right permissions stumped
      # the hell out of me and ChatGPT.
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

      find("action-menu button[aria-controls]").click
      find("action-menu ul li:nth-child(3)").click

      clipboard_text = page.evaluate_async_script(<<~JS)
        const [done] = arguments;
        navigator.clipboard.readText().then(done).catch((e) => done(e));
      JS

      assert_equal clipboard_text, "Text to copy"
    end
  end
end
