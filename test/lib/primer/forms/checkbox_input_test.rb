# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::CheckboxInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_array_checkboxes_require_values
    error = assert_raises(ArgumentError) do
      render_in_view_context do
        primer_form_with(url: "/foo") do |f|
          render_inline_form(f) do |check_form|
            check_form.check_box(name: :alpha, label: "Alpha", scheme: :array)
          end
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

  def test_hidden_checkbox
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |check_form|
          check_form.check_box(name: :foo, label: "Foo", hidden: true) do |foo_check|
            foo_check.nested_form do |builder|
              NestedForm.new(builder)
            end
          end
        end
      end
    end

    assert_selector "input[name=foo]", visible: :hidden
    assert_selector "input[name=bar]", visible: :hidden
  end

  def test_nested_form_can_be_hidden_independently
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |check_form|
          check_form.check_box(name: :foo, label: "Foo") do |foo_check|
            foo_check.nested_form(hidden: true) do |builder|
              NestedForm.new(builder)
            end
          end
        end
      end
    end

    assert_selector "input[name=foo]"
    assert_selector "input[name=bar]", visible: :hidden
  end

  def test_preserves_brackets_in_generated_ids
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |check_form|
          check_form.check_box(
            name: "permissions[3]",
            label: "Foo",
            value: "bar",
            scheme: :array
          )
        end
      end
    end

    # The ID should preserve brackets from the name
    assert_selector "input[id='permissions[3]_bar']"
    assert_selector "label[for='permissions[3]_bar']"
  end

  def test_preserves_brackets_in_generated_ids_with_boolean_scheme
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |check_form|
          check_form.check_box(
            name: "user[settings][email]",
            label: "Email notifications",
            value: "1"
          )
        end
      end
    end

    # The ID should preserve brackets from the name
    assert_selector "input[id='user[settings][email]_1']"
    assert_selector "label[for='user[settings][email]_1']"
  end
end
