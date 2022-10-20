# frozen_string_literal: true

require "lib/erblint_test_case"

class LabelComponentMigrationCounterTest < ErblintTestCase
  include Primer::BasicLinterSharedTests
  include Primer::AutocorrectableLinterSharedTests

  def test_suggests_how_to_use_the_component_with_arguments
    @file = "<span class=\"Label Label--large Label--primary\">Label</span>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::LabelComponent.new(size: :large, scheme: :primary)")
  end

  def test_suggest_title_argument
    @file = "<span class=\"Label\" title=\"some title\">Label</span>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::LabelComponent.new(title: \"some title\")")
  end

  def test_suggest_using_the_tag_system_argument
    @file = "<div class=\"Label\">Label</div>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::LabelComponent.new(tag: :div)")
  end

  def test_suggest_using_the_inline_system_argument
    @file = "<span class=\"Label Label--inline\">Label</span>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::LabelComponent.new(inline: true)")
  end

  def test_autocorrects
    @file = <<~HTML
      <span class="Label Label--primary">
        Label 1
        <span invalid-attr class="Label">
          Can\'t be autocorrected
        </span>
        <span class="Label Label--danger">
          Label 2
          <span class="Label Label--accent">
            Label 3
            <a>not a Label</a>
            <summary class="Label Label--large">
              summary
              <div class="Label" <%= test_selector("test selector") %>>
                div
              </div>
            </summary>
          </span>
        </span>
        <span>not a Label</span>
      </span>
    HTML

    expected = <<~HTML
      <%# erblint:counter LabelComponentMigrationCounter 1 %>
      <%= render Primer::LabelComponent.new(scheme: :primary) do %>
        Label 1
        <span invalid-attr class="Label">
          Can\'t be autocorrected
        </span>
        <%= render Primer::LabelComponent.new(scheme: :danger) do %>
          Label 2
          <%= render Primer::LabelComponent.new(scheme: :accent) do %>
            Label 3
            <a>not a Label</a>
            <%= render Primer::LabelComponent.new(tag: :summary, size: :large) do %>
              summary
              <%= render Primer::LabelComponent.new(tag: :div, test_selector: "test selector") do %>
                div
              <% end %>
            <% end %>
          <% end %>
        <% end %>
        <span>not a Label</span>
      <% end %>
    HTML

    assert_equal expected, corrected_content
  end

  private

  def linter_class
    ERBLint::Linters::LabelComponentMigrationCounter
  end

  def default_tag
    "span"
  end

  def default_class
    "Label"
  end
end
