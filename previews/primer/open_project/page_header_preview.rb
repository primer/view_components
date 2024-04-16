# frozen_string_literal: true

module Primer
  module OpenProject
    # @component Primer::OpenProject::PageHeader
    # @label Page Header
    class PageHeaderPreview < ViewComponent::Preview
      # @label Default
      # @snapshot
      def default
        breadcrumb_items = [{ href: "/foo", text: "Grandparent" }, { href: "/bar", text: "Parent" }, "Test: <b>Hello</b>".html_safe]

        render(Primer::OpenProject::PageHeader.new) do |header|
          header.with_title { "Hello" }
          header.with_description { "Last updated 5 minutes ago by XYZ." }
          header.with_breadcrumbs(breadcrumb_items)
        end
      end

      # @label Playground
      # @param variant [Symbol] select [medium, large]
      # @param title [String] text
      # @param description [String] text
      # @param with_leading_action [Symbol] octicon
      # @param with_actions [Boolean]
      def playground(
        variant: :medium,
        title: "Hello",
        description: "Last updated 5 minutes ago by XYZ.",
        with_leading_action: :"none",
        with_actions: true
      )
        breadcrumb_items = [{ href: "/foo", text: "Foo" }, { href: "/bar", text: "Bar" }, "Baz"]

        render_with_template(locals: { variant: variant,
                                       title: title,
                                       description: description,
                                       with_leading_action: with_leading_action,
                                       with_actions: with_actions,
                                       breadcrumb_items: breadcrumb_items })
      end

      # @label Large title
      def large_title
        breadcrumb_items = [{ href: "/foo", text: "Foo" }, { href: "/bar", text: "Bar" }, "Baz"]

        render(Primer::OpenProject::PageHeader.new) do |header|
          header.with_title(variant: :large) { "Hello" }
          header.with_description { "Last updated 5 minutes ago by XYZ." }
          header.with_breadcrumbs(breadcrumb_items)
        end
      end

      # @label With actions
      def actions
        render_with_template(locals: {})
      end

      # @label With a menu inside the actions
      def menu_actions
        callback = lambda do |button|
          button.with_leading_visual_icon(icon: :alert)
          "Click me"
        end

        render(Primer::OpenProject::PageHeader.new) do |component|
          component.with_title { "Great news" }
          component.with_breadcrumbs([{ href: "/foo", text: "Foo" }, { href: "/bar", text: "Bar" }, "Baz"])

          component.with_action_button(mobile_icon: "star", mobile_label: "Star") do |button|
             button.with_leading_visual_icon(icon: "star")
             "Star"
          end
          component.with_action_menu(menu_arguments: { anchor_align: :end },
                                     button_arguments: { button_block: callback }) do |menu|
            menu.with_item(label: "Subitem 1") do |item|
              item.with_leading_visual_icon(icon: :paste)
            end
            menu.with_item(label: "Subitem 2") do |item|
              item.with_leading_visual_icon(icon: :log)
            end
          end
        end
      end

      # @label With a dialog inside the actions
      def dialog_actions
        callback = lambda do |button|
          button.with_leading_visual_icon(icon: :plus)
          "Open dialog"
        end

        render(Primer::OpenProject::PageHeader.new) do |component|
          component.with_title { "Great news" }
          component.with_breadcrumbs([{ href: "/foo", text: "Foo" }, { href: "/bar", text: "Bar" }, "Baz"])

          component.with_action_icon_button(icon: :trash, mobile_icon: :trash, label: "Delete", scheme: :danger)

          component.with_action_dialog(mobile_icon: :plus, mobile_label: "Open dialog",
                                       dialog_arguments: { id: "my_dialog", title: "A great dialog" },
                                       button_arguments: { button_block: callback }) do |d|
            d.with_body { "Hello" }
          end
        end
      end

      # @label With a ZenModeButton inside the actions
      # The missing label will be resolved automatically when included into the core
      def zen_mode_button_actions
        render(Primer::OpenProject::PageHeader.new) do |component|
          component.with_title { "Great news" }
          component.with_breadcrumbs([{ href: "/foo", text: "Foo" }, { href: "/bar", text: "Bar" }, "Baz"])

          # The missing label will be resolved automatically when included into the core
          component.with_action_zen_mode_button
          component.with_action_button(mobile_icon: "plus", mobile_label: "Meeting", scheme: :primary) do |button|
            button.with_leading_visual_icon(icon: "plus")
            "Meeting"
          end
        end
      end

      # @label With leading action (on wide)
      # **Leading action** is only shown on **wide screens** by default.
      # If you want to override that behaviour please use the system_argument: **display**
      # e.g. **component.with\_breadcrumbs(display: [:block, :block])**
      #
      # @param href [String] text
      # @param icon [Symbol] octicon
      def leading_action(href: "#", icon: :"arrow-left")
        breadcrumb_items = [{ href: "/foo", text: "Foo" }, { href: "/bar", text: "Bar" }, "Baz"]

        render(Primer::OpenProject::PageHeader.new) do |header|
          header.with_title { "Hello" }
          header.with_leading_action(icon: icon, href: href, 'aria-label': "Back")
          header.with_breadcrumbs(breadcrumb_items)
        end
      end

      # @label With breadcrumbs
      # **Breadcrumbs** are only shown on **wider than narrow screens** by default.
      # A parent link is shown instead in narrow screens
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
    end
  end
end
