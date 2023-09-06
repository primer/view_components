# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectPageHeaderTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_does_not_render_if_no_title_provided
    render_inline(Primer::OpenProject::PageHeader.new)

    refute_component_rendered
  end

  def test_renders_title
    render_inline(Primer::OpenProject::PageHeader.new) { |header| header.with_title { "Hello" } }

    assert_text("Hello")
    assert_selector(".PageHeader-title")
  end

  def test_renders_description
    render_inline(Primer::OpenProject::PageHeader.new) do |header|
      header.with_title { "Hello" }
      header.with_description { "My new description" }
    end

    assert_text("Hello")
    assert_selector(".PageHeader-title")
    assert_text("My new description")
    assert_selector(".PageHeader-description")
  end

  def test_renders_actions
    render_inline(Primer::OpenProject::PageHeader.new) do |header|
      header.with_title { "Hello" }
      header.with_actions { "An action" }
    end

    assert_text("Hello")
    assert_selector(".PageHeader-title")
    assert_text("An action")
    assert_selector(".PageHeader-actions")
  end
end
