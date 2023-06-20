# frozen_string_literal: true

require "lib/erblint_test_case"

class TooltippedMigrationTest < ErblintTestCase
  def linter_class
    ERBLint::Linters::Primer::Accessibility::TooltippedMigration
  end

  def test_warns_if_tooltipped_class_is_used_on_html_tag
    @file = "<li class='tooltipped'>List item</li>"
    @linter.run(processed_source)
    assert_equal 1, @linter.offenses.count
    assert_match(/.tooltipped has been deprecated./, @linter.offenses.first.message)
  end

  def test_warns_if_tooltipped_class_is_used_on_ruby_component
    @file = '<%= render SomeComponent.new(classes: "tooltipped tooltipped-multiline tooltipped-s") do %>'
    @linter.run(processed_source)
    assert_equal 1, @linter.offenses.count
    assert_match(/.tooltipped has been deprecated./, @linter.offenses.first.message)
  end

  def test_does_not_warn_if_tooltipped_is_not_used
    @file = "<%= render SomeComponent.new do %>"
    @linter.run(processed_source)
    assert_equal 0, @linter.offenses.count
  end

  def test_does_not_warn_if_inline_disable_comment
    @file = <<~HTML
      <%= render SomeComponent.new(classes: "tooltipped") do %><%# erblint:disable Primer::Accessibility::TooltippedMigration %>
    HTML
    @linter.run_and_update_offense_status(processed_source)
    assert_equal 0, @linter.offenses.count
  end
end
