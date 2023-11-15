# frozen_string_literal: true

module Primer
  module OpenProject
    # @component Primer::OpenProject::PageHeader
    # @label Page Header
    class PageHeaderPreview < ViewComponent::Preview
      # @label Default
      # @snapshot
      def default
        render(Primer::OpenProject::PageHeader.new) do |header|
          header.with_title { "Hello" }
          header.with_description { "Last updated 5 minutes ago by XYZ." }
        end
      end

      # @label Playground
      # @param variant [Symbol] select [medium, large]
      # @param title [String] text
      # @param description [String] text
      # @param with_back_button [Boolean]
      # @param back_button_size [Symbol] select [small, medium, large]
      # @param with_breadcrumbs [Boolean]
      # @param parent_link [Boolean]
      def playground(
        variant: :medium,
        title: "Hello",
        description: "Last updated 5 minutes ago by XYZ.",
        with_back_button: false,
        back_button_size: :medium,
        with_breadcrumbs: false,
        parent_link: false
      )
        breadcrumb_items = [{ href: "/foo", text: "Foo" }, { href: "/bar", text: "Bar" }, "Baz"]

        render(Primer::OpenProject::PageHeader.new) do |header|
          header.with_title(variant: variant) { title }
          header.with_description { description }
          header.with_back_button(href: "#", size: back_button_size, 'aria-label': "Back") if with_back_button
          header.with_breadcrumbs(breadcrumb_items) if with_breadcrumbs
          header.with_parent_link(href: "#") { "Parent link" } if parent_link
        end
      end

      # @label Large
      def large_title
        render(Primer::OpenProject::PageHeader.new) do |header|
          header.with_title(variant: :large) { "Hello" }
          header.with_description { "Last updated 5 minutes ago by XYZ." }
        end
      end

      # @label With actions
      def actions
        render_with_template(locals: {})
      end

      # @label With back button
      # @param href [String] text
      # @param size [Symbol] select [small, medium, large]
      # @param icon [String] select ["arrow-left", "chevron-left", "triangle-left"]
      def back_button(href: "#", size: :medium, icon: "arrow-left")
        render(Primer::OpenProject::PageHeader.new) do |header|
          header.with_title { "Hello" }
          header.with_back_button(href: href, size: size, icon: icon, 'aria-label': "Back")
        end
      end

      # @label With breadcrumbs
      def breadcrumbs
        breadcrumb_items = [
          { href: "/foo", text: "Foo" },
          "\u003ca href=\"/foo/bar\"\u003eBar\u003c/a\u003e",
          "Baz"
        ]
        render(Primer::OpenProject::PageHeader.new) do |header|
          header.with_title { "A title" }
          header.with_breadcrumbs(breadcrumb_items)
        end
      end

      # @label With parent link
      def parent_link
        render(Primer::OpenProject::PageHeader.new) do |header|
          header.with_title { "A title" }
          header.with_parent_link(href: "test") { "Parent link" }
        end
      end
    end
  end
end
