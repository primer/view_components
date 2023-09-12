# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::CheckboxGroupInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_hidden_checkbox_group
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |check_form|
          check_form.check_box_group(label: "Foobar", hidden: true) do |check_group|
            check_group.check_box(name: :foo, label: "Foo")
          end
        end
      end
    end

    assert_selector "fieldset", visible: :hidden
    assert_selector ".FormControl-checkbox-wrap", visible: :hidden
  end

  def test_disabled_checkbox_group_disables_constituent_checkboxes
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |check_form|
          check_form.check_box_group(label: "Foobar", disabled: true) do |check_group|
            check_group.check_box(name: :foo, label: "Foo")
          end
        end
      end
    end

    assert_selector ".FormControl-checkbox-wrap input[disabled]"
  end

  def test_checkbox_can_be_individually_disabled_in_group
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |check_form|
          check_form.check_box_group(label: "Foobar") do |check_group|
            check_group.check_box(name: :foo, label: "Foo", disabled: true)
          end
        end
      end
    end

    assert_selector ".FormControl-checkbox-wrap input[disabled]"
  end
end
