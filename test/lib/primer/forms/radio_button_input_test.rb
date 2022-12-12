# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::RadioButtonInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class NestedForm < ApplicationForm
    form do |nested_form|
      nested_form.text_field(
        name: :bar,
        label: "Bar"
      )
    end
  end

  class HiddenRadioButtonForm < ApplicationForm
    form do |radio_form|
      radio_form.radio_button_group(name: :foos, label: "Foos") do |radio_group|
        radio_group.radio_button(name: :foo, label: "Foo", value: "foo", hidden: true) do |radio_button|
          radio_button.nested_form do |builder|
            NestedForm.new(builder)
          end
        end
      end
    end
  end

  def test_hidden_radio_button
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render(HiddenRadioButtonForm.new(f))
      end
    end

    assert_selector "fieldset"
    assert_selector "input[name=foo]", visible: :hidden
    assert_selector "input[name=bar]", visible: :hidden
  end

  class RadioButtonWithHiddenNestedForm < ApplicationForm
    form do |radio_form|
      radio_form.radio_button_group(name: :foos, label: "Foos") do |radio_group|
        radio_group.radio_button(name: :foo, label: "Foo", value: "foo") do |radio_button|
          radio_button.nested_form(hidden: true) do |builder|
            NestedForm.new(builder)
          end
        end
      end
    end
  end

  def test_nested_form_can_be_hidden_independently
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render(RadioButtonWithHiddenNestedForm.new(f))
      end
    end

    assert_selector "input[name=foo]"
    assert_selector "input[name=bar]", visible: :hidden
  end

  class HiddenRadioButtonGroupForm < ApplicationForm
    form do |radio_form|
      radio_form.radio_button_group(name: :foos, label: "Foos", hidden: true) do |radio_group|
        radio_group.radio_button(name: :foo, label: "Foo", value: "foo")
      end
    end
  end

  def test_hidden_radio_button_group
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render(HiddenRadioButtonGroupForm.new(f))
      end
    end

    assert_selector "fieldset", visible: :hidden
    assert_selector "input[name=foo]", visible: :hidden
  end
end
