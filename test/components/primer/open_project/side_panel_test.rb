# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectSidePanelTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::SidePanel.new) do |component|
      component.with_section do |section|
        section.with_title { "First" }
        section.with_counter(count: 5)
        section.with_description do
          "Description"
        end

        section.with_action_icon(icon: :pencil, 'aria-label': "Edit")
        section.with_footer_button(tag: :a, href: "#") do |button|
          button.with_leading_visual_icon(icon: :pencil)
          "Additional action"
        end

        "Section content"
      end

      component.with_section do |section|
        section.with_title { "Second" }

        "Content"
      end
    end

    assert_selector(".SidePanel")
    assert_selector(".SidePanel section", count: 2)
    assert_selector(".SidePanel-sectionDescription", count: 1)
    assert_selector(".SidePanel-sectionCounter", count: 1)
    assert_selector(".SidePanel .Button--iconOnly", count: 1)
    assert_selector(".SidePanel-sectionFooter.Button--link", count: 1)
  end

  def test_renders_component
    clazz = Class.new(ViewComponent::Base) do
      def self.name
        "CustomComponent"
      end

      def call
        render(Primer::OpenProject::SidePanel::Section.new) do |section|
          section.with_title { "My custom component" }

          "custom content"
        end
      end
    end

    render_inline(Primer::OpenProject::SidePanel.new) do |component|
      component.with_section(clazz.new)
    end

    assert_selector(".SidePanel")
    assert_selector(".SidePanel section", count: 1)
    assert_text("custom content")
  end

  def test_renders_action_menu
    render_inline(Primer::OpenProject::SidePanel.new) do |component|
      component.with_section do |section|
        section.with_title { "Section with menu" }
        section.with_action_menu(button_arguments: { icon: :pencil, "aria-label": "Menu" }) do |menu|
          menu.with_item { "Menu item" }
        end

        "Section content"
      end
    end

    assert_selector(".SidePanel")
    assert_selector(".SidePanel section", count: 1)
    assert_selector(".SidePanel action-menu")
    assert_selector("li.ActionListItem", count: 1)
  end

  def test_no_renders_empty_section
    render_inline(Primer::OpenProject::SidePanel.new) do |component|
      component.with_section do |section|
        section.with_description { "test " }
      end
    end

    assert_selector(".SidePanel")
    assert_no_selector(".SidePanel section")
    assert_no_selector(".SidePanel-sectionDescription", count: 1)
    assert_no_selector(".SidePanel-sectionCounter", count: 1)
  end
end
