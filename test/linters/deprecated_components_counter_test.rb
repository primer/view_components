# frozen_string_literal: true

require "linter_test_case"

class DeprecatedComponentsCounterTest < LinterTestCase
  def test_warns_about_deprecated_primer_component
    @file = <<~ERB
      <%= render Primer::BlankslateComponent.new %>
    ERB
    @linter.run(processed_source)

    assert @linter.offenses.size == 2
    assert_equal "Primer::BlankslateComponent has been deprecated and should not be used. Try Primer::Beta::Blankslate instead.", @linter.offenses[0].message
    assert_match(/If you must, add <%# erblint:counter DeprecatedComponentsCounter 1 %> to bypass this check/, @linter.offenses[1].message)
  end

  def test_warns_about_multiple_deprecated_primer_component
    @file = <<~ERB
      <%= render Primer::BlankslateComponent.new %>
      <%= render Primer::FlexComponent.new %>
    ERB
    @linter.run(processed_source)

    assert @linter.offenses.size == 3
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
      <%= render Primer::FlexComponent.new %>
    ERB
    @linter.run(processed_source)

    assert @linter.offenses.size.zero?
  end

  def linter_class
    ERBLint::Linters::DeprecatedComponentsCounter
  end
end
