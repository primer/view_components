# frozen_string_literal: true

require "test_helper"

class TestComponent < ViewComponent::Base
  include Primer::ViewHelper::DSL
end

class Primer::ViewHelper::DSLTest < Minitest::Test
  def test_register_view_helpers
    assert_respond_to(TestComponent, :view_helper)

    TestComponent.view_helper :test

    assert_raises Primer::ViewHelper::DSL::ViewHelperAlreadyDefined do
      TestComponent.view_helper :test
    end

    assert_equal TestComponent, TestComponent.helpers[:test]
  end
end
