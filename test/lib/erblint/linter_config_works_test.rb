# frozen_string_literal: true

require "lib/erblint_test_case"

class RecommendedSetupWorksTest < ErblintTestCase
  # The ability to share rules and configs from other gems in erb_lint is not well-documented.
  # This test validates that our recommended setup works.
  def test_asserts_recommended_setup_works
    erb_lint_config = ERBLint::RunnerConfig.new(file_loader.yaml(".erb-lint.yml"), file_loader)

    rules_enabled_in_accessibility_config = 0
    erb_lint_config.to_hash["linters"].each do |linter|
      rules_enabled_in_accessibility_config += 1 if linter[0].include?("Primer::Accessibility") && linter[1]["enabled"] == true
    end
    known_linter_names ||= ERBLint::LinterRegistry.linters.map(&:simple_name)
    known_linter_names_count = known_linter_names.count { |linter| linter.include?("Primer::Accessibility") }
    assert_equal 1, rules_enabled_in_accessibility_config
    assert_equal 1, known_linter_names_count
  end
end
