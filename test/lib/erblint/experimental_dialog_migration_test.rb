# frozen_string_literal: true

require "lib/erblint_test_case"

class ExperimentalDialogMigrationTest < ErblintTestCase
  def linter_class
    ERBLint::Linters::Primer::Accessibility::ExperimentalDialogMigration
  end

  def test_warns_if_primer_experimental_dialog_is_rendered
    @file = <<~ERB
      <%= render Primer::Experimental::Dialog.new(
        dialog_id: "dialog-id",
        title: "My Dialog",
        width: :large,
      ) %>
    ERB
    @linter.run(processed_source)

    assert_equal 1, @linter.offenses.count
    assert_match(/.Primer::Experimental::Dialog has been deprecated./, @linter.offenses.first.message)
  end

  def test_does_not_warn_if_inline_disable_comment
    @file = <<~HTML
      <%= render Primer::Experimental::Dialog.new() do %><%# erblint:disable Primer::Accessibility::ExperimentalDialogMigration %>
    HTML
    @linter.run_and_update_offense_status(processed_source)
    offenses = @linter.offenses.reject(&:disabled?)
    assert_equal 0, offenses.count
  end
end
