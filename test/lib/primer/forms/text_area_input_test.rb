# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::TextAreaInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class HiddenTextAreaForm < ApplicationForm
    form do |text_field_form|
      text_field_form.text_area(name: :foo, label: "Foo")
    end
  end

  def test_hidden_text_area
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render(HiddenTextAreaForm.new(f))
      end
    end

    assert_selector ".FormControl", visible: false
  end
end
