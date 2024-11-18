# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::SubmitButtonInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_uses_name_as_value_by_default
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |submit_button_form|
          submit_button_form.submit(name: :foo, label: "Foo")
        end
      end
    end

    assert_selector "button[type=submit][value=Foo]"
  end

  def test_allows_overriding_value
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |submit_button_form|
          submit_button_form.submit(name: :foo, label: "Foo", value: "bar")
        end
      end
    end

    assert_selector "button[type=submit][value=bar]"
  end
end
