# frozen_string_literal: true

require "lib/erblint_test_case"

class TwoColumnLayoutsTest < ErblintTestCase
  def linter_class
    ERBLint::Linters::TwoColumnLayoutMigrationCounter
  end

  def test_counter_added
    @file = <<~HTML
      <div class="container-xl gutter">
        <div class="col-md-3">Sidebar</div>
        <div class="col-md-9">Main content</div>
      </div>
    HTML

    expected = <<~ERB
      <%# erblint:counter TwoColumnLayoutMigrationCounter 1 %>
      <div class="container-xl gutter">
        <div class="col-md-3">Sidebar</div>
        <div class="col-md-9">Main content</div>
      </div>
    ERB

    assert_equal expected, corrected_content
  end

  def test_counter_incremented
    @file = <<~HTML
      <%# erblint:counter TwoColumnLayoutMigrationCounter 1 %>
      <div class="container-xl gutter">
        <div class="col-md-3">Sidebar</div>
        <div class="col-md-9">Main content</div>
      </div>
      <div class="container-lg gutter">
        <div class="col-md-4">Sidebar</div>
        <div class="col-md-8">Main content</div>
      </div>
    HTML

    expected = <<~ERB
      <%# erblint:counter TwoColumnLayoutMigrationCounter 2 %>
      <div class="container-xl gutter">
        <div class="col-md-3">Sidebar</div>
        <div class="col-md-9">Main content</div>
      </div>
      <div class="container-lg gutter">
        <div class="col-md-4">Sidebar</div>
        <div class="col-md-8">Main content</div>
      </div>
    ERB

    assert_equal expected, corrected_content
  end

  def test_no_counter_when_sidebar_too_large
    @file = <<~HTML
      <div class="container-xl gutter">
        <div class="col-md-5">Sidebar</div>
        <div class="col-md-7">Main content</div>
      </div>
    HTML

    assert_equal @file, corrected_content
  end

  def test_no_counter_when_sidebar_too_small
    @file = <<~HTML
      <div class="container-xl gutter">
        <div class="col-md-1">Sidebar</div>
        <div class="col-md-11">Main content</div>
      </div>
    HTML

    assert_equal @file, corrected_content
  end

  def test_counter_added_when_wrapping_flex_div
    @file = <<~HTML
      <div class="container-xl gutter">
        <div class="d-flex">
          <div class="col-md-3">Sidebar</div>
          <div class="col-md-9">Main content</div>
        </div>
      </div>
    HTML

    expected = <<~ERB
      <%# erblint:counter TwoColumnLayoutMigrationCounter 1 %>
      <div class="container-xl gutter">
        <div class="d-flex">
          <div class="col-md-3">Sidebar</div>
          <div class="col-md-9">Main content</div>
        </div>
      </div>
    ERB

    assert_equal expected, corrected_content
  end
end
