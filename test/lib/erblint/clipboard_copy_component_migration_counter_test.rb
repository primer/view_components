# frozen_string_literal: true

require "lib/erblint_test_case"

class ClipboardCopyComponentMigrationCounterTest < ErblintTestCase
  include Primer::BasicLinterSharedTests
  include Primer::AutocorrectableLinterSharedTests

  def test_suggests_how_to_use_the_component_with_arguments
    @file = "<clipboard-copy value=\"value\" aria-label=\"label\">ClipboardCopy</clipboard-copy>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::Beta::ClipboardCopy.new(value: \"value\", \"aria-label\": \"label\")")
  end

  def test_autocorrects
    @file = <<~HTML
      <clipboard-copy value="value" aria-label="label">
        ClipboardCopy 1
        <clipboard-copy value="value" aria-label="label" invalid-attr>
          Can\'t be autocorrected
        </clipboard-copy>
        <clipboard-copy value="value" aria-label="label">
          ClipboardCopy 2
          <a>not a ClipboardCopy</a>
        </clipboard-copy>
      </clipboard-copy>
    HTML

    expected = <<~HTML
      <%# erblint:counter ClipboardCopyComponentMigrationCounter 1 %>
      <%= render Primer::Beta::ClipboardCopy.new(value: "value", "aria-label": "label") do %>
        ClipboardCopy 1
        <clipboard-copy value="value" aria-label="label" invalid-attr>
          Can\'t be autocorrected
        </clipboard-copy>
        <%= render Primer::Beta::ClipboardCopy.new(value: "value", "aria-label": "label") do %>
          ClipboardCopy 2
          <a>not a ClipboardCopy</a>
        <% end %>
      <% end %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_more_autocorrect
    @file = <<~HTML
      <clipboard-copy for="clone-help-step-2" aria-label="Copy to clipboard" class="btn btn-sm zeroclipboard-button">
        <%= render(Primer::OcticonComponent.new(icon: "paste")) %>
      </clipboard-copy>
    HTML

    expected = <<~HTML
      <%= render Primer::Beta::ClipboardCopy.new(for: "clone-help-step-2", "aria-label": "Copy to clipboard", classes: "btn btn-sm zeroclipboard-button") do %>
        <%= render(Primer::OcticonComponent.new(icon: "paste")) %>
      <% end %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_basic_erb_interpolation
    @file = <<~HTML
      <clipboard-copy value="<%= some_call %>" aria-label="label">
        clipboard-copy
      </clipboard-copy>
    HTML

    expected = <<~HTML
      <%= render Primer::Beta::ClipboardCopy.new(value: some_call, "aria-label": "label") do %>
        clipboard-copy
      <% end %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_interpolation_with_string
    @file = <<~HTML
      <clipboard-copy value="string-<%= some_call %>" aria-label="label">
        clipboard-copy
      </clipboard-copy>
    HTML

    expected = <<~'HTML'
      <%= render Primer::Beta::ClipboardCopy.new(value: "string-#{ some_call }", "aria-label": "label") do %>
        clipboard-copy
      <% end %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_multiple_interpolations
    @file = <<~HTML
      <clipboard-copy value="string-<%= some_call %><%= other_call %>-more-<%= another_call %>" aria-label="label">
        clipboard-copy
      </clipboard-copy>
    HTML

    expected = <<~'HTML'
      <%= render Primer::Beta::ClipboardCopy.new(value: "string-#{ some_call }#{ other_call }-more-#{ another_call }", "aria-label": "label") do %>
        clipboard-copy
      <% end %>
    HTML

    assert_equal expected, corrected_content
  end

  private

  def linter_class
    ERBLint::Linters::ClipboardCopyComponentMigrationCounter
  end

  def default_tag
    "clipboard-copy"
  end

  def required_attributes
    'value="value" aria-label="label"'
  end

  def required_arguments
    "value: \"value\", \"aria-label\": \"label\""
  end
end
