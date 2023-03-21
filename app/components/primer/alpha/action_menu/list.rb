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
        ITEM_ROLE_MAP = {
          single: "menuitemradio",
          multiple: "menuitemcheckbox",
          default: "menuitem"
        }.freeze

        # Adds a new item to the list.
        #
        # @param label [String] The text to display for the item. If not provided, the content will be used instead.
        # @param tag [Symbol] Optional. The tag to use for the item. <%= one_of(Primer::Alpha::ActionMenu::TAG_OPTIONS) %>
        # @param is_dangerous [Boolean] If item should be styled dangerously. Equivalent to passing `scheme: :danger`.
        # @param disabled [Boolean] Set to true if the item should appear disabled and ignore user interaction.
        # @param hidden [Boolean] Set to true if the item should be hidden.
        # @param label_classes [Array] An array of classes (strings) to apply to the label.
        # @param label_arguments [Hash] A set of <%= link_to_system_arguments %> to apply to the label.
        # @param content_arguments [Hash] <%= link_to_system_arguments %> passed to the link, button, etc.
        def with_item(label: nil, tag: DEFAULT_ITEM_TAG, active: false, is_dangerous: false, disabled: false, hidden: false, label_classes: "", label_arguments: {}, autofocus: false, **content_arguments, &block)
          content_arguments[:tag] = fetch_or_fallback(ITEM_TAG_OPTIONS, tag, DEFAULT_ITEM_TAG)

          list_item_arguments = {}
          list_item_arguments[:scheme] = :danger if is_dangerous
          list_item_arguments[:role] = ITEM_ROLE_MAP.fetch(select_variant, ITEM_ROLE_MAP[:default])
          list_item_arguments[:tabindex] = -1
          list_item_arguments[:autofocus] = "" if autofocus

          if disabled
            content_arguments[:aria] = merge_aria(
              content_arguments,
              { aria: { disabled: true } }
            )

            list_item_arguments[:aria] = { disabled: true }
            content_arguments[:disabled] = "" if content_arguments[:tag] == :button
          end

          # rubocop:disable Style/IfUnlessModifier
          unless content_arguments.each_key.any? { |key| ITEM_ACTION_OPTIONS.include?(key.to_sym) }
            raise ArgumentError, "One of the following are required to apply functionality: #{ITEM_ACTION_OPTIONS.to_sentence(last_word_connector: ' or ')}"
          end
          # rubocop:enable Style/IfUnlessModifier

          super(
            label: label,
            disabled: disabled,
            hidden: hidden,
            active: active,
            **list_item_arguments,
            label_classes: label_classes,
            label_arguments: label_arguments,
            content_arguments: content_arguments,
            &block
          )
        end

        # @param menu_id [String] ID of the parent menu.
        def initialize(menu_id:, **system_arguments, &block)
          @menu_id = menu_id

          system_arguments[:aria] = merge_aria(
            system_arguments,
            { aria: { labelledby: self.menu_id } }
          )

          system_arguments[:role] = "menu"
          system_arguments[:scheme] = :inset
          system_arguments[:id] = list_id

          super(**system_arguments, &block)
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
