# frozen_string_literal: true

require "test_helper"

class Primer::Forms::InputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class InputTestForm < ApplicationForm
    form do |input_test_form|
      input_test_form.text_field(name: :foo, label: "Foo")
    end
  end

  def setup
    form = nil

    render_in_view_context do
      form_with(url: "/foo", skip_default_ids: false) do |f|
        form = SingleTextFieldForm.new(f)
      end
    end

    group = form.inputs.first
    @input = group.inputs.first
  end

  def test_merges_input_arguments
    classes = @input.input_arguments[:class]
    data = @input.input_arguments.fetch(:data, {})
    aria = @input.input_arguments.fetch(:aria, {})
    describedby = aria.fetch(:describedby, "")

    refute classes.include?("foo")
    refute data.include?(:foo)
    refute aria.include?(:foo)
    refute describedby.include?("foo")
    refute @input.input_arguments.fetch(:foo, nil) == "bar"

    @input.merge_input_arguments!(
      class: "foo",
      foo: "bar",
      data: { foo: "foo" },
      aria: {
        foo: "bar",
        describedby: "foo"
      }
    )

    classes = @input.input_arguments[:class]
    data = @input.input_arguments.fetch(:data, {})
    aria = @input.input_arguments.fetch(:aria, {})

    assert classes.include?("foo")
    assert data.include?(:foo)
    assert aria.include?(:foo)
    assert aria[:foo] == "bar"
    assert aria[:describedby] == "#{describedby} foo"
    assert @input.input_arguments[:foo] == "bar"
  end
end
