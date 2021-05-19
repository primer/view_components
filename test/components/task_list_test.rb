# frozen_string_literal: true

require "test_helper"

class PrimerTaskListTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline Primer::TaskListComponent.new do |component|
      component.list do |list|
        list.item do
          "Foobar"
        end
      end
    end

    assert_selector("task-lists") do
      assert_selector("ul.contains-task-list") do
        assert_selector("li.task-list-item") do
          assert_selector("input[type=checkbox].task-list-item-checkbox") do
            assert_text("Foobar")
          end
        end
      end
    end
  end
end
