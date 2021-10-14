# frozen_string_literal: true

require "application_system_test_case"

class IntegrationAlphaMarkdownToolbarTest < ApplicationSystemTestCase
  def test_renders_component
    with_preview(:default)

    assert_selector("markdown-toolbar")
  end
end
