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
        render(Primer::Alpha::ActionMenu.new(select_variant: select_variant, anchor_align: anchor_align, anchor_side: anchor_side)) do |c|
          c.with_show_button { "Menu" }
          c.with_item(label: "Copy link")
          c.with_item(label: "Quote reply")
          c.with_item(label: "Reference in new issue")
          c.with_item(is_divider: true)
          c.with_item(label: "Edit")
          c.with_item(label: "Delete", scheme: :danger)
        end
      end

      # @label Default
      #
      def default
        render(Primer::Alpha::ActionMenu.new) do |c|
          c.with_show_button { "Menu" }
          c.with_item(label: "Copy link")
          c.with_item(label: "Quote reply")
          c.with_item(label: "Reference in new issue")
          c.with_item(is_divider: true)
          c.with_item(label: "Edit")
          c.with_item(label: "Edit")
          c.with_item(label: "Delete", scheme: :danger)
        end
      end

      # @label Single select
      #
      def single_select
        render(Primer::Alpha::ActionMenu.new(select_variant: :single)) do |c|
          c.with_show_button { "Menu" }
          c.with_item(label: "Fast forward")
          c.with_item(label: "Recursive")
          c.with_item(label: "Ours")
          c.with_item(label: "Resolve")
        end
      end

      # @label Multiple select
      #
      def multiple
        render(Primer::Alpha::ActionMenu.new(select_variant: :multiple)) do |c|
          c.with_show_button { "Menu" }
          c.with_item(label: "langermank", description_scheme: :inline) do |item|
            item.with_leading_visual_avatar(src: "https://avatars.githubusercontent.com/u/18661030?v=4", alt: "Katie Langerman")
            item.with_description.with_content("Katie Langerman")
          end
          c.with_item(label: "jonrohan", description_scheme: :inline) do |item|
            item.with_leading_visual_avatar(src: "https://avatars.githubusercontent.com/u/54012?s=96&v=4", alt: "Jon Rohan")
            item.with_description.with_content("Jon Rohan")
          end
          c.with_item(label: "broccolinisoup", description_scheme: :inline) do |item|
            item.with_leading_visual_avatar(src: "https://avatars.githubusercontent.com/u/1446503?v=4", alt: "Armağan Ersöz")
            item.with_description.with_content("Armağan Ersöz")
          end
        end
      end

      # @label Links
      #
      def links
        render(Primer::Alpha::ActionMenu.new) do |c|
          c.with_show_button { "Menu" }
          c.with_item(label: "Settings", href: "/")
          c.with_item(label: "Your respositories", href: "/")
        end
      end
    end
  end
end
