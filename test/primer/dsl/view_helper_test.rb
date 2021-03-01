# frozen_string_literal: true

require "test_helper"

class TestComponent < ViewComponent::Base
  include Primer::ViewHelper::DSL
end

class OtherTestComponent < ViewComponent::Base
  include Primer::ViewHelper::DSL
end

class Primer::ViewHelper::DSLTest < Minitest::Test
  def test_register_view_helpers
    assert_respond_to(TestComponent, :view_helper)

    TestComponent.view_helper :test

    assert_equal TestComponent, TestComponent.primer_helpers[:test]
  end

  def test_raises_if_helper_already_defined
    OtherTestComponent.view_helper :test

    err = assert_raises Primer::ViewHelper::DSL::ViewHelperAlreadyDefined do
      OtherTestComponent.view_helper :test
    end

    assert_equal "test is already defined", err.message
  end
end
