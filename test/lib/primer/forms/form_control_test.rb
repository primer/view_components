# frozen_string_literal: true

require "lib/test_helper"
require_relative "models/deep_thought"

class Primer::Forms::FormControlTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class PlainTextFieldForm < ApplicationForm
    form do |test_form|
      test_form.text_field(name: :ultimate_answer, label: "Ultimate answer")
    end
  end

  class AutoCheckTextFieldForm < ApplicationForm
    form do |test_form|
      test_form.text_field(name: :ultimate_answer, label: "Ultimate answer", auto_check_src: "/foo")
    end
  end

  def test_plain_has_no_validation_element
    model = DeepThought.new(42)

    render_in_view_context do
      primer_form_with(url: "/foo", model: model) do |f|
        render(PlainTextFieldForm.new(f))
      end
    end

    # there are no validation-related elements
    refute_selector(".FormControl-inlineValidation", visible: :all)
  end

  def test_plain_supports_server_errors
    model = DeepThought.new(41)
    model.valid? # perform validations

    render_in_view_context do
      primer_form_with(url: "/foo", model: model) do |f|
        render(PlainTextFieldForm.new(f))
      end
    end

    # there are validation-related elements
    assert_selector(".FormControl-inlineValidation", visible: :visible)
  end
end
