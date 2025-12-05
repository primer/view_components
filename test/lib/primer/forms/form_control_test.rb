# frozen_string_literal: true

require "lib/test_helper"
require_relative "models/deep_thought"

class Primer::Forms::FormControlTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_supports_model_errors
    model = DeepThought.new(41)
    model.valid? # perform validations

    render_in_view_context do
      primer_form_with(url: "/foo", model: model) do |f|
        render_inline_form(f) do |test_form|
          test_form.text_field(name: :ultimate_answer, label: "Ultimate answer")
        end
      end
    end

    # the input field is marked as invalid
    assert_selector("input[name=deep_thought\\[ultimate_answer\\]][invalid][aria-invalid]")
    # there are validation-related elements
    assert_selector(".FormControl-inlineValidation", visible: :visible)
    # the validation elements don't have the data attributes that primer-text-field needs
    refute_selector("[data-target='primer-text-field.validationElement']", visible: :all)
    refute_selector("[data-target='primer-text-field.validationMessageElement']", visible: :all)
  end

  def test_auto_check_generates_validation_elements
    model = DeepThought.new(42)

    render_in_view_context do
      primer_form_with(url: "/foo", model: model) do |f|
        render_inline_form(f) do |test_form|
          test_form.text_field(name: :ultimate_answer, label: "Ultimate answer", auto_check_src: "/foo")
        end
      end
    end

    # there are validation-related elements, but they're hidden
    assert_selector(".FormControl-inlineValidation", visible: false)
  end

  def test_labels_use_custom_ids_when_provided
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |test_form|
          test_form.text_field(name: :foobar, id: "bazboo", label: "Foos and bars y'all")
        end
      end
    end

    assert_selector "input[id=bazboo]"
    assert_selector "label[for=bazboo]"
  end

  def test_character_limit_generates_aria_live_region
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |test_form|
          test_form.text_field(name: :username, label: "Username", character_limit: 50)
        end
      end
    end

    # Aria-live region exists and is configured correctly
    assert_selector "span.sr-only[aria-live='polite']" do |element|
      assert element["id"].start_with?("username-character-count-sr-")
      # Should be empty initially (populated by JS)
      assert_equal "", element.text.strip
    end

    assert_selector "span.FormControl-caption[data-max-length='50']", text: "50 characters remaining."
  end

  def test_character_limit_works_with_text_area
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |test_form|
          test_form.text_area(name: :bio, label: "Bio", character_limit: 200)
        end
      end
    end

    # Wrapped in primer-text-area custom element
    assert_selector "primer-text-area"

    # Character limit elements present
    assert_selector "span.FormControl-caption[data-max-length='200']"
    assert_selector "span.sr-only[aria-live='polite']"
  end

  def test_character_limit_with_caption_shows_both
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |test_form|
          test_form.text_field(name: :title, label: "Title", caption: "Keep it short and descriptive", character_limit: 100)
        end
      end
    end

    # Both caption text and character limit are present
    assert_selector "span.FormControl-caption", text: "Keep it short and descriptive"
    assert_selector "span.FormControl-caption[data-max-length='100']", text: "100 characters remaining."
  end
end
