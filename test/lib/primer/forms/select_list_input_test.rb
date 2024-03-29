# frozen_string_literal: true

require "lib/test_helper"
require_relative "models/deep_thought"

class Primer::Forms::SelectInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_hidden_select_list
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |select_form|
          select_form.select_list(name: :foo, label: "Foo", hidden: true) do |list|
            list.option(label: "Foo", value: "foo")
          end
        end
      end
    end

    assert_selector "select#foo", visible: :hidden
  end

  def test_no_error_markup
    model = DeepThought.new(41)
    model.valid? # populate validation error messages

    render_in_view_context do
      primer_form_with(model: model, url: "/foo") do |f|
        render_inline_form(f) do |select_form|
          select_form.select_list(name: :ultimate_answer, label: "Ultimate answer") do |list|
            list.option(label: "Foo", value: "foo")
          end
        end
      end
    end

    refute_selector ".field_with_errors", visible: :all
  end

  def test_option_includes_test_selector
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |select_form|
          select_form.select_list(name: :foo, label: "Foo", hidden: true) do |list|
            list.option(
              label: "Foo",
              value: "foo",
              test_selector: "test-selector-foo",
            )
          end
        end
      end
    end
    assert_selector "[data-test-selector='test-selector-foo']", visible: :hidden
  end
end
