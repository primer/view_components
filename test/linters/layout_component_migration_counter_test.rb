# frozen_string_literal: true

require "linter_test_case"

class LayoutComponentMigrationCounterTest < LinterTestCase
  def linter_class
    ERBLint::Linters::LayoutComponentMigrationCounter
  end

  def test_detects_legacy_layout_usage
    @file = <<~HTML
      <div class="container-xl gutter">
        <div class="d-flex">
          <div class="col-md-3">Sidebar</div>
          <div class="col-md-9">Main content</div>
        </div>
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

  def test_stacking_breakpoint
    @file = <<~HTML
      <div class="container-xl gutter">
        <div class="d-flex">
          <div class="col-sm-3">Sidebar</div>
          <div class="col-sm-9">Main content</div>
        </div>
      </div>
    HTML

    expected = <<~ERB
      <%= render Primer::Alpha::Layout.new(stacking_breakpoint: :sm) do |component| %>
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

  def test_main_first_in_source
    @file = <<~HTML
      <div class="container-xl gutter">
        <div class="d-flex">
          <div class="col-md-9">Main content</div>
          <div class="col-md-3">Sidebar</div>
        </div>
      </div>
    HTML

    expected = <<~ERB
      <%= render Primer::Alpha::Layout.new(first_in_source: :main) do |component| %>
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

  def test_no_gutters
    @file = <<~HTML
      <div class="container-xl">
        <div class="d-flex">
          <div class="col-md-3">Sidebar</div>
          <div class="col-md-9">Main content</div>
        </div>
      </div>
    HTML

    expected = <<~ERB
      <%= render Primer::Alpha::Layout.new(gutter: :none) do |component| %>
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

  def test_spacious_gutters
    @file = <<~HTML
      <div class="container-xl gutter-md-spacious">
        <div class="d-flex">
          <div class="col-md-3">Sidebar</div>
          <div class="col-md-9">Main content</div>
        </div>
      </div>
    HTML

    expected = <<~ERB
      <%= render Primer::Alpha::Layout.new(gutter: :spacious) do |component| %>
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

  def test_condensed_gutters
    @file = <<~HTML
      <div class="container-xl gutter-md-condensed">
        <div class="d-flex">
          <div class="col-md-3">Sidebar</div>
          <div class="col-md-9">Main content</div>
        </div>
      </div>
    HTML

    expected = <<~ERB
      <%= render Primer::Alpha::Layout.new(gutter: :condensed) do |component| %>
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

  def test_sidebar_width_wide
    @file = <<~HTML
      <div class="container-xl gutter">
        <div class="d-flex">
          <div class="col-md-4">Sidebar</div>
          <div class="col-md-8">Main content</div>
        </div>
      </div>
    HTML

    expected = <<~ERB
      <%= render Primer::Alpha::Layout.new do |component| %>
        <% component.sidebar(width: :wide) do %>
          Sidebar
        <% end %>

        <% component.main do %>
          Main content
        <% end %>
      <% end %>
    ERB

    assert_equal expected, corrected_content
  end

  def test_sidebar_width_narrow
    @file = <<~HTML
      <div class="container-xl gutter">
        <div class="d-flex">
          <div class="col-md-2">Sidebar</div>
          <div class="col-md-10">Main content</div>
        </div>
      </div>
    HTML

    expected = <<~ERB
      <%= render Primer::Alpha::Layout.new do |component| %>
        <% component.sidebar(width: :narrow) do %>
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
