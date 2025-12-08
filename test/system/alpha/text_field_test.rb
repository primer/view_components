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

      # tab away from input to trigger input validation
      find("body").send_keys(:tab)

      assert_selector ".FormControl-inlineValidation", text: "The name foobar is already taken."
      assert_selector ".FormControl-inlineValidation--visual .octicon-alert-fill"
      refute_selector ".FormControl-inlineValidation--visual .octicon-check-circle-fill"
    end

    def test_auto_check_accepted
      visit_preview(:with_auto_check_accepted)

      assert_selector ".FormControl-inlineValidation", visible: :hidden, text: ""

      find("input[type=text]").fill_in(with: "foobar")

      # tab away from input to trigger input validation
      find("body").send_keys(:tab)

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

    def test_character_limit_updates_on_input
      visit_preview(:with_character_limit)

      assert_selector "span.FormControl-caption[data-max-length='10']", text: "10 characters remaining."
      assert_selector "div.FormControl-inlineValidation[data-target='primer-text-field.characterLimitValidationElement']", visible: :hidden

      input = find("input[type=text][data-target*='primer-text-field.inputElement']")
      input.fill_in(with: "Hello")

      sleep 0.2

      assert_selector "span.FormControl-caption[data-max-length='10']", text: "5 characters remaining."
      assert_selector "div.FormControl-inlineValidation[data-target='primer-text-field.characterLimitValidationElement']", visible: :hidden
    end

    def test_character_limit_shows_validation_when_exceeded
      visit_preview(:with_character_limit)

      input = find("input[type=text][data-target*='primer-text-field.inputElement']")

      input.fill_in(with: "Hello World!") # 12 characters

      sleep 0.3

      assert_selector "span.FormControl-caption[data-max-length='10']", text: "2 characters over."
      assert_selector "div.FormControl-inlineValidation[data-target='primer-text-field.characterLimitValidationElement']", visible: :visible do |element|
        assert_includes element.text, "You've exceeded the character limit"
      end
      assert_selector "input[invalid='true'][aria-invalid='true']"

      validation_element = find("div.FormControl-inlineValidation[data-target='primer-text-field.characterLimitValidationElement']")
      validation_id = validation_element["id"]

      input_aria_describedby = input["aria-describedby"]
      assert_includes input_aria_describedby, validation_id, "input aria-describedby should include validation element ID"
    end

    def test_character_limit_clears_validation_when_back_under_limit
      visit_preview(:with_character_limit)

      input = find("input[type=text][data-target*='primer-text-field.inputElement']")

      input.fill_in(with: "Hello World!") # 12 characters
      sleep 0.3

      assert_selector "div.FormControl-inlineValidation[data-target='primer-text-field.characterLimitValidationElement']", visible: :visible
      assert_selector "input[invalid='true'][aria-invalid='true']"

      input.fill_in(with: "Hello") # 5 characters
      sleep 0.3

      assert_selector "span.FormControl-caption[data-max-length='10']", text: "5 characters remaining."
      assert_selector "div.FormControl-inlineValidation[data-target='primer-text-field.characterLimitValidationElement']", visible: :hidden

      refute_selector "input[invalid='true']"
      refute_selector "input[aria-invalid='true']"
    end

    def test_character_limit_screen_reader_text_updates
      visit_preview(:with_character_limit)

      input = find("input[type=text][data-target*='primer-text-field.inputElement']")

      sr_element = find("span.sr-only[aria-live='polite']")

      input.fill_in(with: "Test")

      # Wait for debounced update (500ms + buffer)
      sleep 0.6

      assert_equal "6 characters remaining.", sr_element.text

      input.fill_in(with: "Hello World!") # 12 characters
      sleep 0.6

      assert_equal "2 characters over.", sr_element.text
    end

    def test_character_limit_singular_vs_plural
      visit_preview(:with_character_limit)

      input = find("input[type=text][data-target*='primer-text-field.inputElement']")

      input.fill_in(with: "123456789") # 9 characters, limit is 10
      sleep 0.3

      assert_selector "span.FormControl-caption[data-max-length='10']", text: "1 character remaining."

      input.fill_in(with: "12345678901") # 11 characters
      sleep 0.3

      assert_selector "span.FormControl-caption[data-max-length='10']", text: "1 character over."
    end
  end
end
