# frozen_string_literal: true

module Primer
  module Alpha
    class ActionListItemPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param label text
      # @param truncate_label toggle
      # @param href text
      # @param role text
      # @param size [Symbol] select [small, medium, large]
      # @param variant [Symbol] select [default, danger]
      # @param disabled toggle
      # @param description text
      # @param description_variant [Symbol] select [inline, block]
      # @param select_mode [Symbol] select [none, single, multiple]
      # @param checked toggle
      # @param selected toggle
      # @param active toggle
      # @param has_sub_item toggle
      # @param sub_item toggle
      # @param show_on_hover toggle
      # @param leading_action_button toggle
      # @param trailing_action_button toggle
      # @param leading_visual_icon [Symbol] octicon
      # @param leading_visual_avatar_src text
      # @param trailing_visual_icon [Symbol] octicon
      # @param trailing_visual_label text
      # @param trailing_visual_counter number
      # @param trailing_visual_text text
      # @param leading_action_visual [Symbol] octicon
      # @param leading_action_icon_button [Symbol] octicon
      # @param trailing_action_visual [Symbol] octicon
      # @param trailing_action_icon_button [Symbol] octicon
      def playground(
        label: "Item Item ItemItemItemItem ItemItemItemItemItem",
        truncate_label: false,
        href: nil,
        role: nil,
        size: Primer::Alpha::ActionListItem::DEFAULT_SIZE,
        variant: Primer::Alpha::ActionListItem::DEFAULT_VARIANT,
        disabled: false,
        description: nil,
        description_variant: Primer::Alpha::ActionListItem::DEFAULT_DESCRIPTION_VARIANT,
        select_mode: Primer::Alpha::ActionListItem::DEFAULT_SELECT_MODE,
        checked: false,
        selected: false,
        active: false,
        has_sub_item: false,
        sub_item: false,
        show_on_hover: false,
        leading_action_button: false,
        trailing_action_button: false,
        leading_visual_icon: nil,
        leading_visual_avatar_src: nil,
        trailing_visual_icon: nil,
        trailing_visual_label: nil,
        trailing_visual_counter: nil,
        trailing_visual_text: nil,
        leading_action_icon_button: nil,
        trailing_action_icon_button: nil,
        leading_action_visual: nil,
        trailing_action_visual: nil
      )
        item = Primer::Alpha::ActionListItem.new(
          label: label,
          truncate_label: truncate_label,
          role: role,
          size: size,
          variant: variant,
          disabled: disabled,
          description: description,
          description_variant: description_variant,
          select_mode: select_mode,
          checked: checked,
          selected: selected,
          active: active,
          has_sub_item: has_sub_item,
          sub_item: sub_item,
          href: href,
          show_on_hover: show_on_hover,
          leading_action_button: leading_action_button,
          trailing_action_button: trailing_action_button,
          leading_action_visual: leading_action_visual
        )

        if leading_action_icon_button
            item.with_leading_action_button_button(icon: leading_action_icon_button, "aria-label": "test")
        end

        if leading_action_visual
            item.with_leading_action_visual_icon(icon: leading_action_visual)
        end

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

        if trailing_action_visual
            item.with_trailing_action_visual_icon(icon: trailing_action_visual)
        end

        if trailing_action_icon_button
            item.with_trailing_action_button_button(icon: trailing_action_icon_button, "aria-label": "test")
        end

        item.description { description } if description

        render(Primer::BaseComponent.new(tag: :ul, classes: "ActionList")) do |ul|
          item.render_in(ul)
        end
      end
    end
  end
end
