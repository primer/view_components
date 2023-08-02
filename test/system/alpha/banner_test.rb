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
  end
end
