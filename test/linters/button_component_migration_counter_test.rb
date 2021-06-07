# frozen_string_literal: true

require "linter_test_case"

class ButtonComponentMigrationCounterTest < LinterTestCase
  def linter_class
    Primer::ViewComponents::Linters::ButtonComponentMigrationCounter
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

  def test_suggests_how_to_use_the_component_with_arguments
    @file = "<button class=\"btn btn-sm btn-primary\">Button</button>"
    @linter.run(processed_source)

    assert_includes(@linter.offenses.first.message, "render Primer::ButtonComponent.new(variant: :small, scheme: :primary)")
  end

  def test_suggests_how_to_use_the_component_with_aria_arguments
    @file = "<button class=\"btn\" aria-label=\"Some label\">Button</button>"
    @linter.run(processed_source)

    assert_includes(@linter.offenses.first.message, "render Primer::ButtonComponent.new(\"aria-label\": \"Some label\")")
  end

  def test_suggests_how_to_use_the_component_with_data_arguments
    @file = "<button class=\"btn\" data-confirm=\"Some confirmation\">Button</button>"
    @linter.run(processed_source)

    assert_includes(@linter.offenses.first.message, "render Primer::ButtonComponent.new(\"data-confirm\": \"Some confirmation\")")
  end

  def test_suggest_when_button_is_disabled
    @file = "<button class=\"btn\" disabled>Button</button>"
    @linter.run(processed_source)

    assert_includes(@linter.offenses.first.message, "render Primer::ButtonComponent.new(disabled: true)")
  end

  def test_does_not_suggest_if_using_unsupported_arguments
    @file = "<button class=\"btn\" onclick>Button</button>"
    @linter.run(processed_source)

    refute_includes(@linter.offenses.first.message, "render Primer::ButtonComponent.new")
  end

  def test_does_not_suggest_if_using_unsupported_classes
    @file = "<button class=\"btn some-custom-class\">Button</button>"
    @linter.run(processed_source)

    refute_includes(@linter.offenses.first.message, "render Primer::ButtonComponent.new")
  end
end
