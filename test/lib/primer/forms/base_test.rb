# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::BaseTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class NonRenderingForm < ApplicationForm
    form do |non_rendering_form|
      non_rendering_form.text_field(
        name: :foo,
        label: "Foo"
      )
    end

    def render?
      false
    end
  end

  def test_does_not_render
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render(NonRenderingForm.new(f))
      end
    end

    refute_selector "[input]"
    refute_selector ".FormControl"
  end
end
