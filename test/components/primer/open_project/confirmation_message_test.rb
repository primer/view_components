# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectConfirmationMessageTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::ConfirmationMessage.new) do |component|
      component.with_heading(tag: :h2).with_content("Some title")
      component.with_description { "Some description" }
    end

    assert_selector "h2", text: "Some title"
    assert_text "Some description"

    # Check for default octicon and color
    assert_selector ".octicon-check-circle.blankslate-icon.color-fg-success"
  end

  def test_does_not_render_if_no_heading_provided
    render_inline(Primer::OpenProject::ConfirmationMessage.new)

    refute_component_rendered
  end

  def test_custom_icon
    render_inline(Primer::OpenProject::ConfirmationMessage.new(icon_arguments: { icon: "plus", color: :danger, classes: "test-class" })) do |component|
      component.with_heading(tag: :h2).with_content("Some title")
    end

    assert_selector "h2", text: "Some title"

    # Check for default octicon and color
    assert_selector ".octicon-plus.blankslate-icon.color-fg-danger.test-class"
  end
end
