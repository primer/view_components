# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::RadioButtonGroupInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_hidden_radio_button_group
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |radio_form|
          radio_form.radio_button_group(name: :foobar, label: "Foobar", hidden: true) do |radio_group|
            radio_group.radio_button(name: :foo, value: "Foo", label: "Foo")
          end
        end
      end
    end

    assert_selector "fieldset", visible: :hidden
    assert_selector ".FormControl-radio-wrap", visible: :hidden
  end

  def test_disabled_radio_group_disables_constituent_radios
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |radio_form|
          radio_form.radio_button_group(name: :foobar, label: "Foobar", disabled: true) do |radio_group|
            radio_group.radio_button(name: :foo, value: "Foo", label: "Foo")
          end
        end
      end
    end

    assert_selector ".FormControl-radio-wrap input[disabled]"
  end

  def test_radio_can_be_individually_disabled_in_group
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |radio_form|
          radio_form.radio_button_group(name: :foobar, label: "Foobar") do |radio_group|
            radio_group.radio_button(name: :foo, value: "Foo", label: "Foo", disabled: true)
          end
        end
      end
    end

    assert_selector ".FormControl-radio-wrap input[disabled]"
  end
end
