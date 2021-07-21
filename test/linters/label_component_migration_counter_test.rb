# frozen_string_literal: true

require "linter_test_case"

class LabelComponentMigrationCounterTest < LinterTestCase
  def linter_class
    ERBLint::Linters::LabelComponentMigrationCounter
  end

  def test_warns_if_there_is_a_html_label
    @file = "<div class=\"Label\">label</div>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_suggests_ignoring_with_correct_number_of_labels
    @file = "<div class=\"Label\">label</div><div class=\"Label\">label</div><div class=\"not-a-label\">label</div>"

    assert_equal "<%# erblint:counter LabelComponentMigrationCounter 2 %>\n#{@file}", corrected_content
  end

  def test_does_not_warn_if_wrong_tag
    @file = "<p class=\"Label\">label</p>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end
end
