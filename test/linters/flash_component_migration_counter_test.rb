# frozen_string_literal: true

require "linter_test_case"

class FlashComponentMigrationCounterTest < LinterTestCase
  def linter_class
    ERBLint::Linters::FlashComponentMigrationCounter
  end

  def test_warns_if_there_is_a_html_flash
    @file = "<div class=\"flash\">flash</div>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_suggests_ignoring_with_correct_number_of_flashes
    @file = "<div class=\"flash\">flash</div><div class=\"flash\">flash</div><div class=\"not-a-flash\">flash</div>"
    @linter.run(processed_source)

    assert_equal "<%# erblint:counter FlashComponentMigrationCounter 2 %>\n#{@file}", corrected_content
  end

  def test_does_not_warn_if_wrong_tag
    @file = "<span class=\"flash\">flash</span>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end
end
