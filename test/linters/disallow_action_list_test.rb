# frozen_string_literal: true

require "linter_test_case"

class DisallowActionListTest < LinterTestCase
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

  def test_does_not_identify_action_list_class_in_pvc_template
    @file = "<div class='ActionList <%= foo %>'>fooo</div>"
    @filename = Rails.root.join("app/components/primer/component_template.html.erb").to_s
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def linter_class
    ERBLint::Linters::DisallowActionList
  end
end
