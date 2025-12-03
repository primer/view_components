# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationTextAreaTest < System::TestCase
    include Primer::JsTestHelpers

    def test_character_limit_updates_on_input
      visit_preview(:with_character_limit)

      # Initial state - should show full limit remaining
      assert_selector "div.FormControl-caption--characterLimit[aria-hidden='true']", text: "10 characters remaining."

      # Validation should be hidden initially
      assert_selector "div.FormControl-inlineValidation[data-target='primer-text-area.validationElement']", visible: :hidden

      # Type some text (5 characters)
      textarea = find("textarea[data-target='primer-text-area.inputElement']")
      textarea.fill_in(with: "Hello")

      # Wait for JS to update
      sleep 0.2

      # Character count should update to show 5 remaining
      assert_selector "div.FormControl-caption--characterLimit[aria-hidden='true']", text: "5 characters remaining."

      # Validation should still be hidden
      assert_selector "div.FormControl-inlineValidation[data-target='primer-text-area.validationElement']", visible: :hidden
    end

    def test_character_limit_shows_validation_when_exceeded
      visit_preview(:with_character_limit)

      textarea = find("textarea[data-target='primer-text-area.inputElement']")

      # Type text that exceeds the 10 character limit
      textarea.fill_in(with: "Hello World!") # 12 characters

      # Wait for JS to update (includes debounce time)
      sleep 0.3

      # Character count should show "over" message
      assert_selector "div.FormControl-caption--characterLimit[aria-hidden='true']", text: "2 characters over."

      # Validation error should be visible
      assert_selector "div.FormControl-inlineValidation[data-target='primer-text-area.validationElement']", visible: :visible do |element|
        assert_includes element.text, "You've exceeded the character limit"
      end

      # Input should be marked as invalid
      assert_selector "textarea[invalid='true'][aria-invalid='true']"

      # Check that aria-describedby includes the validation ID
      validation_element = find("div.FormControl-inlineValidation[data-target='primer-text-area.validationElement']")
      validation_id = validation_element["id"]
      
      textarea_aria_describedby = textarea["aria-describedby"]
      assert_includes textarea_aria_describedby, validation_id, "textarea aria-describedby should include validation element ID"
    end

    def test_character_limit_clears_validation_when_back_under_limit
      visit_preview(:with_character_limit)

      textarea = find("textarea[data-target='primer-text-area.inputElement']")
      
      # First, exceed the limit
      textarea.fill_in(with: "Hello World!") # 12 characters
      sleep 0.3

      # Verify error is shown
      assert_selector "div.FormControl-inlineValidation[data-target='primer-text-area.validationElement']", visible: :visible
      assert_selector "textarea[invalid='true'][aria-invalid='true']"

      # Now delete characters to get back under the limit
      textarea.fill_in(with: "Hello") # 5 characters
      sleep 0.3

      # Character count should update
      assert_selector "div.FormControl-caption--characterLimit[aria-hidden='true']", text: "5 characters remaining."

      # Validation should be hidden again
      assert_selector "div.FormControl-inlineValidation[data-target='primer-text-area.validationElement']", visible: :hidden

      # Input should not be marked as invalid
      refute_selector "textarea[invalid='true']"
      refute_selector "textarea[aria-invalid='true']"
    end

    def test_character_limit_screen_reader_text_updates
      visit_preview(:with_character_limit)

      textarea = find("textarea[data-target='primer-text-area.inputElement']")
      
      # Get the aria-live region
      sr_element = find("span.sr-only[aria-live='polite']")
      
      # Initially should be empty (or match initial state)
      initial_text = sr_element.text

      # Type some text
      textarea.fill_in(with: "Test")
      
      # Wait for debounced update (150ms + buffer)
      sleep 0.3

      # Screen reader text should be updated
      assert_equal "6 characters remaining.", sr_element.text

      # Type more to exceed limit
      textarea.fill_in(with: "Hello World!") # 12 characters
      sleep 0.3

      # Screen reader should announce over limit
      assert_equal "2 characters over.", sr_element.text
    end

    def test_character_limit_singular_vs_plural
      visit_preview(:with_character_limit)

      textarea = find("textarea[data-target='primer-text-area.inputElement']")
      
      # Type to leave exactly 1 character remaining
      textarea.fill_in(with: "123456789") # 9 characters, limit is 10
      sleep 0.3

      # Should use singular "character"
      assert_selector "div.FormControl-caption--characterLimit[aria-hidden='true']", text: "1 character remaining."

      # Type one more to exceed by exactly 1
      textarea.fill_in(with: "12345678901") # 11 characters
      sleep 0.3

      # Should use singular "character" for over
      assert_selector "div.FormControl-caption--characterLimit[aria-hidden='true']", text: "1 character over."
    end
  end
end
