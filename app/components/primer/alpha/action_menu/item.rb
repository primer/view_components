# frozen_string_literal: true

module Primer
  module Alpha
    class ActionMenu
      # This component is part of <%= link_to_component(Primer::Alpha::ActionMenu) %> and should not be
      # used as a standalone component.
      class Item < Primer::Component
        LIST_TAG = :li
        TAG_OPTIONS = [:a, :button, :"clipboard-copy", :span, LIST_TAG].freeze

        # @example Default
        #  <%= render Primer::Alpha::ActionMenu::Item.new do %>
        #   Quote
        #  <% end %>
        #
        # @example Link
        #  <%= render Primer::Alpha::ActionMenu::Item.new(tag: :a, href: "https://primer.style/") do %>
        #   primer.style
        #  <% end %>
        #
        # @example Button
        #  <%= render Primer::Alpha::ActionMenu::Item.new(tag: :button, type: "button") do %>
        #   This does something
        #  <% end %>
        #
        # @example clipboard-copy
        #  <%= render Primer::Alpha::ActionMenu::Item.new(tag: :"clipboard-copy", value: "Text to be copied") do %>
        #   Copy text
        #  <% end %>
        # @param tag [Symbol] Optional. The tag to use for the item. <%= one_of(Primer::Alpha::ActionMenu::Item::TAG_OPTIONS) %>
        # @param is_divider [Boolean] Whether to render a divider.
        # @param is_dangerous [Boolean] If item should be styled dangerously.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(tag: :span, is_divider: false, is_dangerous: false, **system_arguments)
          @is_divider = is_divider
          @is_dangerous = is_dangerous
          @tag = fetch_or_fallback(TAG_OPTIONS, tag, :span)

          return if @is_divider

          @system_arguments = system_arguments
          @list_arguments = list_arguments
          @system_arguments[:classes] = class_names(
            system_arguments[:classes],
            "ActionList-content"
          )

          return if is_list?

          @system_arguments[:tag] = @tag
          @system_arguments[:role] = "menuitem"
          @system_arguments[:tabindex] = -1
        end

        def list_arguments
          args = {}
          args[:role] = "none"
          args[:tag] = LIST_TAG

          if @is_dangerous == true
            args[:classes] = "ActionList-item ActionList-item--danger"
          else
            args[:classes] = "ActionList-item"
          end

          args
        end

        def is_list?
          @tag == LIST_TAG
        end
      end
    end
  end
end
