# frozen_string_literal: true

require "system/test_case"

module Forms
  class IntegrationFormsTest < System::TestCase
    def test_multi_activate_field
      visit_preview(:multi_input_form)

      assert_selector "select[data-name=states]"
      refute_selector "select[data-name=provinces]"

      find("input#country_ca").click

      assert_selector "select[data-name=provinces]"
      refute_selector "select[data-name=states]"
    end

    def test_multi_submit
      visit_preview(:multi_input_form)

      find("input#country_us").click
      find("select[data-name=states]").find(:css, "option[value=WA]").select_option

      click_on("Submit")

      result = JSON.parse(page.text)
      assert result["country"], "US"
      assert result["region"], "WA"

      visit_preview(:multi_input_form)

      find("input#country_ca").click
      find("select[data-name=provinces]").find(:css, "option[value=SK]").select_option

      click_on("Submit")

      result = JSON.parse(page.text)
      assert result["country"], "CA"
      assert result["region"], "SK"
    end
  end
end
