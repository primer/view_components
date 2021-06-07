# frozen_string_literal: true

require "linter_test_case"

class ButtonComponentMigrationCounterTest < LinterTestCase
  def linter_class
    ERBLint::Linters::ButtonComponentMigrationCounter
  end

  def test_warns_if_there_is_a_html_button
    @file = "<button class=\"btn\">Button</button>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_suggests_ignoring_with_correct_number_of_buttons
    @file = "<button class=\"btn\">Button</button><button class=\"btn\">Button</button><button class=\"not-a-btn\">Button</button>"
    @linter.run(processed_source)

    assert_equal "<%# erblint:counter ButtonComponentMigrationCounter 2 %>\n#{@file}", corrected_content
  end

  def test_does_not_warn_if_wrong_tag
    @file = "<span class=\"btn\">Button</span>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end
end
