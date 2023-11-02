# frozen_string_literal: true

require "lib/cop_test_case"

class RubocopDeprecatedLabelVariantsTest < CopTestCase
  def cop_class
    RuboCop::Cop::Primer::DeprecatedLabelVariants
  end

  def test_not_a_label
    investigate(cop, <<-RUBY)
      Primer::BaseComponent.new(variant: :inline)
    RUBY

    assert_empty cop.offenses
  end

  def test_no_deprecated_arguments
    investigate(cop, <<-RUBY)
      Primer::Beta::Label.new(size: :large)
    RUBY

    assert_empty cop.offenses
  end

  def test_argument_not_a_string_or_symbol
    investigate(cop, <<-RUBY)
      Primer::Beta::Label.new(variant: variant)
    RUBY

    assert_empty cop.offenses
  end

  def test_deprecated_large_variant
    investigate(cop, <<-RUBY)
      Primer::Beta::Label.new(variant: :large)
    RUBY

    assert_equal 1, cop.offenses.count
  end

  def test_deprecated_large_variant_autocorrected
    investigate(cop, <<-RUBY)
      Primer::Beta::Label.new(variant: :large)
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Primer::Beta::Label.new(size: :large)", cop.offenses.first.corrector.rewrite.strip
  end

  def test_deprecated_inline_variant_autocorrected
    investigate(cop, <<-RUBY)
      Primer::Beta::Label.new(variant: :inline)
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Primer::Beta::Label.new(inline: true)", cop.offenses.first.corrector.rewrite.strip
  end
end
