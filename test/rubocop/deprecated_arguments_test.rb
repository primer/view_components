# frozen_string_literal: true

require "cop_test"

class RubocopDeprecatedArgumentsTest < CopTest
  def cop_class
    RuboCop::Cop::Primer::DeprecatedArguments
  end

  def test_no_deprecated_arguments
    investigate(cop, <<-RUBY)
      Primer::BaseComponent.new(color: :danger)
    RUBY

    assert_empty cop.offenses
  end

  def test_argument_not_a_symbol
    investigate(cop, <<-RUBY)
      @val = "blue"
      Primer::BaseComponent.new(color: @val)
    RUBY

    assert_empty cop.offenses
  end

  def test_deprecated_argument
    investigate(cop, <<-RUBY)
      Primer::BaseComponent.new(color: :blue)
    RUBY

    assert_equal 1, cop.offenses.count
  end

  def test_deprecated_argument_as_a_string
    investigate(cop, <<-RUBY)
      Primer::BaseComponent.new(color: "blue")
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Primer::BaseComponent.new(color: :text_link)", cop.offenses.first.corrector.rewrite.strip
  end

  def test_deprecated_argument_autocorrected
    investigate(cop, <<-RUBY)
      Primer::BaseComponent.new(color: :blue)
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Primer::BaseComponent.new(color: :text_link)", cop.offenses.first.corrector.rewrite.strip
  end

  def test_deprecated_argument_with_nil_not_autocorrected
    investigate(cop, <<-RUBY)
      Primer::BaseComponent.new(color: :pink_0)
    RUBY

    assert_equal 1, cop.offenses.count
    refute cop.offenses.first.correctable?
  end

  def test_supports_boolean_values
    investigate(cop, <<-RUBY)
      Primer::Beta::AutoComplete.new(is_label_visible: false)
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Primer::Beta::AutoComplete.new(visually_hide_label: true)", cop.offenses.first.corrector.rewrite.strip
  end
end
