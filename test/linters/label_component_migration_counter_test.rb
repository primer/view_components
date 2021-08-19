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
    @file = "<div invalid-attr class=\"Label\">label</div><div invalid-attr class=\"Label\">label</div><div class=\"not-a-label\">label</div>"

    assert_equal "<%# erblint:counter LabelComponentMigrationCounter 2 %>\n#{@file}", corrected_content
  end

  def test_suggests_updating_the_number_of_ignored_labels
    @file = "<%# erblint:counter LabelComponentMigrationCounter 1 %>\n<span invalid-attr class=\"Label\">Label</span><span invalid-attr class=\"Label\">Label</span><span class=\"not-a-Label\">Label</span>"
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

  def test_does_not_suggest_if_cannot_convert_class
    @file = "<span class=\"Label text-center\">Label</span>"
    @linter.run(processed_source)

    refute_includes(offenses.first.message, "render Primer::LabelComponent.new")
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
        <span invalid-attr class="Label">
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

  def test_does_not_autocorrects_when_ignores_are_correct
    @file = <<~HTML
      <%# erblint:counter LabelComponentMigrationCounter 2 %>
      <span class="Label Label--primary">
        Label 1
      </span>
      <span class="Label">
        Label 1
      </span>
    HTML

    assert_equal @file, corrected_content
  end

  def test_autocorrects_ignore_counts_if_override_enabled
    @linter = linter_with_override
    @file = <<~HTML
      <%# erblint:counter LabelComponentMigrationCounter 2 %>
      <span class="Label Label--primary">
        Label 1
      </span>
      <span invalid-attr class="Label">
        Label 1
      </span>
    HTML

    expected = <<~HTML
      <%# erblint:counter LabelComponentMigrationCounter 1 %>
      <%= render Primer::LabelComponent.new(scheme: :primary) do %>
        Label 1
      <% end %>
      <span invalid-attr class="Label">
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
      <span invalid-attr class="Label">
        Label 1
      </span>
    HTML

    expected = <<~HTML
      <%# erblint:counter LabelComponentMigrationCounter 1 %>
      <%= render Primer::LabelComponent.new(scheme: :primary) do %>
        Label 1
      <% end %>
      <span invalid-attr class="Label">
        Label 1
      </span>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_known_system_arguments
    @file = <<~HTML
      <span class="Label Label--primary mr-1 p-3 d-none d-md-block anim-fade-in">
        Label 1
      </span>
      <span invalid-attr class="Label Label--primary mr-1 p-3 d-none d-md-block anim-fade-in">
        Label 2
      </span>
    HTML

    expected = <<~HTML
      <%# erblint:counter LabelComponentMigrationCounter 1 %>
      <%= render Primer::LabelComponent.new(scheme: :primary, mr: 1, p: 3, display: [:none, nil, :block], animation: :fade_in) do %>
        Label 1
      <% end %>
      <span invalid-attr class="Label Label--primary mr-1 p-3 d-none d-md-block anim-fade-in">
        Label 2
      </span>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_with_custom_classes
    @file = <<~HTML
      <span class="Label Label--primary mr-1 p-3 d-none d-md-block anim-fade-in custom-1 custom-2">
        Label 1
      </span>
    HTML

    expected = <<~HTML
      <%= render Primer::LabelComponent.new(scheme: :primary, mr: 1, p: 3, display: [:none, nil, :block], animation: :fade_in, classes: "custom-1 custom-2") do %>
        Label 1
      <% end %>
    HTML

    assert_equal expected, corrected_content
  end
end
