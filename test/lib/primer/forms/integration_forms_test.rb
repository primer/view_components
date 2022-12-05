# frozen_string_literal: true

require "system/test_case"

module Forms
  class IntegrationFormsTest < System::TestCase
    def test_activate_field
      visit_preview(:multi_input_form)

      assert_selector "select[data-name=states]"
      refute_selector "select[data-name=provinces]"

      evaluate_script(<<~JS)
        document.querySelector("primer-multi-input").activateField("provinces")
      JS

      assert_selector "select[data-name=provinces]"
      refute_selector "select[data-name=states]"
    end
  end
end
