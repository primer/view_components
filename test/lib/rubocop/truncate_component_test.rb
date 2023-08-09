# frozen_string_literal: true

require "lib/cop_test_case"

class ButtonMigrationTest < CopTestCase
  def cop_class
    ::RuboCop::Cop::Migrations::TruncateComponent
  end

  def test_no_warnings_on_beta_truncate
    investigate(cop, <<~RUBY)
      Primer::Beta::Truncate.new()
    RUBY

    assert_empty cop.offenses
  end

  def test_warn_on_truncate_no_args
    investigate(cop, <<~RUBY)
      Primer::Truncate.new()
    RUBY

    assert_equal 1, cop.offenses.count
  end

  def test_warn_on_truncate_simple_arg
    investigate(cop, <<~RUBY)
      Primer::Truncate.new(0)
    RUBY

    assert_equal 1, cop.offenses.count
    assert cop.offenses.first.corrector.present? 

    assert_equal "Primer::Beta::Truncate.new(0)", cop.offenses.first.corrector.rewrite.strip
  end

  def test_warn_no_fix_truncate_inline
    investigate(cop, <<~RUBY)
      Primer::Truncate.new(inline: true)
    RUBY

    assert_equal 1, cop.offenses.count
    refute cop.offenses.first.corrector.present?
  end
end