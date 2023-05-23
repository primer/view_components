# frozen_string_literal: true

require "lib/test_helper"

class Primer::AccessibilityTest < Minitest::Test
  def test_skips_global_rules
    rules = Primer::Accessibility.axe_rules_to_skip
    assert_equal rules[:will_fix].sort, %i[color-contrast]
    assert_equal rules[:wont_fix].sort, %i[region]
  end

  def test_skips_global_rules_and_returns_flattened_list
    rules = Primer::Accessibility.axe_rules_to_skip(flatten: true)
    assert_equal rules.sort, %i[color-contrast region]
  end

  def test_skips_per_component_rules
    rules = Primer::Accessibility.axe_rules_to_skip(component: Primer::Alpha::ToggleSwitch)
    assert_equal rules[:will_fix].sort, %i[color-contrast]
    assert_equal rules[:wont_fix].sort, %i[button-name region]
  end

  def test_skips_per_component_rules_and_returns_flattened_list
    rules = Primer::Accessibility.axe_rules_to_skip(component: Primer::Alpha::ToggleSwitch, flatten: true)
    assert_equal rules.sort, %i[button-name color-contrast region]
  end
end
