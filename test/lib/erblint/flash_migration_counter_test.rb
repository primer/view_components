# frozen_string_literal: true

require "lib/erblint_test_case"

class FlashMigrationCounterTest < ErblintTestCase
  include Primer::BasicLinterSharedTests
  include Primer::AutocorrectableLinterSharedTests

  def test_suggests_how_to_use_the_component_with_arguments
    @file = "<div class=\"flash flash-warn flash-full\">flash</div>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::Alpha::Banner.new(scheme: :warning, full: true)")
  end

  def test_does_not_autocorrect_with_html_content
    @file = <<~HTML
      <div class="flash">
        <div>some content</div>
      </div>
    HTML

    assert_equal "<%# erblint:counter FlashMigrationCounter 1 %>\n#{@file}", corrected_content
  end

  def test_does_not_autocorrect_with_erb_content
    @file = <<~HTML
      <div class="flash">
        <%= primer_octicon(:icon) %> some text
      </div>
    HTML

    assert_equal "<%# erblint:counter FlashMigrationCounter 1 %>\n#{@file}", corrected_content
  end

  def test_does_not_autocorrect_with_interpolation
    @file = <<~HTML
      <div class="flash">
        some <%= interpolation %>
      </div>
    HTML

    assert_equal "<%# erblint:counter FlashMigrationCounter 1 %>\n#{@file}", corrected_content
  end

  private

  def linter_class
    ERBLint::Linters::FlashMigrationCounter
  end

  def default_tag
    "div"
  end

  def default_class
    "flash"
  end
end
