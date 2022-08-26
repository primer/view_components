# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module Alpha
    # @label ActionBar
    class ActionBarPreview < ViewComponent::Preview
      # @param direction [Symbol] select [[Horizontal, horizontal], [Vertical, vertical]]
      # @param aria_label [String]
      def playground(direction: :horizontal)
        render(Primer::Alpha::ActionBar.new(direction: direction)) do |component|
          component.with_item_icon_button(icon: :heading, "aria-label": "Heading")
          component.with_item_icon_button(icon: :bold, "aria-label": "Bold")
          component.with_item_icon_button(icon: :italic, "aria-label": "Italic")
          component.with_item_icon_button(icon: :quote, "aria-label": "Quote")
          component.with_item_icon_button(icon: :code, "aria-label": "Code")
          component.with_item_icon_button(icon: :link, "aria-label": "Link")
          component.with_item_divider
          component.with_item_icon_button(icon: :"list-ordered", "aria-label": "List ordered")
          component.with_item_icon_button(icon: :"list-unordered", "aria-label": "List unordered")
          component.with_item_icon_button(icon: :tasklist, "aria-label": "Tasklist")
          component.with_item_divider
          component.with_item_icon_button(icon: :mention, "aria-label": "Mention")
          component.with_item_icon_button(icon: :"cross-reference", "aria-label": "Reference")
          component.with_item_icon_button(icon: :reply, "aria-label": "Reply")
          component.with_item_icon_button(icon: :"diff-ignored", "aria-label": "Slash command")
          component.with_item_icon_button(icon: :paperclip, "aria-label": "Attach Image")
        end
      end
    end
  end
end
