# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationBannerTest < System::TestCase
    def test_dismiss_button_remove
      visit_preview(:playground, dismiss_scheme: :remove)
      assert_selector(".Banner")

      find(".Banner-close button").click

      refute_selector(".Banner", visible: :all)
    end

    def test_dismiss_button_hide
      visit_preview(:playground, dismiss_scheme: :hide)
      assert_selector(".Banner")

      find(".Banner-close button").click

      assert_selector(".Banner", visible: :hidden)
    end

    def test_announce_on_show
      visit_preview(:announce_on_show)

      assert_equal page.evaluate_script("document.querySelector('live-region').shadowRoot.querySelector('[aria-live=\"polite\"]').innerText"), ""

      find("#show-banner").click

      assert_equal page.evaluate_script("document.querySelector('live-region').shadowRoot.querySelector('[aria-live=\"polite\"]').innerText.trim()"), "Hello."
    end

    def test_announce_on_show_when_hidden_wrapper_is_shown
      visit_preview(:announce_on_show_with_hidden_wrapper)

      assert_selector("#wrapper", visible: :hidden)
      assert_equal page.evaluate_script("document.querySelector('live-region').shadowRoot.querySelector('[aria-live=\"polite\"]').innerText"), ""

      find("#toggle-wrapper").click

      assert_selector("#wrapper", visible: :visible)
      assert_equal page.evaluate_script("document.querySelector('live-region').shadowRoot.querySelector('[aria-live=\"polite\"]').innerText.trim()"), "Hello."
    end
  end
end
