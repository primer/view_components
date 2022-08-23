# frozen_string_literal: true

module Primer
  module Alpha
    # @label ActionList
    class ActionListPreview < ViewComponent::Preview
      # @label List
      #
      # @param role text
      #
      # @param label text
      # @param truncate_label toggle
      # @param href text
      # @param size [Symbol] select [small, medium, large]
      # @param scheme [Symbol] select [default, danger]
      # @param disabled toggle
      # @param description text
      # @param description_scheme [Symbol] select [inline, block]
      # @param select_mode [Symbol] select [none, single, multiple]
      # @param checked toggle
      # @param active toggle
      # @param leading_visual_icon [Symbol] octicon
      # @param leading_visual_avatar_src text
      # @param trailing_visual_icon [Symbol] octicon
      # @param trailing_visual_label text
      # @param trailing_visual_counter number
      # @param trailing_visual_text text
      # @param leading_action_button_icon [Symbol] octicon
      # @param trailing_action_button_icon [Symbol] octicon
      def list(
        role: Primer::Alpha::ActionList::DEFAULT_ROLE,
        label: "Label",
        truncate_label: false,
        href: nil,
        size: Primer::Alpha::ActionList::Item::DEFAULT_SIZE,
        scheme: Primer::Alpha::ActionList::Item::DEFAULT_SCHEME,
        disabled: false,
        description: nil,
        description_scheme: Primer::Alpha::ActionList::Item::DEFAULT_DESCRIPTION_SCHEME,
        select_mode: Primer::Alpha::ActionList::Item::DEFAULT_SELECT_MODE,
        checked: false,
        active: false,
        expanded: false,
        leading_visual_icon: nil,
        leading_visual_avatar_src: nil,
        trailing_visual_icon: nil,
        trailing_visual_label: nil,
        trailing_visual_counter: nil,
        trailing_visual_text: nil,
        leading_action_button_icon: nil,
        trailing_action_button_icon: nil
      )
        render(Primer::Alpha::ActionList.new(role: role)) do |list|
          add_item_to(
            list,
            label: label,
            truncate_label: truncate_label,
            href: href,
            size: size,
            scheme: scheme,
            disabled: disabled,
            description: description,
            description_scheme: description_scheme,
            select_mode: select_mode,
            checked: checked,
            active: active,
            expanded: expanded,
            leading_visual_icon: leading_visual_icon,
            leading_visual_avatar_src: leading_visual_avatar_src,
            trailing_visual_icon: trailing_visual_icon,
            trailing_visual_label: trailing_visual_label,
            trailing_visual_counter: trailing_visual_counter,
            trailing_visual_text: trailing_visual_text,
            leading_action_button_icon: leading_action_button_icon,
            trailing_action_button_icon: trailing_action_button_icon
          )
        end
      end

      # @label Item
      #
      # @param label text
      # @param truncate_label toggle
      # @param href text
      # @param size [Symbol] select [small, medium, large]
      # @param scheme [Symbol] select [default, danger]
      # @param disabled toggle
      # @param description text
      # @param description_scheme [Symbol] select [inline, block]
      # @param select_mode [Symbol] select [none, single, multiple]
      # @param checked toggle
      # @param active toggle
      # @param leading_visual_icon [Symbol] octicon
      # @param leading_visual_avatar_src text
      # @param trailing_visual_icon [Symbol] octicon
      # @param trailing_visual_label text
      # @param trailing_visual_counter number
      # @param trailing_visual_text text
      # @param leading_action_button_icon [Symbol] octicon
      # @param trailing_action_button_icon [Symbol] octicon
      def item(
        label: "Label",
        truncate_label: false,
        href: nil,
        size: Primer::Alpha::ActionList::Item::DEFAULT_SIZE,
        scheme: Primer::Alpha::ActionList::Item::DEFAULT_SCHEME,
        disabled: false,
        description: nil,
        description_scheme: Primer::Alpha::ActionList::Item::DEFAULT_DESCRIPTION_SCHEME,
        select_mode: Primer::Alpha::ActionList::Item::DEFAULT_SELECT_MODE,
        checked: false,
        active: false,
        expanded: false,
        leading_visual_icon: nil,
        leading_visual_avatar_src: nil,
        trailing_visual_icon: nil,
        trailing_visual_label: nil,
        trailing_visual_counter: nil,
        trailing_visual_text: nil,
        leading_action_button_icon: nil,
        trailing_action_button_icon: nil
      )
        list = Primer::Alpha::ActionList.new
        add_item_to(
          list,
          label: label,
          truncate_label: truncate_label,
          href: href,
          size: size,
          scheme: scheme,
          disabled: disabled,
          description: description,
          description_scheme: description_scheme,
          select_mode: select_mode,
          checked: checked,
          active: active,
          expanded: expanded,
          leading_visual_icon: leading_visual_icon,
          leading_visual_avatar_src: leading_visual_avatar_src,
          trailing_visual_icon: trailing_visual_icon,
          trailing_visual_label: trailing_visual_label,
          trailing_visual_counter: trailing_visual_counter,
          trailing_visual_text: trailing_visual_text,
          leading_action_button_icon: leading_action_button_icon,
          trailing_action_button_icon: trailing_action_button_icon
        )
        render(list.items.first)
      end

      private

      def add_item_to(
        list,
        label: "Label",
        truncate_label: false,
        href: nil,
        size: Primer::Alpha::ActionList::Item::DEFAULT_SIZE,
        scheme: Primer::Alpha::ActionList::Item::DEFAULT_SCHEME,
        disabled: false,
        description: nil,
        description_scheme: Primer::Alpha::ActionList::Item::DEFAULT_DESCRIPTION_SCHEME,
        select_mode: Primer::Alpha::ActionList::Item::DEFAULT_SELECT_MODE,
        checked: false,
        active: false,
        expanded: false,
        leading_visual_icon: nil,
        leading_visual_avatar_src: nil,
        trailing_visual_icon: nil,
        trailing_visual_label: nil,
        trailing_visual_counter: nil,
        trailing_visual_text: nil,
        leading_action_button_icon: nil,
        trailing_action_button_icon: nil
      )
        list.item(
          root: nil,
          label: label,
          truncate_label: truncate_label,
          href: href,
          size: size,
          scheme: scheme,
          disabled: disabled,
          description_scheme: description_scheme,
          select_mode: select_mode,
          checked: checked,
          active: active,
          expanded: expanded
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

          item.with_leading_action_button(icon: leading_action_button_icon, "aria-label": "Button") if leading_action_button_icon && leading_action_button_icon != :none

          item.with_trailing_action_button(icon: trailing_action_button_icon, "aria-label": "Button") if trailing_action_button_icon && trailing_action_button_icon != :none

          item.description { description } if description
        end
      end
    end
  end
end
