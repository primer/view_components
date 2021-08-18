# frozen_string_literal: true

require "linter_test_case"

class ButtonComponentMigrationCounterTest < LinterTestCase
  def linter_class
    ERBLint::Linters::ButtonComponentMigrationCounter
  end

  def test_warns_if_there_is_a_html_button
    @file = "<button class=\"btn\">Button</button>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_warns_if_there_is_a_html_link_button
    @file = "<button class=\"btn-link\">Button</button>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_suggests_ignoring_with_correct_number_of_buttons
    @file = "<button invalid-attr class=\"btn\">Button</button><button invalid-attr class=\"btn\">Button</button><button class=\"not-a-btn\">Button</button>"

    assert_equal "<%# erblint:counter ButtonComponentMigrationCounter 2 %>\n#{@file}", corrected_content
  end

  def test_suggests_updating_the_number_of_ignored_buttons
    @file = "<%# erblint:counter ButtonComponentMigrationCounter 1 %>\n<button invalid-attr class=\"btn\">Button</button><button invalid-attr class=\"btn\">Button</button><button class=\"not-a-btn\">Button</button>"
    @linter.run(processed_source)

    assert_equal "<%# erblint:counter ButtonComponentMigrationCounter 2 %>", offenses.last.context
  end

  def test_does_not_warn_if_wrong_tag
    @file = "<span class=\"btn\">Button</span>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_suggests_how_to_use_the_component_with_arguments
    @file = "<button class=\"btn btn-sm btn-primary\">Button</button>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::ButtonComponent.new(variant: :small, scheme: :primary)")
  end

  def test_suggests_how_to_use_the_component_as_link
    @file = "<button class=\"btn-link\">Button</button>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::ButtonComponent.new(scheme: :link)")
  end

  def test_suggests_how_to_use_the_component_with_aria_arguments
    @file = "<button class=\"btn\" aria-label=\"Some label\">Button</button>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::ButtonComponent.new(\"aria-label\": \"Some label\")")
  end

  def test_suggests_how_to_use_the_component_with_data_arguments
    @file = "<button class=\"btn\" data-confirm=\"Some confirmation\">Button</button>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::ButtonComponent.new(\"data-confirm\": \"Some confirmation\")")
  end

  def test_suggest_when_button_is_disabled
    @file = "<button class=\"btn\" disabled>Button</button>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::ButtonComponent.new(disabled: true)")
  end

  def test_suggest_using_the_tag_system_argument
    @file = "<a class=\"btn\">Button</a>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::ButtonComponent.new(tag: :a)")
  end

  def test_does_not_suggest_if_using_unsupported_arguments
    @file = "<button class=\"btn\" onclick>Button</button>"
    @linter.run(processed_source)

    refute_includes(offenses.first.message, "render Primer::ButtonComponent.new")
  end

  def test_does_not_suggest_if_cannot_convert_class
    @file = "<button class=\"btn text-center\">Button</button>"
    @linter.run(processed_source)

    refute_includes(offenses.first.message, "render Primer::ButtonComponent.new")
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
      <%= render Primer::ButtonComponent.new(scheme: :primary) do %>
        button 1
        <button invalid-attr class="btn">
          Can't be autocorrected
        </button>
        <%= render Primer::ButtonComponent.new(scheme: :danger) do %>
          button 2
          <%= render Primer::ButtonComponent.new(scheme: :outline) do %>
            button 3
            <a>not a button</a>
            <%= render Primer::ButtonComponent.new(tag: :summary, variant: :small) do %>
              summary
              <%= render Primer::ButtonComponent.new(tag: :a, test_selector: "test selector") do %>
                a
              <% end %>
            <% end %>
          <% end %>
        <% end %>
        <button>not a button</button>
      <% end %>
    HTML

    result = corrected_content

    assert_equal expected, result
  end

  def test_does_not_autocorrects_when_ignores_are_correct
    @file = <<~HTML
      <%# erblint:counter ButtonComponentMigrationCounter 2 %>
      <button class="btn btn-primary">
        button 1
      </button>
      <button invalid-attr class="btn">
        button 1
      </button>
    HTML

    assert_equal @file, corrected_content
  end

  def test_autocorrects_ignore_counts_if_override_enabled
    @linter = linter_with_override
    @file = <<~HTML
      <%# erblint:counter ButtonComponentMigrationCounter 2 %>
      <button class="btn btn-primary">
        button 1
      </button>
      <button invalid-attr class="btn">
        button 1
      </button>
    HTML

    expected = <<~HTML
      <%# erblint:counter ButtonComponentMigrationCounter 1 %>
      <%= render Primer::ButtonComponent.new(scheme: :primary) do %>
        button 1
      <% end %>
      <button invalid-attr class="btn">
        button 1
      </button>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_even_with_correct_ignores
    @file = <<~HTML
      <%# erblint:counter ButtonComponentMigrationCounter 1 %>
      <button class="btn btn-primary">
        button 1
      </button>
      <button invalid-attr class="btn">
        button 1
      </button>
    HTML

    expected = <<~HTML
      <%# erblint:counter ButtonComponentMigrationCounter 1 %>
      <%= render Primer::ButtonComponent.new(scheme: :primary) do %>
        button 1
      <% end %>
      <button invalid-attr class="btn">
        button 1
      </button>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_known_system_arguments
    @file = <<~HTML
      <button class="btn btn-primary mr-1 p-3 d-none d-md-block anim-fade-in">
        button 1
      </button>
      <button invalid-attr class="btn btn-primary mr-1 p-3 d-none d-md-block anim-fade-in">
        button 2
      </button>
    HTML

    expected = <<~HTML
      <%# erblint:counter ButtonComponentMigrationCounter 1 %>
      <%= render Primer::ButtonComponent.new(scheme: :primary, mr: 1, p: 3, display: [:none, nil, :block], animation: :fade_in) do %>
        button 1
      <% end %>
      <button invalid-attr class="btn btn-primary mr-1 p-3 d-none d-md-block anim-fade-in">
        button 2
      </button>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_with_custom_classes
    @file = <<~HTML
      <button class="btn btn-primary mr-1 p-3 d-none d-md-block anim-fade-in custom-1 custom-2">
        button 1
      </button>
    HTML

    expected = <<~HTML
      <%= render Primer::ButtonComponent.new(scheme: :primary, mr: 1, p: 3, display: [:none, nil, :block], animation: :fade_in, classes: "custom-1 custom-2") do %>
        button 1
      <% end %>
    HTML

    assert_equal expected, corrected_content
  end
end
