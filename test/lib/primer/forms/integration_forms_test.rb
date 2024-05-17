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
      assert_selector(".FormControl-inlineValidation", text: "Something went wrong.")

      find("#success-toggle").click
      wait_for_toggle_switch_spinner

      refute_selector("#success-toggle [data-target='toggle-switch.errorIcon']")
    end

    def test_action_menu_form_input
      visit_preview(:action_menu_form, route_format: :json)

      click_on("Select...")
      click_on("Lopez Island")
      click_on("Submit")

      result = JSON.parse(page.text)
      assert_equal result.dig("other_params", "city"), "lopez_island"
    end

    def test_autocomplete_form_input
      visit_preview(:auto_complete_form)

      # type "app" into the autocomplete field
      fruit_field = find("#fruit")
      fruit_field.fill_in(with: "app")

      # click on the resulting "Apples" list item
      find(".ActionListItem-label", text: "Apples").click

      # assert autocomplete field now contains the text from the list item, "Apples"
      assert fruit_field.value == "Apples"
    end

    private

    def wait_for_toggle_switch_spinner
      refute_selector("[data-target='toggle-switch.loadingSpinner']")
    end
  end
end
