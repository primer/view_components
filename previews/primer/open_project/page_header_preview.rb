# frozen_string_literal: true

module Primer
  module OpenProject
    # @component Primer::OpenProject::PageHeader
    # @label Page Header
    class PageHeaderPreview < ViewComponent::Preview
      # @label Default
      # @snapshot
      def default
        breadcrumb_items = [{ href: "/foo", text: "Grandparent" }, { href: "/bar", text: "Parent" }, "Hello"]

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
      # @param with_tab_nav [Boolean]
      # @param in_edit_state [Boolean]
      def playground(
        variant: :medium,
        title: "Hello",
        description: "Last updated 5 minutes ago by XYZ.",
        with_leading_action: :"none",
        with_actions: true,
        with_tab_nav: false,
        in_edit_state: false
      )
        breadcrumb_items = [{ href: "/foo", text: "Foo" }, { href: "/bar", text: "Bar" }, "Baz"]

        render_with_template(locals: { variant: variant,
                                       title: title,
                                       description: description,
                                       with_leading_action: with_leading_action,
                                       with_actions: with_actions,
                                       breadcrumb_items: breadcrumb_items,
                                       with_tab_nav: with_tab_nav,
                                       in_edit_state: in_edit_state })
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

      # @label Editable title
      def editable_title
        breadcrumb_items = [{ href: "/foo", text: "Foo" }, { href: "/bar", text: "Bar" }, "Baz"]
        render(Primer::OpenProject::PageHeader.new(state: :edit)) do |header|
          header.with_title do |title|
            title.with_editable_form(update_path: "/foo", cancel_path: "/bar")
            "Hello"
          end
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
          component.with_title { "Great user" }
          component.with_breadcrumbs([{ href: "/foo", text: "Foo" }, { href: "/bar", text: "Bar" }, "Baz"])

          # The missing label will be resolved automatically when included into the core
          component.with_action_zen_mode_button
          component.with_action_button(mobile_icon: "person", mobile_label: "Profile") do |button|
            button.with_leading_visual_icon(icon: "person")
            "Profile"
          end
        end
      end

      # @label With a create action
      # Create action usually belong into the Primer::OpenProject::SubHeader
      def create_action
        render_with_template(locals: {})
      end

      # @label With a single action
      # The single action will not be transformed into a menu on mobile, but remains in a smaller variant
      def single_action
        render(Primer::OpenProject::PageHeader.new) do |component|
          component.with_title { "Great user" }
          component.with_breadcrumbs([{ href: "/foo", text: "Foo" }, { href: "/bar", text: "Bar" }, "Baz"])

          component.with_action_button(mobile_icon: "person", mobile_label: "Profile") do |button|
            button.with_leading_visual_icon(icon: "person")
            "Profile"
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

      # @label With non-bold breadcrumbs
      # **Breadcrumbs** are only shown on **wider than narrow screens** by default.
      # A parent link is shown instead in narrow screens
      # Per default, the last element is shown in bold, but that can be disabled, e.g if only parts of the string should be bold.
      def non_bold_breadcrumbs
        breadcrumb_items = [
          { href: "/foo", text: "Foo" },
          { href: "/foo/bar", text: "Bar" },
          "Test: <b>Baz</b>".html_safe
        ]
        render(Primer::OpenProject::PageHeader.new) do |header|
          header.with_title { "A title" }
          header.with_breadcrumbs(breadcrumb_items, selected_item_font_weight: :normal)
        end
      end

      # @label With tab nav
      #
      def tab_nav
        render(Primer::OpenProject::PageHeader.new) do |header|
          header.with_title { "Hello" }
          header.with_breadcrumbs([{ href: "/foo", text: "Foo" }, { href: "/bar", text: "Bar" }, "Baz"])
          header.with_description { "Last updated 5 minutes ago by XYZ." }
          header.with_tab_nav(label: "label") do |nav|
            Array.new(3) do |i|
              nav.with_tab(selected: i.zero?, href: "#") do |tab|
                tab.with_text { "Tab #{i + 1}" }
              end
            end
          end
        end
      end

      # @label With a SegmentedControl
      def segmented_control
        render(Primer::OpenProject::PageHeader.new) do |component|
          component.with_title { "Here's a segmented control" }
          component.with_breadcrumbs(["Baz"])

          component.with_action_segmented_control("aria-label": "Segmented control") do |control|
            control.with_item(label: "Preview", icon: :eye, selected: true)
            control.with_item(label: "Raw", icon: :"file-code")
          end

          component.with_action_button(mobile_icon: "star", mobile_label: "Star") do |button|
            button.with_leading_visual_icon(icon: "star")
            "Star"
          end

          callback = lambda do |button|
            button.with_leading_visual_icon(icon: :gear)
            "Settings"
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

      # @label With mobile icons-only SegmentedControl
      def segmented_control_mobile_icons
        render(Primer::OpenProject::PageHeader.new) do |component|
          component.with_title { "Here's a segmented control" }
          component.with_breadcrumbs(["Baz"])

          component.with_action_segmented_control(
            "aria-label": "Segmented control",
            mobile_system_arguments: { hide_labels: true }
          ) do |control|
            control.with_item(label: "Preview", icon: :eye, selected: true)
            control.with_item(label: "Raw", icon: :"file-code")
          end
        end
      end

      # @label With skipable breadcrumb items
      def skip_breadcrumb_item
        render(Primer::OpenProject::PageHeader.new) do |component|
          component.with_title { "Resize me to mobile screen size" }
          component.with_breadcrumbs([{ href: "/foo", text: "Foo" },
                                      { href: "/bar", text: "Bar", skip_for_mobile: true },
                                       "Baz"])
        end
      end

      # @label With a link in the description
      def description
        render_with_template(template: "primer/open_project/page_header_preview/description")
      end
    end
  end
end
