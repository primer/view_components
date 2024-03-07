# frozen_string_literal: true

require "lib/test_helper"
require_relative "models/deep_thought"

class Primer::Forms::AutoCompleteInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_hidden_auto_complete
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |auto_complete_form|
          auto_complete_form.auto_complete(name: :foo, label: "Foo", src: "/items", hidden: true)
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
        render_inline_form(f) do |auto_complete_form|
          auto_complete_form.auto_complete(name: :ultimate_answer, label: "Ultimate answer", src: "/items")
        end
      end
    end

    # primer error markup
    assert_selector ".FormControl-inlineValidation", text: "Ultimate answer must be greater than 41"

    # no rails error markup
    refute_selector ".field_with_errors", visible: :all
  end
end
