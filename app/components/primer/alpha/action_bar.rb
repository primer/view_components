# frozen_string_literal: true

module Primer
  module Alpha
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class ActionBar < Primer::Component
      status :alpha

      SIZE_DEFAULT = :medium
      SIZE_MAPPINGS = {
        SIZE_DEFAULT => nil,
        :small => "ActionBar--small",
        :large => "ActionBar--large"
      }.freeze
      SIZE_OPTIONS = SIZE_MAPPINGS.keys.freeze

      renders_many :items, "Item"
      renders_many :menu_items, "MenuItem"

      # renders_many :items, types: {
      #   icon_button: lambda { |**system_arguments|
      #     Primer::Experimental::ActionBar::Item.new(slot_type: :icon_button, size: @size, **system_arguments)
      #   },
      #   divider: lambda { |**system_arguments|
      #     Primer::Experimental::ActionBar::Item.new(
      #       slot_type: :divider,
      #       tag: :hr,
      #       classes: class_names(
      #         system_arguments[:classes],
      #         "ActionBar-divider"
      #       ),
      #       **system_arguments
      #     )
      #   }
      # }

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

      def before_render
        menu_items.clear
        items.each do |item|
          with_menu_item(id: item.id, is_divider: item.is_divider) do |c|
            c.with_leading_visual_icon(icon: item.icon) if item.icon
            item.label
          end
        end
      end

      class MenuItem < Primer::Alpha::ActionMenu::Item
        def initialize(id:, is_divider: false, **system_arguments)
          super(value: "", is_divider: is_divider, **system_arguments)
          if @list_arguments
            @list_arguments[:"data-targets"] = "action-bar.menuItems"
            @list_arguments[:hidden] = true
          end

          if is_divider
            @system_arguments[:hidden] = true
            @system_arguments[:"data-targets"] = "action-bar.menuItems"
            return
          end

          @system_arguments[:tag] = :button
          @system_arguments[:type] = "button"
          @system_arguments[:"data-for"] = id
          @system_arguments[:"data-action"] = "click:action-bar#menuItemClick"
        end
      end

      class Item < Primer::Component
        attr_reader :id, :label, :icon, :is_divider
        def initialize(id: nil, label: nil, icon: nil, is_divider: false, **system_arguments)
          @is_divider = is_divider
          @id = id
          @label = label
          @icon = icon
          @system_arguments = system_arguments
          @system_arguments[:tag] = :div
          @system_arguments[:"data-targets"] = "action-bar.items"
          @system_arguments[:classes] = class_names(
            system_arguments[:classes],
            "ActionBar-item",
            "ActionBar-divider" => is_divider
          )
          if is_divider
            @system_arguments[:tag] = :hr
          end
        end

        def call
          render Primer::BaseComponent.new(**@system_arguments) do
            content
          end
        end
      end
    end
  end
end
