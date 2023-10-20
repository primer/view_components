# frozen_string_literal: true

# :nocov:

module Primer
  module Alpha
    class ActionBar
      # ActionBar::Item is an internal component that wraps the items in a div with the `ActionBar-item` class.
      class Item < Primer::Component
        # @param item_content [String] The content to render inside the item.
        # @param item_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(item_content, **item_arguments)
          @system_arguments = {
            tag: item_arguments[:tag] || :div,
            data: {
              targets: "action-bar.items"
            }.merge(item_arguments[:data] || {}),
            classes: class_names("ActionBar-item", item_arguments[:classes])
          }

          @item_content = item_content
        end

        def call
          render(Primer::BaseComponent.new(**@system_arguments)) { render(@item_content) }
        end
      end
    end
  end
end
