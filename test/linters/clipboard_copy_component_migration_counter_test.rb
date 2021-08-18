# frozen_string_literal: true

require "linter_test_case"

class ClipboardCopyComponentMigrationCounterTest < LinterTestCase
  include Primer::BasicLinterSharedTests

  def linter_class
    ERBLint::Linters::ClipboardCopyComponentMigrationCounter
  end

  def default_tag
    "clipboard-copy"
  end

  def required_attributes
    'value="value" aria-label="label"'
  end

  def test_suggests_how_to_use_the_component_with_arguments
    @file = "<clipboard-copy value=\"value\" aria-label=\"label\">ClipboardCopy</clipboard-copy>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::ClipboardCopy.new(value: \"value\", \"aria-label\": \"label\")")
  end

  def test_suggests_how_to_use_the_component_with_data_arguments
    @file = "<clipboard-copy value=\"value\" aria-label=\"label\" data-confirm=\"Some confirmation\">ClipboardCopy</clipboard-copy>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::ClipboardCopy.new(value: \"value\", \"aria-label\": \"label\", \"data-confirm\": \"Some confirmation\")")
  end

  def test_does_not_suggest_if_using_unsupported_arguments
    @file = "<clipboard-copy value=\"value\" aria-label=\"label\" onclick>ClipboardCopy</clipboard-copy>"
    @linter.run(processed_source)

    refute_includes(offenses.first.message, "render Primer::ClipboardCopy.new")
  end

  def test_does_not_suggest_if_cannot_convert_class
    @file = "<clipboard-copy value=\"value\" aria-label=\"label\" class=\"text-center\">ClipboardCopy</clipboard-copy>"
    @linter.run(processed_source)

    refute_includes(offenses.first.message, "render Primer::ClipboardCopy.new")
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
      <%= render Primer::ClipboardCopy.new(value: "value", "aria-label": "label") do %>
        ClipboardCopy 1
        <clipboard-copy value="value" aria-label="label" invalid-attr>
          Can\'t be autocorrected
        </clipboard-copy>
        <%= render Primer::ClipboardCopy.new(value: "value", "aria-label": "label") do %>
          ClipboardCopy 2
          <a>not a ClipboardCopy</a>
        <% end %>
      <% end %>
    HTML

    result = corrected_content

    assert_equal expected, result
  end

  def test_more_autocorrect
    @file = <<~HTML
      <clipboard-copy for="clone-help-step-2" aria-label="Copy to clipboard" class="btn btn-sm zeroclipboard-button">
        <%= render(Primer::OcticonComponent.new(icon: "paste")) %>
      </clipboard-copy>
    HTML

    expected = <<~HTML
      <%= render Primer::ClipboardCopy.new(for: "clone-help-step-2", "aria-label": "Copy to clipboard", classes: "btn btn-sm zeroclipboard-button") do %>
        <%= render(Primer::OcticonComponent.new(icon: "paste")) %>
      <% end %>
    HTML

    result = corrected_content

    assert_equal expected, result
  end

  def test_does_not_autocorrects_when_ignores_are_correct
    @file = <<~HTML
      <%# erblint:counter ClipboardCopyComponentMigrationCounter 2 %>
      <clipboard-copy value="value" aria-label="label">
        ClipboardCopy 1
      </clipboard-copy>
      <clipboard-copy value="value" aria-label="label" invalid-attr>
        ClipboardCopy 2
      </clipboard-copy>
    HTML

    assert_equal @file, corrected_content
  end

  def test_autocorrects_ignore_counts_if_override_enabled
    @linter = linter_with_override
    @file = <<~HTML
      <%# erblint:counter ClipboardCopyComponentMigrationCounter 2 %>
      <clipboard-copy value="value" aria-label="label">
        ClipboardCopy 1
      </clipboard-copy>
      <clipboard-copy value="value" aria-label="label" invalid-attr>
        ClipboardCopy 2
      </clipboard-copy>
    HTML

    expected = <<~HTML
      <%# erblint:counter ClipboardCopyComponentMigrationCounter 1 %>
      <%= render Primer::ClipboardCopy.new(value: "value", "aria-label": "label") do %>
        ClipboardCopy 1
      <% end %>
      <clipboard-copy value="value" aria-label="label" invalid-attr>
        ClipboardCopy 2
      </clipboard-copy>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_even_with_correct_ignores
    @file = <<~HTML
      <%# erblint:counter ClipboardCopyComponentMigrationCounter 1 %>
      <clipboard-copy value="value" aria-label="label">
        ClipboardCopy 1
      </clipboard-copy>
      <clipboard-copy value="value" aria-label="label" invalid-attr>
        ClipboardCopy 2
      </clipboard-copy>
    HTML

    expected = <<~HTML
      <%# erblint:counter ClipboardCopyComponentMigrationCounter 1 %>
      <%= render Primer::ClipboardCopy.new(value: "value", "aria-label": "label") do %>
        ClipboardCopy 1
      <% end %>
      <clipboard-copy value="value" aria-label="label" invalid-attr>
        ClipboardCopy 2
      </clipboard-copy>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_known_system_arguments
    @file = <<~HTML
      <clipboard-copy value="value" aria-label="label" class="mr-1 p-3 d-none d-md-block anim-fade-in">
        clipboard-copy 1
      </clipboard-copy>
      <clipboard-copy invalid-attr value="value" aria-label="label" class="mr-1 p-3 d-none d-md-block anim-fade-in">
        clipboard-copy 2
      </clipboard-copy>
    HTML

    expected = <<~HTML
      <%# erblint:counter ClipboardCopyComponentMigrationCounter 1 %>
      <%= render Primer::ClipboardCopy.new(value: "value", "aria-label": "label", mr: 1, p: 3, display: [:none, nil, :block], animation: :fade_in) do %>
        clipboard-copy 1
      <% end %>
      <clipboard-copy invalid-attr value="value" aria-label="label" class="mr-1 p-3 d-none d-md-block anim-fade-in">
        clipboard-copy 2
      </clipboard-copy>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_with_custom_classes
    @file = <<~HTML
      <clipboard-copy value="value" aria-label="label" class="mr-1 p-3 d-none d-md-block anim-fade-in custom-1 custom-2">
        clipboard-copy
      </clipboard-copy>
    HTML

    expected = <<~HTML
      <%= render Primer::ClipboardCopy.new(value: "value", "aria-label": "label", mr: 1, p: 3, display: [:none, nil, :block], animation: :fade_in, classes: "custom-1 custom-2") do %>
        clipboard-copy
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
      <%= render Primer::ClipboardCopy.new(value: some_call, "aria-label": "label") do %>
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
      <%= render Primer::ClipboardCopy.new(value: "string-#{ some_call }", "aria-label": "label") do %>
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
      <%= render Primer::ClipboardCopy.new(value: "string-#{ some_call }#{ other_call }-more-#{ another_call }", "aria-label": "label") do %>
        clipboard-copy
      <% end %>
    HTML

    assert_equal expected, corrected_content
  end
end
