# frozen_string_literal: true

require "lib/erblint_test_case"

class DetailsMenuMigrationTest < ErblintTestCase
  def linter_class
    ERBLint::Linters::Primer::Accessibility::DetailsMenuMigration
  end

  def test_warns_if_details_menu_tag_is_used
    @file = "<details-menu class='SelectMenu' role='menu'></details-menu>"
    @linter.run(processed_source)
    assert_equal 1, @linter.offenses.count
    assert_match(/.<details-menu> has been deprecated./, @linter.offenses.first.message)
  end

  def test_warns_if_details_menu_content_tag_is_rendered
    @file = <<~HTML
      <%= content_tag :"details-menu",
      class: "SelectMenu" do %>
    HTML
    @linter.run(processed_source)
    assert_equal 1, @linter.offenses.count
    assert_match(/.<details-menu> has been deprecated./, @linter.offenses.first.message)
  end

  def test_warns_if_details_menu_view_component_is_rendered
    @file = '<%= render SomeComponent.new(tag: :"details-menu") do %>'
    @linter.run(processed_source)
    assert_equal 1, @linter.offenses.count
    assert_match(/.<details-menu> has been deprecated./, @linter.offenses.first.message)
  end

  def test_warns_if_details_menu_view_component_slot_is_rendered
    @file = '<% component.with_body(tag: :"details-menu") do %>'
    @linter.run(processed_source)
    assert_equal 1, @linter.offenses.count
    assert_match(/.<details-menu> has been deprecated./, @linter.offenses.first.message)
  end

  def test_does_not_warn_if_inline_disable_comment
    @file = <<~HTML
      <%= render SomeComponent.new(tag: :"details-menu") do %><%# erblint:disable Primer::Accessibility::DetailsMenuMigration %>
    HTML
    @linter.run_and_update_offense_status(processed_source)
    offenses = @linter.offenses.reject(&:disabled?)
    assert_equal 0, offenses.count
  end
end
