# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::GroupInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_group_accepts_system_arguments
    render_in_view_context do
      primer_form_with(url: "/foo") do |f|
        render_inline_form(f) do |sys_args_form|
          sys_args_form.group(layout: :horizontal, border: true, p: 1) do |group|
            group.text_field(name: :first_name, label: "First name")
            group.text_field(name: :last_name, label: "Last name")
          end
        end
      end
    end

    assert_selector ".FormControl-horizontalGroup.border.p-1"
  end
end
