# typed: true
# frozen_string_literal: true

module Primer
  module Alpha
    class ActionMenu
      # This component is part of <%= link_to_component(Primer::Alpha::ActionMenu) %> and should not be
      # used as a standalone component.
      #
      # One of the following is required to apply functionality to the menu item: <%= one_of(Primer::Alpha::ActionMenu::List::ACTION_OPTIONS) %>
      class List < Primer::Alpha::ActionList
        DEFAULT_ITEM_TAG = :span
        ITEM_TAG_OPTIONS = [:a, :button, :"clipboard-copy", DEFAULT_ITEM_TAG].freeze
        ITEM_ACTION_OPTIONS = [:classes, :onclick, :href, :value].freeze

        DEFAULT_SELECT_VARIANT = :none
        SELECT_VARIANT_OPTIONS = [
          :single,
          :multiple,
          DEFAULT_SELECT_VARIANT
        ].freeze

        ACTION_LIST_ITEM_ARGS = Primer::Alpha::ActionList::Item
          .instance_method(:initialize)
          .parameters
          .each_with_object([]) do |(arg_type, arg), memo|
            memo << arg if arg_type == :keyreq || arg_type == :key
          end
          .freeze

        # Adds a new item to the list.
        #
        # @param system_arguments [Hash] The same arguments accepted by <%= link_to_component(Primer::Alpha::ActionList::Item) %>.
        def with_item(**system_arguments, &block)
          content_arguments = system_arguments.delete(:content_arguments) || {}
          list_item_arguments = system_arguments.slice(*ACTION_LIST_ITEM_ARGS)

          content_arguments[:tag] =
            if system_arguments[:tag] && ITEM_TAG_OPTIONS.include?(system_arguments[:tag])
              system_arguments[:tag]
            elsif list_item_arguments[:href] && !list_item_arguments[:disabled]
              :a
            else
              DEFAULT_ITEM_TAG
            end

          if content_arguments[:tag] == :a
            content_arguments[:href] = list_item_arguments.delete(:href)
          end

          list_item_arguments[:tabindex] = -1
          list_item_arguments[:autofocus] = "" if list_item_arguments[:autofocus]

          if list_item_arguments[:disabled]
            content_arguments[:aria] = merge_aria(
              content_arguments,
              { aria: { disabled: true } }
            )

            list_item_arguments[:aria] = merge_aria(
              list_item_arguments,
              { aria: { disabled: true } }
            )

            content_arguments[:disabled] = "" if content_arguments[:tag] == :button
          end

          super(
            **list_item_arguments,
            content_arguments: content_arguments,
            &block
          )
        end

        # @param menu_id [String] ID of the parent menu.
        def initialize(menu_id:, select_variant:, **system_arguments, &block)
          @menu_id = menu_id

          system_arguments[:aria] = merge_aria(
            system_arguments,
            { aria: { labelledby: self.menu_id } }
          )

          system_arguments[:role] = :menu
          system_arguments[:scheme] = :inset
          system_arguments[:id] = list_id

          select_variant = fetch_or_fallback(SELECT_VARIANT_OPTIONS, select_variant, DEFAULT_SELECT_VARIANT)

          super(select_variant: select_variant, **system_arguments, &block)
        end

        def menu_id
          "#{@menu_id}-text"
        end

        def list_id
          "#{@menu_id}-list"
        end
      end
    end
  end
end
