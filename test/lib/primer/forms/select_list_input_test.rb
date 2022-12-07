# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::SelectListInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class HiddenSelectListForm < ApplicationForm
    form do |select_list_form|
      select_list_form.select_list(name: :foo, label: "Foo") do |list|
        list.option(label: "Foo", value: "foo")
      end
    end
  end

  def test_hidden_select_list
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render(HiddenSelectListForm.new(f))
      end
    end

    assert_selector ".FormControl", visible: false
  end
end
