# frozen_string_literal: true

require "linter_test_case"

class ClipboardCopyComponentMigrationCounterTest < LinterTestCase
  def linter_class
    ERBLint::Linters::ClipboardCopyComponentMigrationCounter
  end

  def test_warns_if_there_is_a_html_clipboard_copy
    @file = "<clipboard-copy>clipboard-copy</clipboard-copy>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_suggests_ignoring_with_correct_number_of_clipboard_copies
    @file = "<clipboard-copy class=\"custom\">clipboard-copy</clipboard-copy><clipboard-copy class=\"custom\">clipboard-copy</clipboard-copy><div>not-a-clipboard-copy</div>"

    assert_equal "<%# erblint:counter ClipboardCopyComponentMigrationCounter 2 %>\n#{@file}", corrected_content
  end

  def test_does_not_warn_if_wrong_tag
    @file = "<div>not-a-clipboard-copy</div>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_suggests_how_to_use_the_component_with_arguments
    @file = "<clipboard-copy value=\"value\">ClipboardCopy</clipboard-copy>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::ClipboardCopy.new(value: \"value\")")
  end

  def test_suggests_how_to_use_the_component_with_aria_arguments
    @file = "<clipboard-copy aria-label=\"Some ClipboardCopy\">ClipboardCopy</clipboard-copy>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::ClipboardCopy.new(\"aria-label\": \"Some ClipboardCopy\")")
  end

  def test_suggests_how_to_use_the_component_with_data_arguments
    @file = "<clipboard-copy data-confirm=\"Some confirmation\">ClipboardCopy</clipboard-copy>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::ClipboardCopy.new(\"data-confirm\": \"Some confirmation\")")
  end

  def test_does_not_suggest_if_using_unsupported_arguments
    @file = "<clipboard-copy onclick>ClipboardCopy</clipboard-copy>"
    @linter.run(processed_source)

    refute_includes(offenses.first.message, "render Primer::ClipboardCopy.new")
  end

  def test_does_not_suggest_if_using_unsupported_classes
    @file = "<clipboard-copy class=\"some-custom-class\">ClipboardCopy</clipboard-copy>"
    @linter.run(processed_source)

    refute_includes(offenses.first.message, "render Primer::ClipboardCopy.new")
  end

  def test_autocorrects
    @file = <<~HTML
      <clipboard-copy>
        ClipboardCopy 1
        <clipboard-copy class="custom-class">
          Can\'t be autocorrected
        </clipboard-copy>
        <clipboard-copy value="some value">
          ClipboardCopy 2
          <a>not a ClipboardCopy</a>
        </clipboard-copy>
      </clipboard-copy>
    HTML

    expected = <<~HTML
      <%# erblint:counter ClipboardCopyComponentMigrationCounter 1 %>
      <%= render Primer::ClipboardCopy.new do %>
        ClipboardCopy 1
        <clipboard-copy class="custom-class">
          Can\'t be autocorrected
        </clipboard-copy>
        <%= render Primer::ClipboardCopy.new(value: "some value") do %>
          ClipboardCopy 2
          <a>not a ClipboardCopy</a>
        <% end %>
      <% end %>
    HTML

    result = corrected_content

    assert_equal expected, result
  end

  def test_autocorrects_removing_unnecessary_ignores
    @file = <<~HTML
      <%# erblint:counter ClipboardCopyComponentMigrationCounter 1 %>
      <clipboard-copy>
        ClipboardCopy 1
      </clipboard-copy>
    HTML

    expected = <<~HTML
      <%= render Primer::ClipboardCopy.new do %>
        ClipboardCopy 1
      <% end %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_ignore_counts
    @file = <<~HTML
      <%# erblint:counter ClipboardCopyComponentMigrationCounter 2 %>
      <clipboard-copy>
        ClipboardCopy 1
      </clipboard-copy>
      <clipboard-copy class="custom">
        ClipboardCopy 2
      </clipboard-copy>
    HTML

    expected = <<~HTML
      <%# erblint:counter ClipboardCopyComponentMigrationCounter 1 %>
      <%= render Primer::ClipboardCopy.new do %>
        ClipboardCopy 1
      <% end %>
      <clipboard-copy class="custom">
        ClipboardCopy 2
      </clipboard-copy>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_even_with_correct_ignores
    @file = <<~HTML
      <%# erblint:counter ClipboardCopyComponentMigrationCounter 1 %>
      <clipboard-copy>
        ClipboardCopy 1
      </clipboard-copy>
      <clipboard-copy class="custom">
        ClipboardCopy 2
      </clipboard-copy>
    HTML

    expected = <<~HTML
      <%# erblint:counter ClipboardCopyComponentMigrationCounter 1 %>
      <%= render Primer::ClipboardCopy.new do %>
        ClipboardCopy 1
      <% end %>
      <clipboard-copy class="custom">
        ClipboardCopy 2
      </clipboard-copy>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_known_system_arguments
    @file = <<~HTML
      <clipboard-copy class="mr-1 p-3 d-none d-md-block anim-fade-in">
        clipboard-copy 1
      </clipboard-copy>
      <clipboard-copy class="mr-1 p-3 d-none d-md-block anim-fade-in custom">
        clipboard-copy 2
      </clipboard-copy>
    HTML

    expected = <<~HTML
      <%# erblint:counter ClipboardCopyComponentMigrationCounter 1 %>
      <%= render Primer::ClipboardCopy.new(mr: 1, p: 3, display: [:none, nil, :block], animation: :fade_in) do %>
        clipboard-copy 1
      <% end %>
      <clipboard-copy class="mr-1 p-3 d-none d-md-block anim-fade-in custom">
        clipboard-copy 2
      </clipboard-copy>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_basic_erb_interpolation
    @file = <<~HTML
      <clipboard-copy value="<%= some_call %>">
        clipboard-copy
      </clipboard-copy>
    HTML

    expected = <<~HTML
      <%= render Primer::ClipboardCopy.new(value: some_call) do %>
        clipboard-copy
      <% end %>
    HTML

    assert_equal expected, corrected_content
  end
end
