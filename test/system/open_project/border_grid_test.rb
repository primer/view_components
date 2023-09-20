# frozen_string_literal: true

require "system/test_case"

class IntegrationOpenProjectBorderGridTest < System::TestCase
  def test_renders_component
    visit_preview(:default)

    assert_selector(".BorderGrid")
  end
end
