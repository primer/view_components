# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::CheckboxInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class BadCheckboxesForm < ApplicationForm
    form do |check_form|
      check_form.check_box(name: "alpha", label: "Alpha", scheme: :array)
    end
  end

  def test_array_checkboxes_require_values
    error = assert_raises(ArgumentError) do
      render_in_view_context do
        primer_form_with(url: "/foo") do |f|
          render(BadCheckboxesForm.new(f))
        end
      end
    end

    assert_includes error.message, "Check box needs an explicit value if scheme is array"
  end
end
