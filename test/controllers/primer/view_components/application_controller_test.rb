# frozen_string_literal: true

require "test_helper"

module Primer
  module ViewComponents
    class ApplicationControllerTest < ActionController::TestCase
      test "should have csrf protection enabled" do
        assert_equal :exception, @controller.class.forgery_protection_strategy
      end
    end
  end
end