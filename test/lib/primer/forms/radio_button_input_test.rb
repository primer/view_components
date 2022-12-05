# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::RadioButtonInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class HiddenRadioButtonForm < ApplicationForm
    form do |radio_form|
      radio_form.radio_button_group(name: :foos, label: "Foos") do |radio_group|
        radio_group.radio_button(name: :foo, label: "Foo", value: "foo", hidden: true)
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
    assert_selector ".FormControl-radio-wrap", visible: false
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

    assert_selector "fieldset", visible: false
    assert_selector ".FormControl-radio-wrap", visible: false
  end
end
