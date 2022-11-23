# frozen_string_literal: true

require "lib/test_helper"

class DeprecationsTest < Minitest::Test
  def test_default_deprecations_are_loaded
    component = "Primer::BlankslateComponent"
    replacement = "Primer::Beta::Blankslate"

    assert Primer::Deprecations.deprecated?(component)
    assert Primer::Deprecations.correctable?(component)
    assert_equal Primer::Deprecations.replacement(component), replacement
    assert_nil Primer::Deprecations.guide(component)
  end
end
