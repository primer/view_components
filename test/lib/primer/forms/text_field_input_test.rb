# frozen_string_literal: true

require "lib/test_helper"
require_relative "models/deep_thought"

class Primer::Forms::TextFieldInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class HiddenTextFieldForm < ApplicationForm
    form do |text_field_form|
      text_field_form.text_field(name: :foo, label: "Foo", hidden: true)
    end
  end

  def test_hidden_text_field
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render(HiddenTextFieldForm.new(f))
      end
    end

    assert_selector "input[type=text]#foo", visible: :hidden
  end

  def test_no_error_markup
    model = DeepThought.new(41)
    model.valid? # populate validation error messages

    render_in_view_context do
      primer_form_with(model: model, url: "/foo") do |f|
        render(SingleTextFieldForm.new(f))
      end
    end

    refute_selector ".field_with_errors", visible: :all
  end
end
