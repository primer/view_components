# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationSelectPanelTest < System::TestCase
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

    ########## TESTS ############

    def test_invoker_opens_panel
      visit_preview(:default)

      refute_selector "select-panel dialog[open]"
      click_on_invoker_button
      assert_selector "select-panel dialog[open]"
    end
  end
end
