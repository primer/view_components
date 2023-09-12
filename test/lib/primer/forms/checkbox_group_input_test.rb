# frozen_string_literal: true

require "lib/test_helper"
require_relative "models/trip"

class Primer::Forms::CheckboxGroupInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class HiddenCheckboxGroupForm < ApplicationForm
    form do |check_form|
      check_form.check_box_group(label: "Foobar", hidden: true) do |check_group|
        check_group.check_box(name: :foo, label: "Foo")
      end
    end
  end

  def test_hidden_checkbox_group
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render(HiddenCheckboxGroupForm.new(f))
      end
    end

    assert_selector "fieldset", visible: :hidden
    assert_selector ".FormControl-checkbox-wrap", visible: :hidden
  end

  class DisabledCheckboxGroupForm < ApplicationForm
    form do |check_form|
      check_form.check_box_group(label: "Foobar", disabled: true) do |check_group|
        check_group.check_box(name: :foo, label: "Foo")
      end
    end
  end

  def test_disabled_checkbox_group_disables_constituent_checkboxes
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render(DisabledCheckboxGroupForm.new(f))
      end
    end

    assert_selector ".FormControl-checkbox-wrap input[disabled]"
  end

  class DisabledCheckboxInGroupForm < ApplicationForm
    form do |check_form|
      check_form.check_box_group(label: "Foobar") do |check_group|
        check_group.check_box(name: :foo, label: "Foo", disabled: true)
      end
    end
  end

  def test_checkbox_can_be_individually_disabled_in_group
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render(DisabledCheckboxInGroupForm.new(f))
      end
    end

    assert_selector ".FormControl-checkbox-wrap input[disabled]"
  end

  def test_validations
    trip = Trip.new(places: ["lopez"])
    trip.valid? # populate validation messages

    render_in_view_context do
      primer_form_with(model: trip) do |f|
        render(ArrayCheckBoxGroupForm.new(f))
      end
    end

    # the wrapper should be marked invalid, but not individual check boxes
    assert_selector ".FormControl-check-group-wrap[invalid=true][aria-invalid=true]"
    refute_selector "input[type=checkbox][invalid]"

    # should have a validation message
    assert_selector ".FormControl-inlineValidation", text: "Places must have at least two selections"
  end
end
