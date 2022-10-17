# frozen_string_literal: true

require "lib/test_helper"

class TestComponent < ViewComponent::Base
  include Primer::Status::Dsl
end

class Primer::Status::DslTest < Minitest::Test
  def test_adds_status_method
    assert_respond_to(TestComponent, :status)
  end

  def test_defaults_to_alpha_and_sets_status
    assert_equal :alpha, TestComponent.status

    TestComponent.status :beta

    assert_equal :beta, TestComponent.status
  end

  def test_raises_if_status_does_not_exist
    err = assert_raises Primer::Status::Dsl::UnknownStatusError do
      TestComponent.status :foo
    end

    assert_equal "status foo does not exist", err.message
  end
end
