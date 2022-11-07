# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationBannerTest < System::TestCase
    def test_dismiss_button
      visit_preview(:playground, dismissible: true, reappear: false)
      assert_selector(".Banner")

      find(".Banner-close button").click

      refute_selector(".Banner")
    end
  end
end
