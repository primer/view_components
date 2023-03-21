# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationTextFieldTest < System::TestCase
    def test_clear_button
      visit_preview(:show_clear_button)

      find("input[type=text]").fill_in(with: "foobar")
      assert_equal find("input[type=text]").value, "foobar"

      find("button").click
      assert_equal find("input[type=text]").value, ""
    end

    def test_auto_check_error
      visit_preview(:with_auto_check_error)

      assert_selector ".FormControl-inlineValidation", visible: :hidden, text: ""

      find("input[type=text]").fill_in(with: "foobar")

      assert_selector ".FormControl-inlineValidation", text: "Error! Error!"
    end

    def test_custom_data_target
      visit_preview(:with_data_target)

      assert_selector "input[data-target*='primer-text-field.inputElement']"
      assert_selector "input[data-target*='custom-component.inputElement']"
    end
  end
end
