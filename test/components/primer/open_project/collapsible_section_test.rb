# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectCollapsibleSectionTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::CollapsibleSection.new) do |component|
      component.with_title { "Hello world" }
      component.with_collapsible_content { "HIDE ME" }
    end

    assert_selector(".CollapsibleSection")
    assert_text("Hello world")
    assert_text("HIDE ME")
  end

  def test_does_not_render_without_title
    err = assert_raises ArgumentError do
      render_inline(Primer::OpenProject::CollapsibleSection.new)
    end

    assert_equal "Title must be present", err.message
  end

  def test_does_not_render_when_title_is_not_a_string
    err = assert_raises ArgumentError do
      render_inline(Primer::OpenProject::CollapsibleSection.new) do |component|
        component.with_title { { name: "Hello" } }
        component.with_collapsible_content { "HIDE ME" }
      end
    end

    assert_equal "Title must be a string", err.message
  end

  def test_does_not_render_without_content
    err = assert_raises ArgumentError do
      render_inline(Primer::OpenProject::CollapsibleSection.new) do |component|
        component.with_title { "Hello world" }
      end
    end

    assert_equal "Collapsible content must be present", err.message
  end

  def test_renders_with_caption
    render_inline(Primer::OpenProject::CollapsibleSection.new) do |component|
      component.with_title { "Hello world" }
      component.with_caption { "Test me" }
      component.with_collapsible_content { "HIDE ME" }
    end

    assert_selector(".CollapsibleSection")
    assert_text("Test me")
    assert_text("HIDE ME")
  end

  def test_renders_with_additional_information
    render_inline(Primer::OpenProject::CollapsibleSection.new) do |component|
      component.with_title { "Hello world" }
      component.with_additional_information { "I appear as well" }
      component.with_collapsible_content { "HIDE ME" }
    end

    assert_selector(".CollapsibleSection")
    assert_text("I appear as well")
    assert_text("HIDE ME")
  end

  def test_renders_collapsed
    render_inline(Primer::OpenProject::CollapsibleSection.new(collapsed: true)) do |component|
      component.with_title { "Hello world" }
      component.with_collapsible_content { "HIDE ME" }
    end

    assert_selector(".CollapsibleSection.CollapsibleSection--collapsed")
  end
end
