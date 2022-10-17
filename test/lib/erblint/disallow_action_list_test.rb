# frozen_string_literal: true

require "lib/erblint_test_case"

class DisallowActionListTest < ErblintTestCase
  def test_identifies_action_list_class
    @file = "<div class='ActionList <%= foo %>'>fooo</div>"
    @linter.run(processed_source)

    assert @linter.offenses.size == 1

    offense = @linter.offenses.first
    assert offense.source_range.begin_pos == 12
    assert offense.source_range.end_pos == 22
  end

  def test_identifies_two_action_list_classes
    @file = "<div class='ActionList ActionList-item'>fooo</div>"
    @linter.run(processed_source)

    assert @linter.offenses.size == 2

    offense = @linter.offenses[0]
    assert offense.source_range.begin_pos == 12
    assert offense.source_range.end_pos == 22

    offense = @linter.offenses[1]
    assert offense.source_range.begin_pos == 23
    assert offense.source_range.end_pos == 38
  end

  def test_identifies_action_list_class_nested
    @file = "<div><div class='ActionList <%= foo %>'>fooo</div></div>"
    @linter.run(processed_source)

    assert @linter.offenses.size == 1

    offense = @linter.offenses.first
    assert offense.source_range.begin_pos == 17
    assert offense.source_range.end_pos == 27
  end

  def test_does_not_identify_action_list_class_in_ignored_files
    @file = "<div class='ActionList <%= foo %>'>fooo</div>"
    @filename = "app/components/primer/component_template.html.erb"
    config = linter_class.config_schema.new(ignore_files: ["app/components/primer/*.html.erb"])
    @linter = linter_class.new(file_loader, config)
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def linter_class
    ERBLint::Linters::DisallowActionList
  end
end
