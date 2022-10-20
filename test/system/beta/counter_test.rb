# frozen_string_literal: true

require "system/test_case"

module Beta
  class IntegrationCounterTest < System::TestCase
    def test_integration
      visit_preview(:default)

      assert_selector(".Counter", text: "1,000")
    end
  end
end
