# frozen_string_literal: true

require "lib/erblint_test_case"

class ViewComponentHtmlClassesCounterTest < ErblintTestCase
  include Primer::BasicLinterSharedTests

  def test_no_warning_on_unrestricted_class
    @file = "<div class=\"favorite\">Hello</div>"
    @linter.run(processed_source)
    assert_empty offenses
  end

  def test_warns_on_restricted_class
    @file = "<div class=\"ActionListContent--sizeLarge\">Reserved for ActionList</div>"
    @linter.run(processed_source)
    refute_empty offenses
  end

  def test_no_warning_on_class_covered_by_others
    @file = "<div class=\"Label\">Covered by other linter</div>"
    @linter.run(processed_source)
    assert_empty offenses
  end

  def test_does_not_warn_if_wrong_tag
    # this test defined in BasicLinterSharedTests does not apply
    # to this linter (this linter is designed to check all tags)
  end

  private

  def linter_class
    ERBLint::Linters::ViewComponentHtmlClassesCounter
  end

  def default_tag
    "div"
  end

  def default_class
    "ActionListContent--sizeLarge"
  end
end
