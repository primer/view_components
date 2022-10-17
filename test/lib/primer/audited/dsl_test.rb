# frozen_string_literal: true

require "lib/test_helper"

class TestComponent < ViewComponent::Base
  include Primer::Audited::Dsl
end

class Primer::Audited::DslTest < Minitest::Test
  def test_adds_audited_at_method
    assert_respond_to(TestComponent, :audited_at)
  end

  def test_sets_audited_date
    TestComponent.audited_at "2021-10-20"

    assert_equal "2021-10-20", TestComponent.audited_at
  end
end
