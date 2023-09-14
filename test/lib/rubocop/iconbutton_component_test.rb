# frozen_string_literal: true

require "lib/cop_test_case"

class IconButtonMigrationTest < CopTestCase
  def cop_class
    ::RuboCop::Cop::Migrations::IconButtonComponent
  end

  def test_no_warnings_on_beta_icon_button
    investigate(cop, <<~RUBY)
      Primer::Beta::IconButton.new()
    RUBY

    assert_empty cop.offenses
  end

  def test_warn_on_icon_button_no_args
    investigate(cop, <<~RUBY)
      Primer::IconButton.new()
    RUBY

    assert_equal 1, cop.offenses.count
  end

  def test_warn_on_icon_button_with_args
    investigate(cop, <<~RUBY)
      Primer::IconButton.new(icon: :star)
    RUBY

    assert_equal 1, cop.offenses.count
    assert cop.offenses.first.corrector.present?

    assert_equal "Primer::Beta::IconButton.new(icon: :star)", cop.offenses.first.corrector.rewrite.strip
  end

  def test_warn_no_fix_icon_button_with_box
    investigate(cop, <<~RUBY)
      Primer::IconButton.new(box: true)
    RUBY

    assert_equal 1, cop.offenses.count
    refute cop.offenses.first.corrector.present?
  end
end
