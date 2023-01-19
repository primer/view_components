# frozen_string_literal: true

require "lib/test_helper"

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
end
