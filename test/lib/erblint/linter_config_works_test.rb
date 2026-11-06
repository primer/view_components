# frozen_string_literal: true

require "lib/erblint_test_case"

class LinterConfigWorksTest < ErblintTestCase
  # The ability to share rules and configs from other gems in erb_lint is not well-documented.
  # This test validates that our recommended setup works.
  def test_asserts_recommended_setup_works
    erb_lint_config = ERBLint::RunnerConfig.new(file_loader.yaml(".erb_lint.yml"), file_loader)

    rules_enabled_in_accessibility_config = 0
    erb_lint_config.to_hash["linters"].each do |linter|
      rules_enabled_in_accessibility_config += 1 if linter[0].include?("Primer::Accessibility") && linter[1]["enabled"] == true
    end
    known_linter_names ||= ERBLint::LinterRegistry.linters.map(&:simple_name)
    known_linter_names_count = known_linter_names.count { |linter| linter.include?("Primer::Accessibility") }
    assert_equal 2, rules_enabled_in_accessibility_config
    assert_equal 2, known_linter_names_count
  end

  def test_repository_only_enables_primer_linters_and_ruby_cops
    config = ERBLint::RunnerConfig.new(file_loader.yaml(".erb_lint.yml"), file_loader)
    config = ERBLint::RunnerConfig.default_for(config)

    enabled_linters = config.to_hash["linters"].filter_map { |name, settings| name if settings["enabled"] }

    assert_equal [
      "ButtonComponentMigrationCounter",
      "DeprecatedComponentsCounter",
      "FlashMigrationCounter",
      "LabelComponentMigrationCounter",
      "NoUnusedDisable",
      "Primer::Accessibility::DetailsMenuMigration",
      "Primer::Accessibility::TooltippedMigration",
      "Rubocop"
    ], enabled_linters.sort
  end

  def test_herb_enforces_migrated_accessibility_rules
    config = file_loader.yaml(".herb.yml")["linter"]

    assert_equal "warning", config["failLevel"]

    [
      "a11y-avoid-generic-link-text",
      "a11y-disabled-attribute",
      "a11y-nested-interactive-elements",
      "a11y-no-aria-label-misuse",
      "a11y-no-redundant-image-alt",
      "a11y-no-visually-hidden-interactive-elements",
      "a11y-svg-has-accessible-text",
      "html-anchor-require-href",
      "html-aria-label-is-well-formatted",
      "html-avoid-both-disabled-and-aria-disabled",
      "html-iframe-has-title",
      "html-img-require-alt",
      "html-navigation-has-label",
      "html-no-aria-hidden-on-focusable",
      "html-no-positive-tab-index",
      "html-no-title-attribute"
    ].each do |rule|
      assert config["rules"].dig(rule, "enabled"), "Herb must enforce #{rule}"
    end
  end
end
