# frozen_string_literal: true

require "lib/test_helper"
require_relative "models/deep_thought"

class Primer::Forms::SelectInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class HiddenSelectForm < ApplicationForm
    form do |select_form|
      select_form.select_list(name: :foo, label: "Foo", hidden: true) do |list|
        list.option(label: "Foo", value: "foo")
      end
    end
  end

  def test_hidden_select_list
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render(HiddenSelectForm.new(f))
      end
    end

    assert_selector "select#foo", visible: :hidden
  end

  class SelectDeepThoughtForm < ApplicationForm
    form do |select_form|
      select_form.select_list(name: :ultimate_answer, label: "Ultimate answer") do |list|
        list.option(label: "Foo", value: "foo")
      end
    end
  end

  def test_no_error_markup
    model = DeepThought.new(41)
    model.valid? # populate validation error messages

    render_in_view_context do
      primer_form_with(model: model, url: "/foo") do |f|
        render(SelectDeepThoughtForm.new(f))
      end
    end

    refute_selector ".field_with_errors", visible: :all
  end
end
