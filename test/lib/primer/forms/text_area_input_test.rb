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
end
