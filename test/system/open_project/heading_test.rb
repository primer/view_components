# frozen_string_literal: true

require "system/test_case"

class IntegrationOpenProjectHeadingTest < System::TestCase
  def test_renders_component
    visit_preview(:default)

    assert_selector("h2")
  end
end
