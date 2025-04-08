# frozen_string_literal: true

require "application_system_test_case"

class IntegrationAlphaIncludeFragmentTest < ApplicationSystemTestCase
  def test_renders_component
    visit_preview(:default)

    assert_selector(".include-fragment")
  end
end
