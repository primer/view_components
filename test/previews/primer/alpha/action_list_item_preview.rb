# frozen_string_literal: true

module Primer
  module Alpha
    class ActionListItemPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param label text
      # @param truncate_label toggle
      # @param size [Symbol] select [small, medium, large]
      # @param variant [Symbol] select [default, danger]
      # @param disabled toggle
      # @param description_display [Symbol] select [inline, block]
      # @param select_mode [Symbol] select [none, single, multiple]
      # @param checked toggle
      # @param leading_visual_icon [Symbol] octicon
      # @param leading_visual_avatar_src text
      # @param trailing_visual_icon [Symbol] octicon
      # @param trailing_visual_label text
      # @param trailing_visual_counter number
      # @param trailing_visual_text text
      def playground(
        label: "Item",
        truncate_label: false,
        size: Primer::Alpha::ActionListItem::DEFAULT_SIZE,
        variant: Primer::Alpha::ActionListItem::DEFAULT_VARIANT,
        disabled: false,
        description_display: Primer::Alpha::ActionListItem::DEFAULT_DESCRIPTION_DISPLAY,
        select_mode: Primer::Alpha::ActionListItem::DEFAULT_SELECT_MODE,
        checked: false,
        leading_visual_icon: nil,
        leading_visual_avatar_src: nil,
        trailing_visual_icon: nil,
        trailing_visual_label: nil,
        trailing_visual_counter: nil,
        trailing_visual_text: nil
      )
        item = Primer::Alpha::ActionListItem.new(
          label: label,
          truncate_label: truncate_label,
          size: size,
          variant: variant,
          disabled: disabled,
          description_display: description_display,
          select_mode: select_mode,
          checked: checked
        )

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

        render(Primer::BaseComponent.new(tag: :ul, classes: "ActionList")) do |ul|
          item.render_in(ul)
        end
      end
    end
  end
end
