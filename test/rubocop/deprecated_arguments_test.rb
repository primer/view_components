# frozen_string_literal: true

require "cop_test"

class RubocopDeprecatedArgumentsTest < CopTest
  def cop_class
    RuboCop::Cop::Primer::DeprecatedArguments
  end

  def setup
    config = RuboCop::Config.new({ "Primer/DeprecatedArguments" => { "Enabled" => true, "Deprecated" => { foo: { deprecated: ":new_argument" }, bar: { deprecated: nil } } } })
    @cop = cop_class.new(config)
  end

  def test_no_deprecated_arguments
    investigate(cop, <<-RUBY)
      Primer::BaseComponent.new(foo: :new_arguement)
    RUBY

    assert_empty cop.offenses
  end

  def test_argument_not_a_symbol
    investigate(cop, <<-RUBY)
      @val = "deprecated"
      Primer::BaseComponent.new(foo: @val)
    RUBY

    assert_empty cop.offenses
  end

  def test_deprecated_argument
    investigate(cop, <<-RUBY)
      Primer::BaseComponent.new(foo: :deprecated)
    RUBY

    assert_equal 1, cop.offenses.count
  end

  def test_multiple_deprecated_argument
    investigate(cop, <<-RUBY)
      Primer::BaseComponent.new(foo: :deprecated, bar: :deprecated, baz: :bin)
    RUBY

    assert_equal 2, cop.offenses.count
  end

  def test_deprecated_argument_autocorrected
    investigate(cop, <<-RUBY)
      Primer::BaseComponent.new(foo: :deprecated)
    RUBY

    assert_equal 1, cop.offenses.count
    assert_equal "Primer::BaseComponent.new(foo: :new_argument)", cop.offenses.first.corrector.rewrite.strip
  end

  def test_deprecated_argument_with_nil_not_autocorrected
    investigate(cop, <<-RUBY)
      Primer::BaseComponent.new(bar: :deprecated)
    RUBY

    assert_equal 1, cop.offenses.count
    refute cop.offenses.first.correctable?
  end
end
