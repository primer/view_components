# frozen_string_literal: true

require "test_helper"

class HealthControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :ok
  end

  test "should inherit from ApplicationController" do
    assert_equal ApplicationController, @controller.class.superclass 
  end
end