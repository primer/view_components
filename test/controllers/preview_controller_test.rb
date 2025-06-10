# frozen_string_literal: true

require "test_helper"

class PreviewControllerTest < ActionController::TestCase
  test "should inherit from ViewComponentsController" do
    assert_equal ViewComponentsController, @controller.class.superclass
  end

  test "should have Primer::ViewHelper included" do
    assert @controller.class.helpers.include?(Primer::ViewHelper)
  end
end