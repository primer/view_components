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

      renders_many :items, types: {
        icon: lambda { |icon:, label:, **system_arguments|
          item_id = self.class.generate_id

          IconItem.new(id: item_id, icon: icon, "aria-label": label, **system_arguments).tap do
            with_menu_item(id: item_id, label: label) do |c|
              c.with_leading_visual_icon(icon: icon)
            end
          end
        },

        divider: lambda { |**system_arguments|
          Item.new(tag: :hr, classes: "ActionBar-divider", **system_arguments).tap do
            @action_menu.with_divider(data: { targets: "action-bar.menuItems" }, hidden: true)
          end
        }
      }

      # @example Example goes here
      #
      #   <%= render(Primer::Alpha::ActionBar.new) { "Example" } %>
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(size: Primer::Beta::Button::DEFAULT_SIZE, **system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = :"action-bar"

        @size = fetch_or_fallback(Primer::Beta::Button::SIZE_OPTIONS, size, Primer::Beta::Button::DEFAULT_SIZE)

        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "ActionBar",
          SIZE_MAPPINGS[@size]
        )
        @system_arguments[:role] = "toolbar"

        @action_menu = Primer::Alpha::ActionMenu.new(
          menu_id: self.class.generate_id,
          "data-target": "action-bar.moreMenu",
          hidden: true,
          classes: "ActionBar-more-menu",
          anchor_align: :end
        )
      end

      private

      def with_menu_item(id:, **system_arguments, &block)
        system_arguments = {
          **system_arguments,
          "data-targets": "action-bar.menuItems",
          hidden: true,
          tag: :button,
          type: "button",
          "data-for": id,
          "data-action": "click:action-bar#menuItemClick"
        }

        @action_menu.with_item(
          value: "",
          **system_arguments,
          &block
        )
      end

      def render?
        items.any?
      end

      def before_render
        content
      end
    end
  end
end
