# typed: true
# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module Alpha
    # @label ActionBar
    class ActionBarPreview < ViewComponent::Preview
      # @label Default
      def default
        render(Primer::Alpha::ActionBar.new) do |component|
          component.with_item_icon_button(icon: :search, label: "Search")
          component.with_item_icon_button(icon: :pencil, label: "Edit")
          component.with_item_icon_button(icon: :archive, label: "Archive")
          component.with_item_divider
          component.with_item_icon_button(icon: :heart, label: "Heart")
          component.with_item_icon_button(icon: :bookmark, label: "Bookmark")
          component.with_item_icon_button(icon: :mention, label: "Mention")
          component.with_item_divider
          component.with_item_icon_button(icon: :paperclip, label: "Attach")
        end
      end

      # @label Inline with other components
      def inline; end

      # @label Playground
      # @param size [Symbol] select [[Small, small], [Medium, medium], [Large, large]]
      # @param overflow_menu [Boolean]
      def playground(size: :medium, overflow_menu: true)
        render(Primer::Alpha::ActionBar.new(size: size, overflow_menu: overflow_menu)) do |component|
          component.with_item_icon_button(icon: :search, label: "Search")
          component.with_item_icon_button(icon: :pencil, label: "Edit")
          component.with_item_icon_button(icon: :archive, label: "Archive")
          component.with_item_divider
          component.with_item_icon_button(icon: :heart, label: "Heart")
          component.with_item_icon_button(icon: :bookmark, label: "Bookmark")
          component.with_item_icon_button(icon: :mention, label: "Mention")
          component.with_item_divider
          component.with_item_icon_button(icon: :paperclip, label: "Attach")
        end
      end
    end
  end
end
