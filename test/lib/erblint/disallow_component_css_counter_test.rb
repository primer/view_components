# frozen_string_literal: true

require "lib/erblint_test_case"

class DisallowComponentCssCounterTest < ErblintTestCase
  def test_no_warning_on_unrestricted_class
    @file = <<~HTML
      <div class="favorite">This is legal</div>
    HTML
    @linter.run(processed_source)
    assert_empty offenses
  end

  def test_warns_on_restricted_class
    @file = <<~HTML
      <div class="Box--danger">
        Reserved for BorderBox
      </div>
    HTML
    @linter.run(processed_source)
    refute_empty offenses
  end

  def test_suggests_two_components
    @file = <<~HTML
      <div class="Overlay">
        Used by two different components
      </div>
    HTML
    @linter.run(processed_source)
    assert_includes offenses.first.message, "Primer::Alpha::Dialog / Primer::Alpha::Overlay"
  end

  def test_no_warning_on_class_covered_by_others
    @file = <<~HTML
      <div class="Label">
        Covered by the LabelComponentMigrationCounter linter
      </div>
    HTML
    @linter.run(processed_source)
    assert_empty offenses
  end

  def test_adds_counter
    @file = '<div class="Box--danger">Reserved for BorderBox</div>'
    assert_equal "<%# erblint:counter DisallowComponentCssCounter 1 %>\n#{@file}", corrected_content
  end

  private

  def linter_class
    ERBLint::Linters::DisallowComponentCssCounter
  end
end
