# frozen_string_literal: true

require "lib/test_helper"
require_relative "models/deep_thought"

class Primer::Forms::TextFieldInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_hidden_text_field
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |text_field_form|
          text_field_form.text_field(name: :foo, label: "Foo", hidden: true)
        end
      end
    end

    assert_selector "input[type=text]#foo", visible: :hidden
  end

  def test_only_primer_error_markup
    model = DeepThought.new(41)
    model.valid? # populate validation error messages

    render_in_view_context do
      primer_form_with(model: model, url: "/foo") do |f|
        render(SingleTextFieldForm.new(f))
      end
    end

    # primer error markup
    assert_selector ".FormControl-inlineValidation", text: "Ultimate answer must be greater than 41"

    # no rails error markup
    refute_selector ".field_with_errors", visible: :all
  end

  def test_leading_visual
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |text_field_form|
          text_field_form.text_field(name: :foo, label: "Foo", leading_visual: { icon: :search })
        end
      end
    end

    assert_selector "svg.octicon.octicon-search.FormControl-input-leadingVisual"
  end

  def test_enforces_leading_visual_when_spinner_requested
    error = assert_raises(ArgumentError) do
      render_in_view_context do
        primer_form_with(url: "/foo") do |f|
          render_inline_form(f) do |text_field_form|
            text_field_form.text_field(name: :foo, label: "Foo", leading_spinner: true)
          end
        end
      end
    end

    assert_includes error.message, "must also specify a leading visual"
  end

  def test_renders_character_limit_form
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render(TextFieldWithCharacterLimitForm.new(f))
      end
    end

    assert_selector "primer-text-field"
    assert_selector "span.FormControl-caption[data-max-length='20']", text: "20 characters remaining."
    assert_selector "input[type=text][data-target*='primer-text-field.inputElement']"
    assert_selector "span.sr-only[aria-live='polite']" do |span|
      assert span["id"].start_with?("username-character-count-sr-")
    end
  end

  def test_character_limit_rejects_zero
    error = assert_raises(ArgumentError) do
      render_in_view_context do
        primer_form_with(url: "/foo") do |f|
          render_inline_form(f) do |text_field_form|
            text_field_form.text_field(name: :username, label: "Username", character_limit: 0)
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
          render_inline_form(f) do |text_field_form|
            text_field_form.text_field(name: :username, label: "Username", character_limit: -5)
          end
        end
      end
    end

    assert_includes error.message, "character_limit must be a positive integer"
  end

  def test_character_limit_with_caption
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |text_field_form|
          text_field_form.text_field(name: :username, label: "Username", caption: "Choose a unique username", character_limit: 20)
        end
      end
    end

    assert_selector "span.FormControl-caption[data-max-length='20']", text: "20 characters remaining."
    assert_selector "span.FormControl-caption", text: "Choose a unique username"
  end
end
