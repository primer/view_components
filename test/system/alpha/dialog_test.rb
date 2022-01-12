# frozen_string_literal: true

require "application_system_test_case"

class IntegrationAlphaDialogTest < ApplicationSystemTestCase
  # TODO: Add tests for JS functionality?
  def test_renders_component
    with_preview(:default)

    assert_selector("modal-dialog")
  end
end
