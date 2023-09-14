# frozen_string_literal: true

require "lib/test_helper"
require_relative "models/survey"

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

  def test_validations
    survey = Survey.new
    survey.valid? # populate validation messages

    render_in_view_context do
      primer_form_with(model: survey, url: "/surveys") do |f|
        render(RadioButtonGroupForm.new(f))
      end
    end

    # the wrapper should be marked invalid, but not individual check boxes
    assert_selector ".FormControl-radio-group-wrap[invalid=true][aria-invalid=true]"
    refute_selector "input[type=radio][invalid]"

    # should have a validation message
    assert_selector ".FormControl-inlineValidation", text: "Channel can't be blank"
  end
end
