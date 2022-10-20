# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::MultiInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class MultipleFieldsVisibleForm < ApplicationForm
    form do |test_form|
      test_form.multi(name: :foo, label: "Thing") do |multi|
        multi.text_field(label: "Text field")
        multi.text_field(label: "Text field")
      end
    end
  end

  class FieldsWithDifferentNamesForm < ApplicationForm
    form do |test_form|
      test_form.multi(name: :foo, label: "Thing") do |multi|
        multi.text_field(name: :foo, label: "Text field")
        multi.text_field(name: :bar, label: "Text field", hidden: true)
      end
    end
  end

  def test_only_two_inputs_visible
    error = assert_raises(ArgumentError) do
      render_in_view_context do
        primer_form_with(url: "/foo") do |f|
          render(MultipleFieldsVisibleForm.new(f))
        end
      end
    end

    assert_includes error.message, "can be visible"
  end

  def test_inputs_must_have_same_name
    error = assert_raises(ArgumentError) do
      render_in_view_context do
        primer_form_with(url: "/foo") do |f|
          render(FieldsWithDifferentNamesForm.new(f))
        end
      end
    end

    assert_includes error.message, "must all have the same name"
  end
end
