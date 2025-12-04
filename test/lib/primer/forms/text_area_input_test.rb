# frozen_string_literal: true

require "lib/test_helper"
require_relative "models/deep_thought"

class Primer::Forms::TextAreaInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_hidden_text_area
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |text_area_form|
          text_area_form.text_area(name: :foo, label: "Foo", hidden: true)
        end
      end
    end

    assert_selector "textarea#foo", visible: :hidden
  end

  def test_no_error_markup
    model = DeepThought.new(41)
    model.valid? # populate validation error messages

    render_in_view_context do
      primer_form_with(model: model, url: "/foo") do |f|
        render_inline_form(f) do |text_area_form|
          text_area_form.text_area(name: :ultimate_answer, label: "Ultimate answer")
        end
      end
    end

    refute_selector ".field_with_errors", visible: :all
  end

  def test_renders_character_limit_form
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render(TextAreaWithCharacterLimitForm.new(f))
      end
    end

    assert_selector "primer-text-area"
    assert_selector "textarea[name=bio]"
    assert_selector "div.FormControl-caption--characterLimit[data-max-length='100']"
  end

  def test_character_limit
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |text_area_form|
          text_area_form.text_area(name: :bio, label: "Bio", character_limit: 100)
        end
      end
    end

    assert_selector "primer-text-area"
    assert_selector "div.FormControl-caption--characterLimit[data-target='primer-text-area.characterLimitElement'][data-max-length='100']", text: "100 characters remaining."
    assert_selector "textarea[data-target='primer-text-area.inputElement']"

    # Check for aria-live region
    assert_selector "span.sr-only[aria-live='polite']" do |span|
      assert span["id"].start_with?("bio-character-count-sr-")
    end
  end

  def test_character_limit_rejects_zero
    error = assert_raises(ArgumentError) do
      render_in_view_context do
        primer_form_with(url: "/foo") do |f|
          render_inline_form(f) do |text_area_form|
            text_area_form.text_area(name: :bio, label: "Bio", character_limit: 0)
          end
        end
      end
    end

    assert_includes error.message, "character_limit must be a positive integer"
  end

  def test_character_limit_rejects_negative
    error = assert_raises(ArgumentError) do
      render_in_view_context do
        primer_form_with(url: "/foo") do |f|
          render_inline_form(f) do |text_area_form|
            text_area_form.text_area(name: :bio, label: "Bio", character_limit: -10)
          end
        end
      end
    end

    assert_includes error.message, "character_limit must be a positive integer"
  end

  def test_character_limit_with_caption
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |text_area_form|
          text_area_form.text_area(name: :bio, label: "Bio", caption: "Tell us about yourself", character_limit: 100)
        end
      end
    end

    assert_selector "div.FormControl-caption--characterLimit", text: "100 characters remaining."
    assert_selector "span.FormControl-caption", text: "Tell us about yourself"
  end
end
