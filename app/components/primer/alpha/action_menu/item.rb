# frozen_string_literal: true

module Primer
  module Alpha
    class ActionMenu
      # This component is part of <%= link_to_component(Primer::Alpha::ActionMenu) %> and should not be
      # used as a standalone component.
      class Item < Primer::Component
        TAG_LIST = :li
        TAG_OPTIONS = [:a, :button, :"clipboard-copy", TAG_LIST].freeze

        # @example Default
        #  <%= render Primer::Alpha::ActionMenu::Item.new do %>
        #   Quote
        #  <% end %>
        #
        # @example Link
        #  <%= render Primer::Alpha::ActionMenu::Item.new(tag: :a, href: "https://primer.style/") do %>
        #   primer.style
        #  <% end %>
        # @example Button
        #  <%= render Primer::Alpha::ActionMenu::Item.new(tag: :button, type: "button") do %>
        #   This does something
        #  <% end %>
        # @param tag [Symbol] The tag to use for the item. <%= one_of(Primer::Alpha::ActionMenu::Item::TAG_OPTIONS) %>
        # @param is_divider [Boolean] Whether to render a divider.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(tag: TAG_LIST, is_divider: false, **system_arguments)
          @is_divider = is_divider
          @tag = fetch_or_fallback(TAG_OPTIONS, tag, TAG_LIST)
          
          return if @is_divider
          
          @system_arguments = system_arguments
          @list_arguments = list_arguments
          unless is_list?
            @list_arguments[:role] = "presentation"
            @system_arguments[:role] = "menuitem"
            @system_arguments[:class] = "ActionList-content"
            @system_arguments[:tag] = @tag
          else 
            @list_arguments[:role] = "menuitem"
            @system_arguments[:tag] = :span
          end
        end
        
        def list_arguments
          args = {}
          args[:tag] = TAG_LIST
          args[:classes] = "ActionList-item"
          args[:tabindex] = -1

          args
        end

        def is_list?
          @tag == TAG_LIST
        end
      end
    end
  end
end
