# frozen_string_literal: true

require "application_system_test_case"

class IntegrationTaskListTest < ApplicationSystemTestCase
  def test_renders_component
    with_preview(:default)

    assert_selector("task-lists[sortable]") do
      assert_selector("ul.contains-task-list") do
        assert_selector("li.task-list-item") do
          assert_selector("input[type=checkbox].task-list-item-checkbox")
          assert_text("Apple")
        end
      end
    end
  end
end
