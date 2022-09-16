# frozen_string_literal: true

module Primer
  module Experimental
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class ActionBar < Primer::Component
      status :experimental

      SIZE_DEFAULT = :medium
      SIZE_MAPPINGS = {
        SIZE_DEFAULT => nil,
        :small => "ActionBar--small",
        :large => "ActionBar--large"
      }.freeze
      SIZE_OPTIONS = SIZE_MAPPINGS.keys.freeze

      renders_many :items, types: {
        icon_button: lambda { |**system_arguments|
          Primer::Experimental::ActionBar::Item.new(slot_type: :icon_button, size: @size, **system_arguments)
        },
        divider: lambda { |**system_arguments|
          Primer::Experimental::ActionBar::Item.new(
            slot_type: :divider,
            tag: :hr,
            classes: class_names(
              system_arguments[:classes],
              "ActionBar-divider"
            ),
            **system_arguments
          )
        }
      }

      # @example Example goes here
      #
      #   <%= render(Primer::Experimental::ActionBar.new) { "Example" } %>
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(size: Primer::Beta::Button::DEFAULT_SIZE, **system_arguments)
        @menu_id = "action-bar-overflow-menu-#{SecureRandom.hex(4)}"
        @system_arguments = system_arguments
        @system_arguments[:tag] = :"action-bar"

        @size = fetch_or_fallback(Primer::Beta::Button::SIZE_OPTIONS, size, Primer::Beta::Button::DEFAULT_SIZE)

        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "ActionBar",
          SIZE_MAPPINGS[@size]
        )
        @system_arguments[:role] = "toolbar"
      end

      def render?
        items.any?
      end

      # :no_doc:
      class Item < Primer::Component
        status :experimental

        SLOT_TYPES = [:icon_button, :divider].freeze
        SLOT_TYPE_DEFAULT = :icon_button

        attr_reader :icon, :label, :menu_arguments

        def initialize(slot_type:, **system_arguments)
          @item_type = fetch_or_fallback(SLOT_TYPES, slot_type, SLOT_TYPE_DEFAULT)
          @system_arguments = system_arguments
          @menu_arguments = system_arguments.dup
          @menu_arguments.delete(:icon)
          @menu_arguments.delete(:"aria-label")

          return unless slot_type?(:icon_button)

          @menu_arguments[:tag] = system_arguments[:tag] || :button
          @menu_arguments[:classes] = "ActionList-content"
          @icon = system_arguments[:icon]
          @label = system_arguments[:"aria-label"]
        end

        def slot_type?(type)
          @item_type == type
        end

        def call
          if slot_type?(:icon_button)
            render Primer::Beta::IconButton.new(wrapper_arguments: { "data-targets": "action-bar.items" }, scheme: :invisible, **@system_arguments)
          else
            render Primer::BaseComponent.new("data-targets": "action-bar.items", **@system_arguments)
          end
        end
      end
    end
  end
end
