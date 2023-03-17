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
        select_variant: Primer::Alpha::ActionMenu::DEFAULT_SELECT_VARIANT, anchor_align: Primer::Alpha::ActionMenu::DEFAULT_ANCHOR_ALIGN, anchor_side: Primer::Alpha::ActionMenu::DEFAULT_ANCHOR_SIDE
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
        render(Primer::Alpha::ActionMenu.new) do |menu|
          menu.with_show_button { "Menu" }
          menu.with_item(label: "Copy link", value: "")
          menu.with_item(label: "Quote reply", value: "")
          menu.with_item(label: "Reference in new issue", value: "")
          menu.with_divider
          menu.with_item(label: "Edit", value: "")
          menu.with_item(label: "Edit", value: "")
          menu.with_item(label: "Delete", scheme: :danger, value: "")
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
      def multiple
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
          menu.with_item(label: "Your respositories", href: "/")
        end
      end

      # @label Single item selected
      def single_selected_item
        render(Primer::Alpha::ActionMenu.new(select_variant: :single)) do |menu|
          menu.with_show_button { "Menu" }
          menu.with_item(label: "Copy link", value: "")
          menu.with_item(label: "Quote reply", active: true, value: "")
          menu.with_item(label: "Reference in new issue", value: "")
        end
      end

      # @label Multiple items selected
      #
      def multiple
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
    end
  end
end
