# frozen_string_literal: true

module Primer
  module Alpha
    # @label ActionList
    class ActionListPreview < ViewComponent::Preview
      # @label Sub lists
      def sub_lists
        render(Primer::Alpha::ActionList.new) do |list|
          list.with_heading(title: "Heading")
          list.with_item(label: "Item one", href: "/") do |item|
            item.with_leading_visual_icon(icon: :gear)
          end
          list.with_list do |sub_list|
            sub_list.with_item(label: "Sub item one", href: "/") do |item|
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
            item.with_item(label: "Sub item", href: "/") do |sub_item|
              sub_item.with_leading_visual_icon(icon: :gear)
            end
          end
        end
      end

      # @label List
      #
      # @param role text
      # @param scheme [Symbol] select [full, inset]
      # @param show_dividers toggle
      def list(
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
      # @param section_id text
      def heading(
        scheme: Primer::Alpha::ActionList::Heading::DEFAULT_SCHEME,
        title: "This is a title",
        section_id: "unique-id",
        subtitle: "This is a subtitle"
      )
        render(Primer::Alpha::ActionList::Heading.new(scheme: scheme, section_id: section_id, title: title, subtitle: subtitle))
      end

      # @label Item
      #
      # @param label text
      # @param truncate_label toggle
      # @param href text
      # @param size [Symbol] select [medium, large, xlarge]
      # @param scheme [Symbol] select [default, danger]
      # @param disabled toggle
      # @param description text
      # @param description_scheme [Symbol] select [inline, block]
      # @param checked toggle
      # @param active toggle
      # @param leading_visual_icon [Symbol] octicon
      # @param leading_visual_avatar_src text
      # @param private_trailing_action_svg toggle
      # @param trailing_visual_icon [Symbol] octicon
      # @param trailing_visual_label text
      # @param trailing_visual_counter number
      # @param trailing_visual_text text
      # @param trailing_action [Symbol] octicon
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
        private_leading_action_svg: true,
        trailing_visual_icon: nil,
        trailing_visual_label: nil,
        trailing_visual_counter: nil,
        trailing_visual_text: nil,
        trailing_action: nil,
        private_trailing_action_svg: true
      )
        list = Primer::Alpha::ActionList.new(aria: { label: "Action List" })
        list.item(
          root: nil,
          label: label,
          truncate_label: truncate_label,
          href: href,
          size: size,
          scheme: scheme,
          disabled: disabled,
          description_scheme: description_scheme,
          active: active,
          expanded: expanded,
          id: "tooltip-test",
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

          if private_leading_action_svg
            item.with_private_leading_action_svg.with_content("leading")
          end

          if private_trailing_action_svg
            item.with_private_trailing_action_svg.with_content("trailing")
          end

          if trailing_action && trailing_action != :none
            item.with_trailing_action(show_on_hover: true, icon: trailing_action, "aria-label": "Button tooltip", size: :medium)
          end

          item.description { description } if description

          item.with_tooltip(text: "Tooltip text", for_id: "tooltip-test", type: :description)
        end

        render(list)
      end
    end
  end
end
