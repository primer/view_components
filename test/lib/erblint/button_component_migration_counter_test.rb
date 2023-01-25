# frozen_string_literal: true

require "lib/erblint_test_case"

class ButtonComponentMigrationCounterTest < ErblintTestCase
  include Primer::BasicLinterSharedTests
  include Primer::AutocorrectableLinterSharedTests

  def test_does_not_warn_if_close_button
    @file = "<button class=\"btn close-button\">Button</button>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_warns_if_there_is_a_html_link_button
    @file = "<button class=\"btn-link\">Button</button>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_suggests_how_to_use_the_component_with_arguments
    @file = "<button class=\"btn btn-sm btn-primary\">Button</button>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::Beta::Button.new(size: :small, scheme: :primary)")
  end

  def test_suggests_how_to_use_the_component_as_link
    @file = "<button class=\"btn-link\">Button</button>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::Beta::Button.new(scheme: :link)")
  end

  def test_suggest_when_button_is_disabled
    @file = "<button class=\"btn\" disabled>Button</button>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::Beta::Button.new(disabled: true)")
  end

  def test_suggest_using_the_tag_system_argument
    @file = "<a class=\"btn\">Button</a>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::Beta::Button.new(tag: :a)")
  end

  def test_autocorrects
    @file = <<~HTML
      <button class="btn btn-primary">
        button 1
        <button invalid-attr class="btn">
          Can\'t be autocorrected
        </button>
        <button class="btn btn-danger">
          button 2
          <button class="btn btn-outline">
            button 3
            <a>not a button</a>
            <summary class="btn btn-sm">
              summary
              <a class="btn" <%= test_selector("test selector") %>>
                a
              </a>
            </summary>
          </button>
        </button>
        <button>not a button</button>
      </button>
    HTML

    expected = <<~HTML
      <%# erblint:counter ButtonComponentMigrationCounter 1 %>
      <%= render Primer::Beta::Button.new(scheme: :primary) do %>
        button 1
        <button invalid-attr class="btn">
          Can't be autocorrected
        </button>
        <%= render Primer::Beta::Button.new(scheme: :danger) do %>
          button 2
          <%= render Primer::Beta::Button.new(scheme: :outline) do %>
            button 3
            <a>not a button</a>
            <%= render Primer::Beta::Button.new(tag: :summary, size: :small) do %>
              summary
              <%= render Primer::Beta::Button.new(tag: :a, test_selector: "test selector") do %>
                a
              <% end %>
            <% end %>
          <% end %>
        <% end %>
        <button>not a button</button>
      <% end %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_attributes
    @file = <<~HTML
      <button class="btn" href="href" value="value" name="name" tabindex="tabindex">
        button
      </button>
    HTML

    expected = <<~HTML
      <%= render Primer::Beta::Button.new(href: "href", value: "value", name: "name", tabindex: "tabindex") do %>
        button
      <% end %>
    HTML

    assert_equal expected, corrected_content
  end

  private

  def linter_class
    ERBLint::Linters::ButtonComponentMigrationCounter
  end

  def default_tag
    "button"
  end

  def default_class
    "btn"
  end
end
