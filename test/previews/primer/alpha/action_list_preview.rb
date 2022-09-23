# frozen_string_literal: true

module Primer
  module Alpha
    # @label ActionList
    class ActionListPreview < ViewComponent::Preview
      # @label Sub lists
      def sub_lists
        render(Primer::Alpha::ActionList.new) do |list|
          list.with_heading(title: "Heading", tag: :h2)
          list.with_item(label: "Item one", href: "/") do |item|
            item.with_leading_visual_icon(icon: :gear)
          end
          list.with_list do |sub_list|
            sub_list.with_item(label: "Sub item one", href: "/") do |item|
              item.with_leading_visual_icon(icon: :gear)
            end
            sub_list.with_item(label: "Sub item two", href: "/") do |item|
              item.with_leading_visual_icon(icon: :gear)
            end
          end
        end
      end

      # @label Sub items
      def sub_items
        render(Primer::Alpha::ActionList.new) do |list|
          list.with_heading(title: "Heading")
          list.with_item(label: "Item one") do |item|
            item.with_leading_visual_icon(icon: :gear)
            item.with_item(label: "Active sub item", href: "/", active: true)
            item.with_item(label: "Sub item", href: "/", active: false)
          end
        end
      end

      # @label default
      #
      # @param role text
      # @param scheme [Symbol] select [full, inset]
      # @param show_dividers toggle
      def default(
        role: Primer::Alpha::ActionList::DEFAULT_ROLE,
        scheme: Primer::Alpha::ActionList::DEFAULT_SCHEME,
        show_dividers: false
      )
        render(Primer::Alpha::ActionList.new(
                 role: role,
                 scheme: scheme,
                 show_dividers: show_dividers,
                 aria: { label: "Action List" }
               )) do |c|
          c.with_item(label: "Item one", href: "/") do |item|
            item.with_leading_visual_icon(icon: :gear)
          end
          c.with_item(label: "Item two", href: "/") do |item|
            item.with_leading_visual_icon(icon: :star)
          end
          c.with_item(label: "Item three", href: "/") do |item|
            item.with_leading_visual_icon(icon: :heart)
          end
        end
      end

      # @label Divider
      #
      # @param scheme [Symbol] select [subtle, filled]
      def divider(
        scheme: Primer::Alpha::ActionList::Divider::DEFAULT_SCHEME
      )
        render(Primer::Alpha::ActionList::Divider.new(scheme: scheme))
      end

      # @label Heading
      #
      # @param scheme [Symbol] select [subtle, filled]
      # @param title text
      # @param subtitle text
      # @param list_id text
      def heading(
        scheme: Primer::Alpha::ActionList::Heading::DEFAULT_SCHEME,
        title: "This is a title",
        list_id: "unique-id",
        subtitle: "This is a subtitle"
      )
        render(Primer::Alpha::ActionList::Heading.new(scheme: scheme, list_id: list_id, title: title, subtitle: subtitle))
      end

      # @label Item [playground]
      #
      # @param label text
      # @param truncate_label toggle
      # @param href text
      # @param size [Symbol] select [medium, large, xlarge]
      # @param scheme [Symbol] select [default, danger]
      # @param disabled toggle
      # @param description text
      # @param description_scheme [Symbol] select [inline, block]
      # @param active toggle
      # @param leading_visual_icon [Symbol] octicon
      # @param leading_visual_avatar_src text
      # @param trailing_visual_icon [Symbol] octicon
      # @param trailing_visual_label text
      # @param trailing_visual_counter number
      # @param trailing_visual_text text
      # @param private_leading_action_icon [Symbol] octicon
      # @param private_trailing_action_icon [Symbol] octicon
      # @param trailing_action toggle
      # @param trailing_action_on_hover toggle
      # @param tooltip toggle
      def item(
        label: "Label",
        truncate_label: false,
        href: nil,
        size: Primer::Alpha::ActionList::Item::DEFAULT_SIZE,
        scheme: Primer::Alpha::ActionList::Item::DEFAULT_SCHEME,
        disabled: false,
        description: nil,
        description_scheme: Primer::Alpha::ActionList::Item::DEFAULT_DESCRIPTION_SCHEME,
        active: false,
        expanded: false,
        leading_visual_icon: nil,
        leading_visual_avatar_src: nil,
        trailing_visual_icon: nil,
        trailing_visual_label: nil,
        trailing_visual_counter: nil,
        trailing_visual_text: nil,
        private_leading_action_icon: nil,
        private_trailing_action_icon: nil,
        trailing_action_on_hover: false,
        trailing_action: false,
        tooltip: false
      )
        list = Primer::Alpha::ActionList.new(aria: { label: "Action List" })
        list.item(
          label: label,
          truncate_label: truncate_label,
          href: href,
          size: size,
          scheme: scheme,
          disabled: disabled,
          description_scheme: description_scheme,
          active: active,
          expanded: expanded,
          id: "tooltip-test"
        ) do |item|
          if leading_visual_icon && leading_visual_icon != :none
            item.with_leading_visual_icon(icon: leading_visual_icon)
          elsif leading_visual_avatar_src
            item.with_leading_visual_avatar(src: leading_visual_avatar_src, alt: "An avatar")
          end

          if trailing_visual_icon && trailing_visual_icon != :none
            item.with_trailing_visual_icon(icon: trailing_visual_icon)
          elsif trailing_visual_label
            item.with_trailing_visual_label { trailing_visual_label }
          elsif trailing_visual_counter
            item.with_trailing_visual_counter(count: trailing_visual_counter)
          elsif trailing_visual_text
            item.with_trailing_visual_text(trailing_visual_text)
          end

          if private_leading_action_icon && private_leading_action_icon != :none
            item.with_private_leading_action_icon(icon: private_leading_action_icon)
          elsif private_trailing_action_icon
            item.with_private_trailing_action_icon(icon: private_trailing_action_icon)
          end

          item.with_trailing_action(show_on_hover: trailing_action_on_hover, icon: "plus", "aria-label": "Button tooltip", size: :medium) if trailing_action && trailing_action != :none

          item.description { description } if description

          item.with_tooltip(text: "Tooltip text", for_id: "tooltip-test", type: :description) if tooltip
        end

        render(list)
      end

      # @label Item [default]
      def item_default
        render(Primer::Alpha::ActionList.new(
                 aria: { label: "List heading" }
               )) do |c|
          c.with_item(label: "Default item", href: "/")
        end
      end

      # @label Item [size large]
      def item_size_large
        render(Primer::Alpha::ActionList.new(
                 aria: { label: "List heading" }
               )) do |c|
          c.with_item(label: "Default item", href: "/", size: :large)
        end
      end

      # @label Item [size xlarge]
      def item_size_xlarge
        render(Primer::Alpha::ActionList.new(
                 aria: { label: "List heading" }
               )) do |c|
          c.with_item(label: "Default item", href: "/", size: :xlarge)
        end
      end

      # @label Item [leading visual]
      def item_leading_visual
        render(Primer::Alpha::ActionList.new(
                 aria: { label: "List heading" }
               )) do |c|
          c.with_item(label: "Item with leading visual", href: "/") do |item|
            item.with_leading_visual_icon(icon: :star)
          end
        end
      end

      # @label Item [trailing visual]
      def item_trailing_visual
        render(Primer::Alpha::ActionList.new(
                 aria: { label: "List heading" }
               )) do |c|
          c.with_item(label: "Item with trailing visual", href: "/") do |item|
            item.with_trailing_visual_icon(icon: :star)
          end
        end
      end

      # @label Item [leading and trailing visual]
      def item_leading_trailing_visual
        render(Primer::Alpha::ActionList.new(
                 aria: { label: "List heading" }
               )) do |c|
          c.with_item(label: "Item with trailing visual", href: "/") do |item|
            item.with_leading_visual_icon(icon: :heart)
            item.with_trailing_visual_icon(icon: :star)
          end
        end
      end

      # @label Item [description]
      def item_with_description
        render(Primer::Alpha::ActionList.new(
                 aria: { label: "List heading" }
               )) do |c|
          c.with_item(label: "Default item", href: "/") do |item|
            item.with_description.with_content("This is a description")
          end
        end
      end

      # @label Item [inline description]
      def item_with_description_inline
        render(Primer::Alpha::ActionList.new(
                 aria: { label: "List heading" }
               )) do |c|
          c.with_item(label: "Default item", href: "/", description_scheme: :inline) do |item|
            item.with_description.with_content("This is a description")
          end
        end
      end

      # @label Item [trailing action]
      def item_trailing_action
        render(Primer::Alpha::ActionList.new(
                 aria: { label: "List heading" }
               )) do |c|
          c.with_item(label: "Default item", href: "/") do |item|
            item.with_trailing_action(show_on_hover: false, icon: "plus", "aria-label": "Button tooltip", size: :medium)
          end
        end
      end

      # @label Item [trailing action on hover]
      def item_trailing_action_hover
        render(Primer::Alpha::ActionList.new(
                 aria: { label: "List heading" }
               )) do |c|
          c.with_item(label: "Default item", href: "/") do |item|
            item.with_trailing_action(show_on_hover: true, icon: "plus", "aria-label": "Button tooltip", size: :medium)
          end
        end
      end

      # @label Item [danger]
      def item_danger
        render(Primer::Alpha::ActionList.new(
                 aria: { label: "List heading" }
               )) do |c|
          c.with_item(label: "Danger item", href: "/", scheme: :danger)
        end
      end

      # @label Item [disabled]
      def item_disabled
        render(Primer::Alpha::ActionList.new(
                 aria: { label: "List heading" }
               )) do |c|
          c.with_item(label: "Disabled item", href: "/", disabled: true)
        end
      end

      # @label Item [wrap label]
      def item_wrap_label
        render(Primer::Alpha::ActionList.new(
                 aria: { label: "List heading" }
               )) do |c|
          c.with_item(label: "This is a very long string of text that will wrap if it runs out of horizontal space", href: "/")
        end
      end

      # @label Item [truncate label]
      def item_truncate_label
        render(Primer::Alpha::ActionList.new(
                 aria: { label: "List heading" }
               )) do |c|
          c.with_item(label: "This is a very long string of text that will truncate if it runs out of horizontal space", href: "/", truncate_label: true)
        end
      end

      # @label Item [active]
      def item_active
        render(Primer::Alpha::ActionList.new(
                 aria: { label: "List heading" }
               )) do |c|
          c.with_item(label: "Active item", href: "/", active: true)
        end
      end
    end
  end
end
