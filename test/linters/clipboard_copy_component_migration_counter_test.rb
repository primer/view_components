# frozen_string_literal: true

require "linter_test_case"

class ClipboardCopyComponentMigrationCounterTest < LinterTestCase
  def linter_class
    ERBLint::Linters::ClipboardCopyComponentMigrationCounter
  end

  def test_warns_if_there_is_a_html_clipboard_copy
    @file = "<clipboard-copy>clipboard-copy</clipboard-copy>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_suggests_ignoring_with_correct_number_of_clipboard_copies
    @file = "<clipboard-copy>clipboard-copy</clipboard-copy><clipboard-copy>clipboard-copy</clipboard-copy><div>not-a-clipboard-copy</div>"

    assert_equal "<%# erblint:counter ClipboardCopyComponentMigrationCounter 2 %>\n#{@file}", corrected_content
  end

  def test_does_not_warn_if_wrong_tag
    @file = "<span>not-a-clipboard-copy</span>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end
end
