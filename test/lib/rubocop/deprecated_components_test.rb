# frozen_string_literal: true

require "lib/cop_test_case"

class RubocopDeprecatedComponentsTest < CopTestCase
  def cop_class
    RuboCop::Cop::Primer::DeprecatedComponents
  end

  def test_does_not_raise_offense_for_non_primer_node
    investigate(cop, <<-RUBY)
      text = FakeComponent.new
    RUBY

    assert_equal 0, cop.offenses.count
  end

  def test_does_not_raise_offense_if_non_legacy_component_is_used
    investigate(cop, <<-RUBY)
      Primer::Beta::ClipboardCopy.new
    RUBY

    assert_equal 0, cop.offenses.count
  end

  def test_raises_offense_if_calling_legacy_component
    investigate(cop, <<-RUBY)
      Primer::Tooltip.new
      Primer::BlankslateComponent.new
    RUBY

    assert_equal 2, cop.offenses.count
    assert_equal "Primer/DeprecatedComponents: 'Primer::Tooltip' has been deprecated. Please update your code to use 'Primer::Alpha::Tooltip'. Use Rubocop's auto-correct, or replace it yourself.", cop.offenses[0].message
    assert_equal "Primer/DeprecatedComponents: 'Primer::BlankslateComponent' has been deprecated. Please update your code to use 'Primer::Beta::Blankslate'. Use Rubocop's auto-correct, or replace it yourself.", cop.offenses[1].message
  end

  def test_raises_offense_if_calling_legacy_component_with_args
    investigate(cop, <<-RUBY)
      Primer::BlankslateComponent.new(:foo)
    RUBY
    assert_equal 1, cop.offenses.count
  end

  def test_raises_offense_if_calling_legacy_component_in_render
    investigate(cop, <<-RUBY)
      render(Primer::Tooltip.new)
    RUBY

    assert_equal 1, cop.offenses.count
  end

  def test_raises_offense_if_calling_legacy_component_in_render_with_args
    investigate(cop, <<-RUBY)
      render(Primer::BlankslateComponent.new(foo: "bar"))
    RUBY

    assert_equal 1, cop.offenses.count
  end

  def test_suggests_alternative_component_if_available
    investigate(cop, <<-RUBY)
      render(Primer::Tooltip.new(foo: "bar"))
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Primer/DeprecatedComponents: 'Primer::Tooltip' has been deprecated. Please update your code to use 'Primer::Alpha::Tooltip'. Use Rubocop's auto-correct, or replace it yourself.", cop.offenses.first.message
  end
end
