# frozen_string_literal: true

require "linter_test_case"

class LabelComponentMigrationCounterTest < LinterTestCase
  def linter_class
    ERBLint::Linters::LabelComponentMigrationCounter
  end

  def test_warns_if_there_is_a_html_label
    @file = "<div class=\"Label\">label</div>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_suggests_ignoring_with_correct_number_of_labels
    @file = "<div class=\"Label custom\">label</div><div class=\"Label custom\">label</div><div class=\"not-a-label\">label</div>"

    assert_equal "<%# erblint:counter LabelComponentMigrationCounter 2 %>\n#{@file}", corrected_content
  end

  def test_suggests_updating_the_number_of_ignored_labels
    @file = "<%# erblint:counter LabelComponentMigrationCounter 1 %>\n<span class=\"Label custom\">Label</span><span class=\"Label custom\">Label</span><span class=\"not-a-Label\">Label</span>"
    @linter.run(processed_source)

    assert_equal "<%# erblint:counter LabelComponentMigrationCounter 2 %>", offenses.last.context
  end

  def test_does_not_warn_if_wrong_tag
    @file = "<p class=\"Label\">label</p>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_suggests_how_to_use_the_component_with_arguments
    @file = "<span class=\"Label Label--large Label--primary\">Label</span>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::LabelComponent.new(variant: :large, scheme: :primary)")
  end

  def test_suggests_how_to_use_the_component_with_aria_arguments
    @file = "<span class=\"Label\" aria-label=\"Some label\">Label</span>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::LabelComponent.new(\"aria-label\": \"Some label\")")
  end

  def test_suggests_how_to_use_the_component_with_data_arguments
    @file = "<span class=\"Label\" data-confirm=\"Some confirmation\">Label</span>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::LabelComponent.new(\"data-confirm\": \"Some confirmation\")")
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

  def test_does_not_suggest_if_using_unsupported_arguments
    @file = "<span class=\"Label\" onclick>Label</span>"
    @linter.run(processed_source)

    refute_includes(offenses.first.message, "render Primer::LabelComponent.new")
  end

  def test_does_not_suggest_if_using_unsupported_classes
    @file = "<span class=\"Label some-custom-class\">Label</span>"
    @linter.run(processed_source)

    refute_includes(offenses.first.message, "render Primer::LabelComponent.new")
  end

  def test_autocorrects
    @file = <<~HTML
      <span class="Label Label--primary">
        Label 1
        <span class="Label custom-class">
          Can\'t be autocorrected
        </span>
        <span class="Label Label--danger">
          Label 2
          <span class="Label Label--info">
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
        <span class="Label custom-class">
          Can\'t be autocorrected
        </span>
        <%= render Primer::LabelComponent.new(scheme: :danger) do %>
          Label 2
          <%= render Primer::LabelComponent.new(scheme: :info) do %>
            Label 3
            <a>not a Label</a>
            <%= render Primer::LabelComponent.new(tag: :summary, variant: :large) do %>
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

    result = corrected_content

    assert_equal expected, result
  end

  def test_autocorrects_removing_unnecessary_ignores
    @file = <<~HTML
      <%# erblint:counter LabelComponentMigrationCounter 1 %>
      <span class="Label Label--primary">
        Label 1
      </span>
    HTML

    expected = <<~HTML
      <%= render Primer::LabelComponent.new(scheme: :primary) do %>
        Label 1
      <% end %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_ignore_counts
    @file = <<~HTML
      <%# erblint:counter LabelComponentMigrationCounter 2 %>
      <span class="Label Label--primary">
        Label 1
      </span>
      <span class="Label custom">
        Label 1
      </span>
    HTML

    expected = <<~HTML
      <%# erblint:counter LabelComponentMigrationCounter 1 %>
      <%= render Primer::LabelComponent.new(scheme: :primary) do %>
        Label 1
      <% end %>
      <span class="Label custom">
        Label 1
      </span>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_even_with_correct_ignores
    @file = <<~HTML
      <%# erblint:counter LabelComponentMigrationCounter 1 %>
      <span class="Label Label--primary">
        Label 1
      </span>
      <span class="Label custom">
        Label 1
      </span>
    HTML

    expected = <<~HTML
      <%# erblint:counter LabelComponentMigrationCounter 1 %>
      <%= render Primer::LabelComponent.new(scheme: :primary) do %>
        Label 1
      <% end %>
      <span class="Label custom">
        Label 1
      </span>
    HTML

    assert_equal expected, corrected_content
  end
end
