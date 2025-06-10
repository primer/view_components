# frozen_string_literal: true

require "test_helper"

class ApplicationControllerTest < ActionController::TestCase
  test "should have csrf protection enabled" do
    assert_equal :exception, @controller.class.forgery_protection_strategy
  end

  test "should inherit from ActionController::Base" do
    assert_equal ActionController::Base, @controller.class.superclass
  end
end