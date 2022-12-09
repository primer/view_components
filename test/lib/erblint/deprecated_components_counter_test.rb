# frozen_string_literal: true

require "lib/erblint_test_case"

class DeprecatedComponentsCounterTest < ErblintTestCase
  def test_default_severity_level
    @file = <<~ERB
      <%= render Primer::BlankslateComponent.new %>
    ERB
    @linter.run(processed_source)

    assert_nil @linter.offenses[0].severity
    assert_nil @linter.offenses[1].severity
  end

  def test_setting_severity_level
    @file = <<~ERB
      <%= render Primer::BlankslateComponent.new %>
    ERB
    linter = linter_with_severity(:info)
    linter.run(processed_source)

    assert_equal :info, linter.offenses[0].severity
    assert_equal :info, linter.offenses[1].severity
  end

  def test_warns_about_deprecated_primer_component
    @file = <<~ERB
      <%= render Primer::BlankslateComponent.new %>
    ERB
    @linter.run(processed_source)

    assert_equal @linter.offenses.size, 2
    assert_equal "'Primer::BlankslateComponent' has been deprecated. Please update your code to use 'Primer::Beta::Blankslate'. Use Rubocop's auto-correct, or replace it yourself.", @linter.offenses[0].message
    assert_match(/If you must, add <%# erblint:counter DeprecatedComponentsCounter 1 %> to bypass this check/, @linter.offenses[1].message)
  end

  def test_warns_about_multiple_deprecated_primer_component
    @file = <<~ERB
      <%= render Primer::BlankslateComponent.new %>
      <%= render Primer::Tooltip.new %>
    ERB
    @linter.run(processed_source)

    assert_equal @linter.offenses.size, 3
    assert_match(/If you must, add <%# erblint:counter DeprecatedComponentsCounter 2 %> to bypass this check/, @linter.offenses[2].message)
  end

  def test_does_not_warn_about_non_deprecated_primer_component
    @file = <<~ERB
      <%= render Primer::SomeComponent.new %>
    ERB
    @linter.run(processed_source)

    assert @linter.offenses.size.zero?
  end

  def test_does_not_warn_if_disable_comment_is_present
    @file = <<~ERB
      <%# erblint:counter DeprecatedComponentsCounter 2 %>
      <%= render Primer::BlankslateComponent.new %>
      <%= render Primer::Tooltip.new %>
    ERB
    @linter.run(processed_source)

    assert @linter.offenses.size.zero?
  end

  def test_does_not_warn_if_html_element
    @file = <<~ERB
      <button>whatever</button>
    ERB
    @linter.run(processed_source)

    assert @linter.offenses.size.zero?
  end

  def test_does_autocorrect_when_no_comment
    @file = <<~ERB
      <%= render Primer::BlankslateComponent.new %>
    ERB
    refute_equal @file, corrected_content
    expected_content = <<~ERB
      <%# erblint:counter DeprecatedComponentsCounter 1 %>
      <%= render Primer::BlankslateComponent.new %>
    ERB
    assert_equal expected_content, corrected_content
  end

  def test_does_autocorrect_when_ignores_are_not_correct
    @file = <<~ERB
      <%# erblint:counter DeprecatedComponentsCounter 3 %>
      <%= render Primer::BlankslateComponent.new %>
    ERB
    refute_equal @file, corrected_content
    expected_content = <<~ERB
      <%# erblint:counter DeprecatedComponentsCounter 1 %>
      <%= render Primer::BlankslateComponent.new %>
    ERB
    assert_equal expected_content, corrected_content
  end

  def test_does_not_autocorrect_when_no_offenses
    @file = <<~ERB
      <%= render Primer::Nothing.new %>
    ERB
    assert_equal @file, corrected_content
  end

  def linter_class
    ERBLint::Linters::DeprecatedComponentsCounter
  end
end
