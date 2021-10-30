# frozen_string_literal: true

require "linter_test_case"

class LayoutComponentMigrationCounterTest < LinterTestCase
  def linter_class
    ERBLint::Linters::LayoutComponentMigrationCounter
  end

  def test_detects_legacy_layout_usage
    @file = <<~HTML
      <div class="container-xl gutter">
        <div class="col-md-3">Sidebar</div>
        <div class="col-md-9">Main content</div>
      </div>
    HTML

    expected = <<~ERB
      <%= render Primer::Alpha::Layout.new do |component| %>
        <% component.sidebar do %>
          Sidebar
        <% end %>

        <% component.main do %>
          Main content
        <% end %>
      <% end %>
    ERB

    assert_equal expected, corrected_content
  end
end
