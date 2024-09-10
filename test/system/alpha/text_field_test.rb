# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationTextFieldTest < System::TestCase
    include Primer::JsTestHelpers

    def test_clear_button
      visit_preview(:show_clear_button)

      find("input[type=text]").fill_in(with: "foobar")
      assert_equal find("input[type=text]").value, "foobar"

      evaluate_multiline_script(<<~JS)
        window.inputTriggered = false

        document.querySelector('input[type=text]').addEventListener('input', (_event) => {
          window.inputTriggered = true
        })
      JS

      refute page.evaluate_script("window.inputTriggered")

      find("button").click
      assert_equal find("input[type=text]").value, ""

      assert page.evaluate_script("window.inputTriggered")
    end

    def test_auto_check_error
      visit_preview(:with_auto_check_error)

      assert_selector ".FormControl-inlineValidation", visible: :hidden, text: ""

      find("input[type=text]").fill_in(with: "foobar")

      assert_selector ".FormControl-inlineValidation", text: "The name foobar is already taken."
      assert_selector ".FormControl-inlineValidation--visual .octicon-alert-fill"
      refute_selector ".FormControl-inlineValidation--visual .octicon-check-circle-fill"
    end

    def test_auto_check_accepted
      visit_preview(:with_auto_check_accepted)

      assert_selector ".FormControl-inlineValidation", visible: :hidden, text: ""

      find("input[type=text]").fill_in(with: "foobar")

      assert_selector ".FormControl-inlineValidation.FormControl-inlineValidation--success" do |message|
        assert_match "The name foobar is available.", message.text
      end
      refute_selector ".FormControl-inlineValidation--visual .octicon-alert-fill"
      assert_selector ".FormControl-inlineValidation--visual .octicon-check-circle-fill"
    end

    def test_auto_check_ok
      visit_preview(:with_auto_check_ok)

      assert_selector ".FormControl-inlineValidation", visible: :hidden, text: ""

      find("input[type=text]").fill_in(with: "foobar")

      refute_selector ".FormControl-inlineValidation"
      refute_selector ".FormControl-inlineValidation--visual .octicon-alert-fill"
      refute_selector ".FormControl-inlineValidation--visual .octicon-check-circle-fill"
    end

    def test_custom_data_target
      visit_preview(:with_data_target)

      assert_selector "input[data-target*='primer-text-field.inputElement']"
      assert_selector "input[data-target*='custom-component.inputElement']"
    end

    def test_show_and_hide_leading_spinner
      visit_preview(:playground, leading_spinner: true)

      evaluate_multiline_script(<<~JS)
        const textField = document.querySelector('primer-text-field')
        textField.showLeadingSpinner()
      JS

      assert_selector "[data-target='primer-text-field.leadingSpinner']"
      refute_selector "[data-target='primer-text-field.leadingVisual']"

      evaluate_multiline_script(<<~JS)
        const textField = document.querySelector('primer-text-field')
        textField.hideLeadingSpinner()
      JS

      assert_selector "[data-target='primer-text-field.leadingVisual']"
      refute_selector "[data-target='primer-text-field.leadingSpinner']"
    end

    def test_shows_and_hides_screenreader_text
      visit_preview(:playground, leading_spinner: true)

      evaluate_multiline_script(<<~JS)
        const textField = document.querySelector('primer-text-field')
        textField.showLeadingSpinner()
      JS

      assert_selector "[data-target='primer-text-field.leadingSpinner'] .sr-only", text: "Loading"

      evaluate_multiline_script(<<~JS)
        const textField = document.querySelector('primer-text-field')
        textField.hideLeadingSpinner()
      JS

      refute_selector "[data-target='primer-text-field.leadingSpinner'] .sr-only"
    end
  end
end
