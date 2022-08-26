# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module Alpha
    # @label ActionBar
    class ActionBarPreview < ViewComponent::Preview
      # @label Playground
      # @param string_example text
      # @param boolean_example toggle
      # @param email_example email
      # @param number_example number
      # @param url_example url
      # @param tel_example tel
      # @param textarea_example textarea
      # @param select_example select [one, two, three]
      # @param select_custom_labels select [[One label, one], [Two label, two], [Three label, three]]
      # With empty option (`~` in YAML)
      # @param select_empty_option select [~, one, two, three]
      def playground
        render(Primer::Alpha::ActionBar.new) do |component|
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
          component.with_item_icon_button(icon: :paperclip, "aria-label": "Attach Image")
          component.with_item_icon_button(icon: :mention, "aria-label": "Mention")
          component.with_item_icon_button(icon: :"cross-reference", "aria-label": "Reference")
          component.with_item_icon_button(icon: :reply, "aria-label": "Reply")
          component.with_item_icon_button(icon: :"diff-ignored", "aria-label": "Slash command")
        end
      end
    end
  end
end
