# frozen_string_literal: true

module Primer
  module Alpha
    # @label ActionMenu
    class ActionMenuPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param select_variant [Symbol] select [single, multiple, none]
      # @param anchor_align [Symbol] select [start, center, end]
      # @param anchor_side [Symbol] select [outside_bottom, outside_top, outside_left, outside_right]
      def playground(
        select_variant: Primer::Alpha::ActionMenu::DEFAULT_SELECT_VARIANT, anchor_align: Primer::Alpha::Overlay::DEFAULT_ANCHOR_ALIGN, anchor_side: Primer::Alpha::Overlay::DEFAULT_ANCHOR_SIDE
      )
        render(Primer::Alpha::ActionMenu.new(select_variant: select_variant, anchor_align: anchor_align, anchor_side: anchor_side)) do |menu|
          menu.with_show_button { "Menu" }
          menu.with_item(label: "Copy link", value: "")
          menu.with_item(label: "Quote reply", value: "")
          menu.with_item(label: "Reference in new issue", value: "")
          menu.with_divider
          menu.with_item(label: "Edit", value: "")
          menu.with_item(label: "Delete", scheme: :danger, value: "")
        end
      end

      # @label Default
      #
      def default
        render(Primer::Alpha::ActionMenu.new(menu_id: "menu-1")) do |menu|
          menu.with_show_button { |button| button.with_trailing_action_icon(icon: :"triangle-down"); "Menu" }
          menu.with_item(label: "Copy link", value: "")
          menu.with_item(label: "Quote reply", value: "")
          menu.with_item(label: "Reference in new issue", value: "")
          menu.with_divider
          menu.with_item(label: "Edit", value: "") do |item|
            item.with_description.with_content("Change settings")
          end
          menu.with_item(label: "Delete", scheme: :danger, value: "") do |item|
            item.with_description.with_content("Sayonara")
          end
        end
      end

      # @label With icon button
      #
      def with_icon_button
        render(Primer::Alpha::ActionMenu.new) do |menu|
          menu.with_show_button(icon: :star, "aria-label": "Menu")
          menu.with_item(label: "Does something", value: "")
        end
      end

      # @label Single select
      #
      def single_select
        render(Primer::Alpha::ActionMenu.new(select_variant: :single)) do |menu|
          menu.with_show_button { "Menu" }
          menu.with_item(label: "Fast forward", value: "")
          menu.with_item(label: "Recursive", value: "")
          menu.with_item(label: "Ours", value: "")
          menu.with_item(label: "Resolve", value: "")
        end
      end

      # @label Multiple select
      #
      def multiple_select
        render(Primer::Alpha::ActionMenu.new(select_variant: :multiple)) do |menu|
          menu.with_show_button { "Menu" }
          menu.with_item(label: "langermank", description_scheme: :inline, value: "") do |item|
            item.with_leading_visual_avatar(src: "https://avatars.githubusercontent.com/u/18661030?v=4", alt: "Katie Langerman")
            item.with_description.with_content("Katie Langerman")
          end
          menu.with_item(label: "jonrohan", description_scheme: :inline, value: "") do |item|
            item.with_leading_visual_avatar(src: "https://avatars.githubusercontent.com/u/54012?s=96&v=4", alt: "Jon Rohan")
            item.with_description.with_content("Jon Rohan")
          end
          menu.with_item(label: "broccolinisoup", description_scheme: :inline, value: "") do |item|
            item.with_leading_visual_avatar(src: "https://avatars.githubusercontent.com/u/1446503?v=4", alt: "Armağan Ersöz")
            item.with_description.with_content("Armağan Ersöz")
          end
        end
      end

      # @label Links
      #
      def links
        render(Primer::Alpha::ActionMenu.new) do |menu|
          menu.with_show_button { "Menu" }
          menu.with_item(label: "Settings", href: "/")
          menu.with_item(label: "Your repositories", href: "/")
          menu.with_item(label: "Disabled", href: "/", disabled: true)
        end
      end

      # @label Single item selected
      #
      def single_selected_item
        render(Primer::Alpha::ActionMenu.new(select_variant: :single)) do |menu|
          menu.with_show_button { "Menu" }
          menu.with_item(label: "Copy link", value: "")
          menu.with_item(label: "Quote reply", active: true, value: "")
          menu.with_item(label: "Reference in new issue", value: "")
        end
      end

      # @label Single Select with Internal Label
      #
      def single_select_with_internal_label
        render(Primer::Alpha::ActionMenu.new(select_variant: :single, dynamic_label: true, dynamic_label_prefix: "Menu")) do |menu|
          menu.with_show_button { |button| button.with_trailing_action_icon(icon: :"triangle-down"); "Menu" }
          menu.with_item(label: "Copy link", value: "") do |item|
            item.with_trailing_visual_label(scheme: :accent, inline: true).with_content("Recommended")
          end
          menu.with_item(label: "Quote reply", active: true, value: "")
          menu.with_item(label: "Reference in new issue", value: "")
        end
      end

      # @label Multiple items selected
      #
      def multiple_selected_items
        render(Primer::Alpha::ActionMenu.new(select_variant: :multiple)) do |menu|
          menu.with_show_button { "Menu" }
          menu.with_item(label: "langermank", description_scheme: :inline, value: "", active: true) do |item|
            item.with_leading_visual_avatar(src: "https://avatars.githubusercontent.com/u/18661030?v=4", alt: "Katie Langerman")
            item.with_description.with_content("Katie Langerman")
          end
          menu.with_item(label: "jonrohan", description_scheme: :inline, value: "") do |item|
            item.with_leading_visual_avatar(src: "https://avatars.githubusercontent.com/u/54012?s=96&v=4", alt: "Jon Rohan")
            item.with_description.with_content("Jon Rohan")
          end
          menu.with_item(label: "broccolinisoup", description_scheme: :inline, value: "", active: true) do |item|
            item.with_leading_visual_avatar(src: "https://avatars.githubusercontent.com/u/1446503?v=4", alt: "Armağan Ersöz")
            item.with_description.with_content("Armağan Ersöz")
          end
        end
      end

      # @label With deferred content
      #
      def with_deferred_content
        render(Primer::Alpha::ActionMenu.new(menu_id: "deferred", src: UrlHelpers.action_menu_deferred_path)) do |menu|
          menu.with_show_button { "Menu with deferred content" }
        end
      end

      # @label With deferred preloaded content
      #
      def with_deferred_preloaded_content
        render(Primer::Alpha::ActionMenu.new(menu_id: "deferred-preload", preload: true, src: UrlHelpers.action_menu_deferred_preload_path)) do |menu|
          menu.with_show_button { "Menu with deferred and preloaded content" }
        end
      end

      # @label With actions
      #
      def with_actions
        render(Primer::Alpha::ActionMenu.new) do |component|
          component.with_show_button { "Trigger" }
          component.with_item(label: "Does something", tag: :button, classes: "do-something-js")
          component.with_item(label: "Site", tag: :a, href: "/")
          component.with_item(label: "Copy text", tag: :"clipboard-copy", value: "Text to copy")
        end
      end

      # @label With disabled items
      #
      def with_disabled_items
        render(Primer::Alpha::ActionMenu.new) do |component|
          component.with_show_button { "Trigger" }
          component.with_item(label: "Does something", tag: :button, value: "", disabled: true)
          component.with_item(label: "Site", tag: :a, href: "/", disabled: true)
        end
      end

      # @label Opens a dialog
      #
      def opens_dialog(menu_id: "menu-1")
        render_with_template(locals: {
                               menu_id: menu_id
                             })
      end

      # @label Align end
      #
      def align_end(menu_id: "menu-1")
        render_with_template(locals: {
                               menu_id: menu_id
                             })
      end

      # @label [Item] Block description
      #
      def block_description
        render(Primer::Alpha::ActionMenu.new(menu_id: "menu-1")) do |menu|
          menu.with_show_button { |button| button.with_trailing_action_icon(icon: :"triangle-down"); "Menu" }
          menu.with_item(label: "Item label", value: "") do |item|
            item.with_description.with_content("Block description")
          end
        end
      end

      # @label [Item] Inline description
      #
      def inline_description
        render(Primer::Alpha::ActionMenu.new(menu_id: "menu-1")) do |menu|
          menu.with_show_button { |button| button.with_trailing_action_icon(icon: :"triangle-down"); "Menu" }
          menu.with_item(label: "Item label", value: "", description_scheme: :inline) do |item|
            item.with_description.with_content("Inline description")
          end
        end
      end

      # @label [Item] Leading visual
      #
      def leading_visual
        render(Primer::Alpha::ActionMenu.new(menu_id: "menu-1")) do |menu|
          menu.with_show_button { |button| button.with_trailing_action_icon(icon: :"triangle-down"); "Menu" }
          menu.with_item(label: "Item label", value: "", description_scheme: :inline) do |item|
            item.with_leading_visual_icon(icon: :gear)
            item.with_description.with_content("Inline description")
          end
        end
      end

      # @label [Item] Leading visual single select
      #
      def leading_visual_single_select
        render(Primer::Alpha::ActionMenu.new(menu_id: "menu-1", select_variant: :single)) do |menu|
          menu.with_show_button { |button| button.with_trailing_action_icon(icon: :"triangle-down"); "Menu" }
          menu.with_item(label: "Item label", value: "", description_scheme: :inline) do |item|
            item.with_leading_visual_icon(icon: :gear)
            item.with_description.with_content("Inline description")
          end
        end
      end
    end
  end
end
