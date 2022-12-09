# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::CheckboxInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class BadCheckboxesForm < ApplicationForm
    form do |check_form|
      check_form.check_box(name: :alpha, label: "Alpha", scheme: :array)
    end
  end

  def test_array_checkboxes_require_values
    error = assert_raises(ArgumentError) do
      render_in_view_context do
        primer_form_with(url: "/foo") do |f|
          render(BadCheckboxesForm.new(f))
        end
      end
    end

    assert_includes error.message, "Check box needs an explicit value if scheme is array"
  end

  class NestedForm < ApplicationForm
    form do |nested_form|
      nested_form.text_field(
        name: :bar,
        label: "Bar"
      )
    end
  end

  class HiddenCheckboxForm < ApplicationForm
    form do |check_form|
      check_form.check_box(name: :foo, label: "Foo", hidden: true) do |foo_check|
        foo_check.nested_form do |builder|
          NestedForm.new(builder)
        end
      end
    end
  end

  def test_hidden_checkbox
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render(HiddenCheckboxForm.new(f))
      end
    end

    assert_selector "input[name=foo]", visible: :hidden
    assert_selector "input[name=bar]", visible: :hidden
  end

  class CheckboxWithHiddenNestedForm < ApplicationForm
    form do |check_form|
      check_form.check_box(name: :foo, label: "Foo") do |foo_check|
        foo_check.nested_form(hidden: true) do |builder|
          NestedForm.new(builder)
        end
      end
    end
  end

  def test_nested_form_can_be_hidden_independently
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render(CheckboxWithHiddenNestedForm.new(f))
      end
    end

    assert_selector "input[name=foo]"
    assert_selector "input[name=bar]", visible: :hidden
  end
end
