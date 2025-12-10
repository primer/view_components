# frozen_string_literal: true

require "system/test_case"

module Alpha
  class IntegrationTextAreaTest < System::TestCase
    include Primer::JsTestHelpers

    def test_character_limit_updates_on_input
      visit_preview(:with_character_limit)

      assert_selector "span.FormControl-caption[data-max-length='10'] .FormControl-caption-text", text: "10 characters remaining"
      refute_selector "span.FormControl-caption .FormControl-caption-icon[hidden]", visible: :all

      textarea = find("textarea[data-target='primer-text-area.inputElement']")
      textarea.fill_in(with: "Hello")

      sleep 0.3

      assert_selector "span.FormControl-caption[data-max-length='10'] .FormControl-caption-text", text: "5 characters remaining"
      refute_selector "span.FormControl-caption .FormControl-caption-icon[hidden]", visible: :all
    end

    def test_character_limit_shows_validation_when_exceeded
      visit_preview(:with_character_limit)

      textarea = find("textarea[data-target='primer-text-area.inputElement']")
      textarea.fill_in(with: "Hello World!") # 12 characters

      sleep 0.3

      assert_selector "span.FormControl-caption[data-max-length='10'] .FormControl-caption-text", text: "2 characters over"
      assert_selector "span.FormControl-caption .FormControl-caption-icon:not([hidden])", visible: :visible
      assert_selector "span.FormControl-caption.fgColor-danger"

      assert_selector "textarea[invalid='true'][aria-invalid='true']"
    end

    def test_character_limit_clears_validation_when_back_under_limit
      visit_preview(:with_character_limit)

      textarea = find("textarea[data-target='primer-text-area.inputElement']")
      textarea.fill_in(with: "Hello World!") # 12 characters
      sleep 0.3

      assert_selector "span.FormControl-caption .FormControl-caption-icon:not([hidden])", visible: :visible
      assert_selector "textarea[invalid='true'][aria-invalid='true']"

      textarea.fill_in(with: "Hello") # 5 characters
      sleep 0.3

      assert_selector "span.FormControl-caption[data-max-length='10'] .FormControl-caption-text", text: "5 characters remaining"
      refute_selector "span.FormControl-caption .FormControl-caption-icon[hidden]", visible: :all
      refute_selector "span.FormControl-caption.fgColor-danger"

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

      assert_equal "6 characters remaining", sr_element.text

      textarea.fill_in(with: "Hello World!") # 12 characters
      sleep 0.6

      assert_equal "2 characters over", sr_element.text
    end

    def test_character_limit_singular_vs_plural
      visit_preview(:with_character_limit)

      textarea = find("textarea[data-target='primer-text-area.inputElement']")
      textarea.fill_in(with: "123456789") # 9 characters, limit is 10
      sleep 0.3

      assert_selector "span.FormControl-caption[data-max-length='10'] .FormControl-caption-text", text: "1 character remaining"

      textarea.fill_in(with: "12345678901") # 11 characters
      sleep 0.3

      assert_selector "span.FormControl-caption[data-max-length='10'] .FormControl-caption-text", text: "1 character over"
    end

    def test_character_limit_screen_reader_not_announced_on_load
      visit_preview(:with_character_limit)

      sr_element = find("span.sr-only[aria-live='polite']")
      
      # Screen reader element should be empty on initial load
      assert_equal "", sr_element.text
      
      # Only populated after user input
      textarea = find("textarea[data-target='primer-text-area.inputElement']")
      textarea.fill_in(with: "Test")
      
      sleep 0.6 # Wait for debounced update
      
      assert_equal "6 characters remaining", sr_element.text
    end

    def test_character_limit_icon_visibility
      visit_preview(:with_character_limit)

      # Icon should be hidden initially
      assert_selector "span.FormControl-caption .FormControl-caption-icon[hidden]"
      
      textarea = find("textarea[data-target='primer-text-area.inputElement']")
      
      # Icon should remain hidden when under limit
      textarea.fill_in(with: "Hello")
      sleep 0.3
      assert_selector "span.FormControl-caption .FormControl-caption-icon[hidden]"
      
      # Icon should be visible when over limit
      textarea.fill_in(with: "Hello World!")
      sleep 0.3
      assert_selector "span.FormControl-caption .FormControl-caption-icon:not([hidden])", visible: :visible
      
      # Icon should be hidden again when back under limit
      textarea.fill_in(with: "Hi")
      sleep 0.3
      assert_selector "span.FormControl-caption .FormControl-caption-icon[hidden]"
    end
  end
end
