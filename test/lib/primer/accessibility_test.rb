# frozen_string_literal: true

require "lib/test_helper"

class Primer::AccessibilityTest < Minitest::Test
  def test_axe_rules_to_skip_includes_global_rules
    assert_equal Primer::Accessibility.axe_rules_to_skip.to_a.sort, %i[color-contrast region]
  end

  def test_axe_rules_to_skip_excludes_will_fix_rules
    assert_equal Primer::Accessibility.axe_rules_to_skip(skip_will_fix: false).to_a.sort, %i[region]
  end

  def test_axe_rules_to_skip_includes_per_component_rules
    assert_equal Primer::Accessibility.axe_rules_to_skip(component: Primer::Alpha::ToggleSwitch).to_a.sort, %i[button-name color-contrast region]
  end

  def test_axe_rules_to_skip_includes_per_component_rules_and_excludes_will_fix_rules
    assert_equal Primer::Accessibility.axe_rules_to_skip(component: Primer::Alpha::ToggleSwitch, skip_will_fix: false).to_a.sort, %i[button-name region]
  end
end
