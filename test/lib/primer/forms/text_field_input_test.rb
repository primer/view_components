# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::TextFieldInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class HiddenTextFieldForm < ApplicationForm
    form do |text_field_form|
      text_field_form.text_field(name: :foo, label: "Foo")
    end
  end

  def test_hidden_text_field
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render(HiddenTextFieldForm.new(f))
      end
    end

    assert_selector ".FormControl", visible: false
  end
end
