# frozen_string_literal: true

require "lib/cop_test_case"

class RubocopDeprecatedLabelSchemesTest < CopTestCase
  def cop_class
    RuboCop::Cop::Primer::DeprecatedLabelSchemes
  end

  def test_not_a_label
    investigate(cop, <<-RUBY)
      Primer::BaseComponent.new(scheme: :danger)
    RUBY

    assert_empty cop.offenses
  end

  def test_no_deprecated_arguments
    investigate(cop, <<-RUBY)
      Primer::Beta::Label.new(scheme: :danger)
    RUBY

    assert_empty cop.offenses
  end

  def test_argument_not_a_symbol
    investigate(cop, <<-RUBY)
      Primer::Beta::Label.new(scheme: scheme)
    RUBY

    assert_empty cop.offenses
  end

  def test_deprecated_argument
    investigate(cop, <<-RUBY)
      Primer::Beta::Label.new(scheme: :info)
    RUBY

    assert_equal 1, cop.offenses.count
  end

  def test_deprecated_argument_as_a_string
    investigate(cop, <<-RUBY)
      Primer::Beta::Label.new(scheme: "info")
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Primer::Beta::Label.new(scheme: :accent)", cop.offenses.first.corrector.rewrite.strip
  end

  def test_deprecated_argument_autocorrected
    investigate(cop, <<-RUBY)
      Primer::Beta::Label.new(scheme: :info)
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Primer::Beta::Label.new(scheme: :accent)", cop.offenses.first.corrector.rewrite.strip
  end
end
