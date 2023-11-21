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
      assert_equal result["country"], "CA"
      assert_equal result["region"], "SK"
    end

    def test_toggle_switch_form_errors
      visit_preview(:example_toggle_switch_form)

      find("#error-toggle").click
      wait_for_toggle_switch_spinner

      assert_selector("#error-toggle [data-target='toggle-switch.errorIcon']")
      assert_selector(".FormControl-inlineValidation", text: "Bad CSRF token")

      page.evaluate_script(<<~JAVASCRIPT)
        document
          .querySelector('toggle-switch#error-toggle')
          .setAttribute('csrf', 'let_me_in');
      JAVASCRIPT

      find("#error-toggle").click
      wait_for_toggle_switch_spinner

      refute_selector("#error-toggle [data-target='toggle-switch.errorIcon']")
      refute_selector("#error-toggle", text: "Bad CSRF token")
    end

    def test_action_menu_form_input
      visit_preview(:action_menu_form, route_format: :json)

      click_on("Select...")
      click_on("Lopez Island")
      click_on("Submit")

      result = JSON.parse(page.text)
      assert_equal result.dig("other_params", "city"), "lopez_island"
    end

    private

    def wait_for_toggle_switch_spinner
      refute_selector("[data-target='toggle-switch.loadingSpinner']")
    end
  end
end
