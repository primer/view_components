# frozen_string_literal: true

require "lib/cop_test_case"

class ButtonMigrationTest < CopTestCase
  def cop_class
    ::RuboCop::Cop::Migrations::ButtonComponent
  end

  def test_no_warnings_on_beta_button
    investigate(cop, <<~RUBY)
      Primer::Beta::Button.new()
    RUBY

    assert_empty cop.offenses
  end

  def test_warn_on_buttoncomponent_no_args
    investigate(cop, <<~RUBY)
      Primer::ButtonComponent.new()
    RUBY

    assert_equal 1, cop.offenses.count
  end

  def test_warn_on_buttoncomponent_simple_arg
    investigate(cop, <<~RUBY)
      Primer::ButtonComponent.new(1)
    RUBY

    assert_equal 1, cop.offenses.count
    assert cop.offenses.first.corrector.present?

    assert_equal "Primer::Beta::Button.new(1)", cop.offenses.first.corrector.rewrite.strip
  end

  def test_warn_no_fix_buttoncomponent_with_dropdown
    investigate(cop, <<~RUBY)
      Primer::ButtonComponent.new(dropdown: true)
    RUBY

    assert_equal 1, cop.offenses.count
    refute cop.offenses.first.corrector.present?
  end

  def test_warn_no_fix_buttoncomponent_with_group_item
    investigate(cop, <<~RUBY)
      Primer::ButtonComponent.new(group_item: true)
    RUBY

    assert_equal 1, cop.offenses.count
    refute cop.offenses.first.corrector.present?
  end

  def test_warn_buttoncomponent_with_variant
    investigate(cop, <<~RUBY)
      Primer::ButtonComponent.new(variant: :foo)
    RUBY

    assert_equal 1, cop.offenses.count
    assert cop.offenses.first.corrector.present?
    assert_equal "Primer::Beta::Button.new(size: :foo)", cop.offenses.first.corrector.rewrite.strip
  end

  def test_warn_buttoncomponent_with_scheme_outline
    investigate(cop, <<~RUBY)
      Primer::ButtonComponent.new(scheme: :outline)
    RUBY

    assert_equal 1, cop.offenses.count
    assert cop.offenses.first.corrector.present?
    assert_equal "Primer::Beta::Button.new(scheme: :invisible)", cop.offenses.first.corrector.rewrite.strip
  end

  def test_warn_buttoncomponent_with_scheme_invisible
    investigate(cop, <<~RUBY)
      Primer::ButtonComponent.new(scheme: :invisible)
    RUBY

    assert_equal 1, cop.offenses.count
    assert cop.offenses.first.corrector.present?
    assert_equal "Primer::Beta::Button.new(scheme: :invisible)", cop.offenses.first.corrector.rewrite.strip
  end
end
