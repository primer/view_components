# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::MultiInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class MultipleFieldsVisibleForm < ApplicationForm
    form do |test_form|
      test_form.multi(name: :foo, label: "Thing") do |multi|
        multi.text_field(name: :bar, label: "Text field")
        multi.text_field(name: :baz, label: "Text field")
      end
    end
  end

  class FieldsWithDifferentNamesForm < ApplicationForm
    form do |test_form|
      test_form.multi(name: :foo, label: "Thing") do |multi|
        multi.text_field(name: :bar, label: "Text field")
        multi.text_field(name: :baz, label: "Text field", hidden: true)
      end
    end
  end

  def test_disallows_two_visible_inputs
    error = assert_raises(ArgumentError) do
      render_in_view_context do
        primer_form_with(url: "/foo") do |f|
          render(MultipleFieldsVisibleForm.new(f))
        end
      end
    end

    assert_includes error.message, "can be visible"
  end

  def test_inputs_have_data_name
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render(FieldsWithDifferentNamesForm.new(f))
      end
    end

    assert_selector "input[data-name=bar]"
    assert_selector "input[data-name=baz]", visible: false
  end
end
