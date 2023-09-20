# frozen_string_literal: true

require "lib/test_helper"
require_relative "models/deep_thought"

class Primer::Forms::FormHelperTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_includes_activemodel_validation_messages
    model = DeepThought.new(41)
    model.valid? # populate validation error messages

    render_in_view_context do
      primer_form_with(model: model, url: "/foo") do |f|
        render(SingleTextFieldForm.new(f))
      end
    end

    assert_selector ".FormControl" do
      assert_selector ".FormControl-inlineValidation", text: "Ultimate answer must be greater than 41" do
        assert_selector ".octicon-alert-fill"
      end
    end
  end

  def test_names_inputs_correctly_when_rendered_against_an_activemodel
    model = DeepThought.new(42)

    render_in_view_context do
      primer_form_with(model: model, url: "/foo") do |f|
        render(SingleTextFieldForm.new(f))
      end
    end

    text_field = page.find_all("input[type=text]").first
    assert_equal text_field["name"], "deep_thought[ultimate_answer]"
  end

  def test_the_input_is_marked_as_invalid
    model = DeepThought.new(41)
    model.valid? # populate validation error messages

    render_in_view_context do
      primer_form_with(model: model, url: "/foo") do |f|
        render(SingleTextFieldForm.new(f))
      end
    end

    assert_selector("input[name=deep_thought\\[ultimate_answer\\]][invalid][aria-invalid]")
  end

  def test_the_input_is_described_by_the_validation_message
    model = DeepThought.new(41)
    model.valid? # populate validation error messages

    render_in_view_context do
      primer_form_with(model: model, url: "/foo") do |f|
        render(SingleTextFieldForm.new(f))
      end
    end

    validation_id = page.find_all(".FormControl-inlineValidation").first["id"]
    described_by = page.find_all("input[type='text']").first["aria-describedby"]
    assert described_by.split.include?(validation_id)
  end

  def test_primer_fields_for
    model = DeepThought.new(42)

    render_in_view_context do
      primer_fields_for(:deep_thought, model) do |f|
        render(SingleTextFieldForm.new(f))
      end
    end

    refute_selector "form" # does not render a <form> tag
    assert_selector "input[name='deep_thought[ultimate_answer]']"
  end
end
