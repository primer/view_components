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
end
