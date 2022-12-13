# frozen_string_literal: true

require "lib/test_helper"
require_relative "models/deep_thought"

class Primer::Forms::InputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class TestForm < ApplicationForm
    form do |test_form|
      test_form.text_field(
        name: :foo,
        label: "Foo",
        caption: "Something about foos, please",
        disabled: true
      )

      test_form.hidden(
        name: :csrf_token,
        value: "abc123"
      )
    end
  end

  def setup
    form = nil

    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        form = TestForm.new(f)
      end
    end

    @text_field = form.inputs[0].inputs.first
    @hidden_field = form.inputs[1].inputs.first
  end

  def test_merges_input_arguments
    classes = @text_field.input_arguments[:class]
    data = @text_field.input_arguments.fetch(:data, {})
    aria = @text_field.input_arguments.fetch(:aria, {})
    describedby = aria.fetch(:describedby, "")

    refute classes.include?("foo")
    refute data.include?(:foo)
    refute aria.include?(:foo)
    refute describedby.include?("foo")
    refute @text_field.input_arguments.fetch(:foo, nil) == "bar"

    @text_field.merge_input_arguments!(
      class: "foo",
      foo: "bar",
      data: { foo: "foo" },
      aria: {
        foo: "bar",
        describedby: "foo"
      }
    )

    classes = @text_field.input_arguments[:class]
    data = @text_field.input_arguments.fetch(:data, {})
    aria = @text_field.input_arguments.fetch(:aria, {})

    assert classes.include?("foo")
    assert data.include?(:foo)
    assert aria.include?(:foo)
    assert aria[:foo] == "bar"
    assert aria[:describedby] == "#{describedby} foo"
    assert @text_field.input_arguments[:foo] == "bar"
  end

  def test_disabled
    assert @text_field.disabled?
  end

  def test_focusable
    assert @text_field.focusable?
    refute @hidden_field.focusable?
  end

  class NoModelScopeForm < ApplicationForm
    form do |no_model_scope_form|
      no_model_scope_form.text_field(
        name: :ultimate_answer,
        label: "Ultimate answer",
        scope_name_to_model: false
      )
    end
  end

  def test_removes_model_scope
    model = DeepThought.new(42)

    render_in_view_context do
      primer_form_with(model: model, url: "/foo") do |f|
        render(NoModelScopeForm.new(f))
      end
    end

    assert_selector "input[name=ultimate_answer]"
  end
end
