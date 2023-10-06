# frozen_string_literal: true

require "system/test_case"

class IntegrationOpenProjectFlexLayoutTest < System::TestCase
  def test_renders_component
    visit_preview(:default)

    assert_selector(".d-flex")
  end
end
