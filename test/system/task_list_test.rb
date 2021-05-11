# frozen_string_literal: true

require "application_system_test_case"

class IntegrationTaskListTest < ApplicationSystemTestCase
  def test_renders_component
    with_preview(:default)

    assert_selector("task-list")
  end
end
