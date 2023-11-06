# typed: true
# frozen_string_literal: true

module Primer
  module Alpha
    class ActionMenu
      # This component is part of <%= link_to_component(Primer::Alpha::ActionMenu) %> and should not be
      # used as a standalone component.
      class Group < Primer::Alpha::ActionList
        DEFAULT_ITEM_TAG = :button
        ITEM_TAG_OPTIONS = [:a, :"clipboard-copy", DEFAULT_ITEM_TAG].freeze

        # Heading text rendered above the list of items.
        #
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionMenu::Heading) %>.
        def with_heading(**system_arguments, &block)
          super(component_klass: Primer::Alpha::ActionMenu::Heading, **system_arguments, &block)
        end

        # Adds a new item to the list.
        #
        # @param data [Hash] When the menu is used as a form input (see the <%= link_to_component(Primer::Alpha::ActionMenu) %> docs), the label is submitted to the server by default. However, if the `data: { value: }` or `"data-value":` attribute is provided, it will be sent to the server instead.
        # @param system_arguments [Hash] These arguments are forwarded to <%= link_to_component(Primer::Alpha::ActionList::Item) %>, or whatever class is passed as the `component_klass` argument.
        def with_item(data: {}, **system_arguments, &block)
          system_arguments = organize_arguments(data: data, **system_arguments)

          super(**system_arguments) do |item|
            evaluate_block(item, &block)
          end
        end

        # Adds an avatar item to the list. Avatar items are a convenient way to accessibly add an item with a leading avatar image.
        #
        # @param src [String] The source url of the avatar image.
        # @param username [String] The username associated with the avatar.
        # @param full_name [String] Optional. The user's full name.
        # @param full_name_scheme [Symbol] Optional. How to display the user's full name. <%= one_of(Primer::Alpha::ActionList::Item::DESCRIPTION_SCHEME_OPTIONS) %>
        # @param data [Hash] When the menu is used as a form input (see the <%= link_to_component(Primer::Alpha::ActionMenu) %> docs), the label is submitted to the server by default. However, if the `data: { value: }` or `"data-value":` attribute is provided, it will be sent to the server instead.
        # @param avatar_arguments [Hash] Optional. The arguments accepted by <%= link_to_component(Primer::Beta::Avatar) %>.
        # @param system_arguments [Hash] These arguments are forwarded to <%= link_to_component(Primer::Alpha::ActionList::Item) %>, or whatever class is passed as the `component_klass` argument.
        def with_avatar_item(src:, username:, full_name: nil, full_name_scheme: Primer::Alpha::ActionList::Item::DEFAULT_DESCRIPTION_SCHEME, data: {}, avatar_arguments: {}, **system_arguments, &block)
          system_arguments = organize_arguments(data: data, **system_arguments)

          super(src: src, username: username, full_name: full_name, full_name_scheme: full_name_scheme, avatar_arguments: avatar_arguments, **system_arguments) do |item|
            evaluate_block(item, &block)
          end
        end

        def with_divider
          raise "ActionMenu groups cannot have dividers"
        end

        private

        def evaluate_block(*args, &block)
          # Prevent double renders by using the capture method on the component
          # that originally received the block.
          #
          # Handle blocks that originate from C code such as `&:method` by checking
          # source_location. Such blocks don't allow access to their receiver.
          return unless block&.source_location

          block_context = block.binding.receiver

          if block_context.class < ActionView::Base
            block_context.capture(*args, &block)
          else
            capture(*args, &block)
          end
        end

        def organize_arguments(data: {}, **system_arguments)
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

          content_arguments[:data] = merge_data(
            content_arguments,
            { data: { value: data.delete(:value) || system_arguments.delete(:"data-value") } }
          )

          if system_arguments[:disabled]
            content_arguments[:aria] = merge_aria(
              content_arguments,
              { aria: { disabled: true } }
            )

            system_arguments[:aria] = merge_aria(
              system_arguments,
              { aria: { disabled: true } }
            )
          end

          { data: data, **system_arguments, content_arguments: content_arguments }
        end
      end
    end
  end
end
