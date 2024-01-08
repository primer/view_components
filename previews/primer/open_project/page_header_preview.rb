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
      # @param with_actions [Boolean]
      # @param with_context_bar_actions [Boolean]
      # @param with_parent_link [Boolean]
      def playground(
        variant: :large,
        title: "Hello",
        description: "Last updated 5 minutes ago by XYZ.",
        with_back_button: false,
        back_button_size: :medium,
        with_breadcrumbs: false,
        with_actions: false,
        with_context_bar_actions: false,
        with_parent_link: false
      )
        breadcrumb_items = [{ href: "/foo", text: "Foo" }, { href: "/bar", text: "Bar" }, "Baz"]

        render_with_template(locals: { variant: variant,
                                       title: title,
                                       description: description,
                                       with_back_button: with_back_button,
                                       back_button_size: back_button_size,
                                       with_breadcrumbs: with_breadcrumbs,
                                       with_parent_link: with_parent_link,
                                       with_actions: with_actions,
                                       with_context_bar_actions: with_context_bar_actions,
                                       breadcrumb_items: breadcrumb_items })
      end

      # @label Medium title
      def medium_title
        render(Primer::OpenProject::PageHeader.new) do |header|
          header.with_title(variant: :medium) { "Hello" }
          header.with_description { "Last updated 5 minutes ago by XYZ." }
        end
      end

      # @label With actions
      def actions
        render_with_template(locals: {})
      end

      # @label With back button (on wide)
      # **Back button** is only shown on **wider than narrow screens** by default.
      # If you want to override that behaviour please use the system_argument: **display**
      # e.g. **component.with\_breadcrumbs(display: [:block, :block])**
      #
      # @param href [String] text
      # @param size [Symbol] select [small, medium, large]
      # @param icon [String] select ["arrow-left", "chevron-left", "triangle-left"]
      def back_button(href: "#", size: :medium, icon: "arrow-left")
        render(Primer::OpenProject::PageHeader.new) do |header|
          header.with_title { "Hello" }
          header.with_back_button(href: href, size: size, icon: icon, 'aria-label': "Back")
        end
      end

      # @label With breadcrumbs (on wide)
      # **Breadcrumbs** are only shown on **wider than narrow screens** by default.
      # If you want to override that behaviour please use the system_argument: **display**
      # e.g. **component.with\_breadcrumbs(display: [:block, :block])**
      #
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

      # @label With parent link (on narrow)
      # **Parent link** is only shown on **narrow screens** by default.
      # If you want to override that behaviour please use the system_argument: **display**
      # e.g. **component.with\_parent\_link(display: [:block, :block])**
      #
      def parent_link
        render(Primer::OpenProject::PageHeader.new) do |header|
          header.with_title { "A title" }
          header.with_parent_link(href: "test") { "Parent link" }
        end
      end

      # @label With context bar actions (on narrow)
      # **Context bar actions** are only shown on **narrow screens** by default.
      # If you want to override that behaviour please use the system_argument: **display**
      # e.g. **component.with\_context\_bar\_actions(display: [:block, :block])**
      #
      def context_bar_actions
        render_with_template(locals: {})
      end
    end
  end
end
