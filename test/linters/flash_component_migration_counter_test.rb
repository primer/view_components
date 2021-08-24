# frozen_string_literal: true

require "linter_test_case"

class FlashComponentMigrationCounterTest < LinterTestCase
  def linter_class
    ERBLint::Linters::FlashComponentMigrationCounter
  end

  def test_warns_if_there_is_a_html_flash
    @file = "<div class=\"flash\">flash</div>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_suggests_ignoring_with_correct_number_of_flashes
    @file = "<div class=\"flash\" invalid-attr>flash</div><div class=\"flash\" invalid-attr>flash</div><div class=\"not-a-flash\">flash</div>"

    assert_equal "<%# erblint:counter FlashComponentMigrationCounter 2 %>\n#{@file}", corrected_content
  end

  def test_suggests_updating_the_number_of_ignored_labels
    @file = "<%# erblint:counter FlashComponentMigrationCounter 1 %>\n<div class=\"flash\" invalid-attr>flash</div><div class=\"flash\" invalid-attr>flash</div><div class=\"not-a-flash\">flash</div>"
    @linter.run(processed_source)

    assert_equal "<%# erblint:counter FlashComponentMigrationCounter 2 %>", offenses.last.context
  end

  def test_does_not_warn_if_wrong_tag
    @file = "<a class=\"flash\">flash</a>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_suggests_how_to_use_the_component_with_arguments
    @file = "<div class=\"flash flash-warn flash-full\">flash</div>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::FlashComponent.new(scheme: :warning, full: true)")
  end

  def test_suggests_how_to_use_the_component_with_aria_arguments
    @file = "<div class=\"flash\" aria-label=\"Some label\">flash</div>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::FlashComponent.new(\"aria-label\": \"Some label\")")
  end

  def test_suggests_how_to_use_the_component_with_data_arguments
    @file = "<div class=\"flash\" data-confirm=\"Some confirmation\">flash</div>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::FlashComponent.new(\"data-confirm\": \"Some confirmation\")")
  end

  def test_does_not_suggest_if_using_unsupported_arguments
    @file = "<div class=\"flash\" onclick>flash</div>"
    @linter.run(processed_source)

    refute_includes(offenses.first.message, "render Primer::FlashComponent.new")
  end

  def test_does_not_suggest_if_cannot_convert_class
    @file = "<div class=\"flash text-center\">flash</div>"
    @linter.run(processed_source)

    refute_includes(offenses.first.message, "render Primer::FlashComponent.new")
  end

  def test_does_not_autocorrects_when_ignores_are_correct
    @file = <<~HTML
      <%# erblint:counter FlashComponentMigrationCounter 2 %>
      <div class="flash flash-warn">
        flash 1
      </div>
      <div class="flash">
        flash 1
      </div>
    HTML

    assert_equal @file, corrected_content
  end

  def test_autocorrects_ignore_counts_if_override_enabled
    @linter = linter_with_override
    @file = <<~HTML
      <%# erblint:counter FlashComponentMigrationCounter 2 %>
      <div class="flash flash-warn">
        flash 1
      </div>
      <div invalid-attr class="flash">
        flash 1
      </div>
    HTML

    expected = <<~HTML
      <%# erblint:counter FlashComponentMigrationCounter 1 %>
      <%= render Primer::FlashComponent.new(scheme: :warning) do %>
        flash 1
      <% end %>
      <div invalid-attr class="flash">
        flash 1
      </div>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_known_system_arguments
    @file = <<~HTML
      <div class="flash flash-warn mr-1 p-3 d-none d-md-block anim-fade-in">
        flash
      </div>
      <div invalid-attr class="flash flash-warn mr-1 p-3 d-none d-md-block anim-fade-in">
        Label 2
      </div>
    HTML

    expected = <<~HTML
      <%# erblint:counter FlashComponentMigrationCounter 1 %>
      <%= render Primer::FlashComponent.new(scheme: :warning, mr: 1, p: 3, display: [:none, nil, :block], animation: :fade_in) do %>
        flash
      <% end %>
      <div invalid-attr class="flash flash-warn mr-1 p-3 d-none d-md-block anim-fade-in">
        Label 2
      </div>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_with_custom_classes
    @file = <<~HTML
      <div class="flash flash-warn mr-1 p-3 d-none d-md-block anim-fade-in custom-1 custom-2">
        flash
      </div>
    HTML

    expected = <<~HTML
      <%= render Primer::FlashComponent.new(scheme: :warning, mr: 1, p: 3, display: [:none, nil, :block], animation: :fade_in, classes: "custom-1 custom-2") do %>
        flash
      <% end %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_does_not_autocorrect_with_html_content
    @file = <<~HTML
      <div class="flash">
        <div>some content</div>
      </div>
    HTML

    assert_equal "<%# erblint:counter FlashComponentMigrationCounter 1 %>\n#{@file}", corrected_content
  end
end
