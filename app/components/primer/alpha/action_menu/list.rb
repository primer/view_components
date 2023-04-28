# typed: true
# frozen_string_literal: true

module Primer
  module Alpha
    class ActionMenu
      # This component is part of <%= link_to_component(Primer::Alpha::ActionMenu) %> and should not be
      # used as a standalone component.
      class List < Primer::Alpha::ActionList
        DEFAULT_ITEM_TAG = :button
        ITEM_TAG_OPTIONS = [:a, :button, :"clipboard-copy", DEFAULT_ITEM_TAG].freeze

        # Adds a new item to the list.
        #
        # @param data [Hash] When the menu is used as a form input (see the <%= link_to_component(Primer::Alpha::ActionMenu) %> docs), the label is submitted to the server by default. However, if the `data: { value: }` or `"data-value":` attribute is provided, it will be sent to the server instead.
        # @param system_arguments [Hash] The same arguments accepted by <%= link_to_component(Primer::Alpha::ActionList::Item) %>.
        def with_item(data: {}, **system_arguments, &block)
          content_arguments = system_arguments.delete(:content_arguments) || {}

          # rubocop:disable Style/IfUnlessModifier
          if system_arguments[:tag] && ITEM_TAG_OPTIONS.include?(system_arguments[:tag])
            content_arguments[:tag] = system_arguments[:tag]
          end
          # rubocop:enable Style/IfUnlessModifier

          # disallow setting item's tag
          system_arguments.delete(:tag)

          # rubocop:disable Style/IfUnlessModifier
          if content_arguments[:tag] == :a
            content_arguments[:href] ||= system_arguments.delete(:href)
          end
          # rubocop:enable Style/IfUnlessModifier

          content_arguments[:tabindex] = -1
          system_arguments[:autofocus] = "" if system_arguments[:autofocus]

          if system_arguments[:disabled]
            content_arguments[:aria] = merge_aria(
              content_arguments,
              { aria: { disabled: true } }
            )

            system_arguments[:aria] = merge_aria(
              system_arguments,
              { aria: { disabled: true } }
            )

            content_arguments[:disabled] = "" if content_arguments[:tag] == :button
          end

          super(data: data, **system_arguments, content_arguments: content_arguments) do |item|
            # Prevent double renders by using the capture method on the component
            # that originally received the block.
            #
            # Handle blocks that originate from C code such as `&:method` by checking
            # source_location. Such blocks don't allow access to their receiver.
            if block&.source_location
              block_context = block.binding.receiver

              if block_context.class < ActionView::Base
                block_context.capture(item, &block)
              else
                capture(item, &block)
              end
            end
          end
        end

        # @param menu_id [String] ID of the parent menu.
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList) %>
        def initialize(menu_id:, **system_arguments, &block)
          @menu_id = menu_id

          system_arguments[:aria] = merge_aria(
            system_arguments,
            { aria: { labelledby: "#{@menu_id}-button" } }
          )

          system_arguments[:role] = :menu
          system_arguments[:scheme] = :inset
          system_arguments[:id] = "#{@menu_id}-list"

          super(**system_arguments, &block)
        end
      end
    end
  end
end
