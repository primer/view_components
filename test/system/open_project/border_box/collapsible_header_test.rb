# frozen_string_literal: true

require "system/test_case"

class IntegrationOpenProjectCollapsibleHeaderTest < System::TestCase
  def test_renders_component
    visit_preview(:default, module_prefix: "border_box")

    assert_selector(".CollapsibleHeader")
  end
end

