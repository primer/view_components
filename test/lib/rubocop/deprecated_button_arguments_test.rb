# frozen_string_literal: true

require "lib/cop_test_case"

class RubocopDeprecatedButtonArgumentsTest < CopTestCase
  def cop_class
    RuboCop::Cop::Primer::DeprecatedButtonArguments
  end

  def test_no_deprecated_arguments
    investigate(cop, <<-RUBY)
      Primer::ButtonComponent.new(scheme: :danger)
    RUBY

    assert_empty cop.offenses
  end

  def test_using_variant
    investigate(cop, <<-RUBY)
      Primer::ButtonComponent.new(variant: :small)
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Primer::ButtonComponent.new(size: :small)", cop.offenses.first.corrector.rewrite.strip
  end
end
