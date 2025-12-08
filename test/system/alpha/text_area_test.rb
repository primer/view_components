# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationTextAreaTest < System::TestCase
    include Primer::JsTestHelpers

    def test_character_limit_updates_on_input
      visit_preview(:with_character_limit)

      assert_selector "span.FormControl-caption[data-max-length='10']", text: "10 characters remaining."
      assert_selector "div.FormControl-inlineValidation[data-target='primer-text-area.validationElement']", visible: :hidden

      textarea = find("textarea[data-target='primer-text-area.inputElement']")
      textarea.fill_in(with: "Hello")

      sleep 0.3

      assert_selector "span.FormControl-caption[data-max-length='10']", text: "5 characters remaining."
      assert_selector "div.FormControl-inlineValidation[data-target='primer-text-area.validationElement']", visible: :hidden
    end

    def test_character_limit_shows_validation_when_exceeded
      visit_preview(:with_character_limit)

      textarea = find("textarea[data-target='primer-text-area.inputElement']")
      textarea.fill_in(with: "Hello World!") # 12 characters

      sleep 0.3

      assert_selector "span.FormControl-caption[data-max-length='10']", text: "2 characters over."
      assert_selector "div.FormControl-inlineValidation[data-target='primer-text-area.validationElement']", visible: :visible do |element|
        assert_includes element.text, "You've exceeded the character limit"
      end

      assert_selector "textarea[invalid='true'][aria-invalid='true']"

      validation_element = find("div.FormControl-inlineValidation[data-target='primer-text-area.validationElement']")
      validation_id = validation_element["id"]

      textarea_aria_describedby = textarea["aria-describedby"]
      assert_includes textarea_aria_describedby, validation_id, "textarea aria-describedby should include validation element ID"
    end

    def test_character_limit_clears_validation_when_back_under_limit
      visit_preview(:with_character_limit)

      textarea = find("textarea[data-target='primer-text-area.inputElement']")
      textarea.fill_in(with: "Hello World!") # 12 characters
      sleep 0.3

      assert_selector "div.FormControl-inlineValidation[data-target='primer-text-area.validationElement']", visible: :visible
      assert_selector "textarea[invalid='true'][aria-invalid='true']"

      textarea.fill_in(with: "Hello") # 5 characters
      sleep 0.3

      assert_selector "span.FormControl-caption[data-max-length='10']", text: "5 characters remaining."
      assert_selector "div.FormControl-inlineValidation[data-target='primer-text-area.validationElement']", visible: :hidden

      refute_selector "textarea[invalid='true']"
      refute_selector "textarea[aria-invalid='true']"
    end

    def test_character_limit_screen_reader_text_updates
      visit_preview(:with_character_limit)

      textarea = find("textarea[data-target='primer-text-area.inputElement']")

      sr_element = find("span.sr-only[aria-live='polite']")
      textarea.fill_in(with: "Test")

      # Wait for debounced update (500ms + buffer)
      sleep 0.6

      assert_equal "6 characters remaining.", sr_element.text

      textarea.fill_in(with: "Hello World!") # 12 characters
      sleep 0.6

      assert_equal "2 characters over.", sr_element.text
    end

    def test_character_limit_singular_vs_plural
      visit_preview(:with_character_limit)

      textarea = find("textarea[data-target='primer-text-area.inputElement']")
      textarea.fill_in(with: "123456789") # 9 characters, limit is 10
      sleep 0.3

      assert_selector "span.FormControl-caption[data-max-length='10']", text: "1 character remaining."

      textarea.fill_in(with: "12345678901") # 11 characters
      sleep 0.3

      assert_selector "span.FormControl-caption[data-max-length='10']", text: "1 character over."
    end
  end
end
