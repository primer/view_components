# frozen_string_literal: true

require "lib/test_helper"

class DeprecationsTest < Minitest::Test
  def test_default_deprecations
    assert Primer::Deprecations.deprecated?("Primer::BlankslateComponent")
  end
end
