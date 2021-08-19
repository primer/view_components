# frozen_string_literal: true

require "linter_test_case"

class FlashComponentMigrationCounterTest < LinterTestCase
  include Primer::BasicLinterSharedTests
  include Primer::AutocorrectableLinterSharedTests

  def linter_class
    ERBLint::Linters::FlashComponentMigrationCounter
  end

  def default_tag
    "div"
  end

  def default_class
    "flash"
  end

  def test_suggests_how_to_use_the_component_with_arguments
    @file = "<div class=\"flash flash-warn flash-full\">flash</div>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::FlashComponent.new(scheme: :warning, full: true)")
  end

  def test_does_not_autocorrect_with_html_content
    @file = <<~HTML
      <div class="flash">
        <div>some content</div>
      </div>
    HTML

    assert_equal "<%# erblint:counter FlashComponentMigrationCounter 1 %>\n#{@file}", corrected_content
  end
end
