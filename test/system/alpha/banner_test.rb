# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationBannerTest < System::TestCase
    include Primer::JsTestHelpers

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

    def test_dismiss_fires_event
      visit_preview(:playground, dismiss_scheme: :hide)

      evaluate_multiline_script(<<~JS)
        window.bannerDismissed = false

        document.querySelector('x-banner').addEventListener('dismiss', () => {
          window.bannerDismissed = true
        })
      JS

      find(".Banner-close button").click

      assert page.evaluate_script("window.bannerDismissed")
    end
  end
end
