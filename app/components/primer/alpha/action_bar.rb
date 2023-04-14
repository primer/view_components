# frozen_string_literal: true

module Primer
  module Alpha
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class ActionBar < Primer::Component
      status :alpha

      DEFAULT_SIZE = :medium
      SIZE_MAPPINGS = {
        DEFAULT_SIZE => nil,
        :small => "ActionBar--small",
        :large => "ActionBar--large"
      }.freeze
      SIZE_OPTIONS = SIZE_MAPPINGS.keys.freeze

      renders_many :items, types: {
        icon_button: lambda { |icon:, label:, **system_arguments|
          item_id = self.class.generate_id

          with_menu_item(id: item_id, label: label) do |c|
            c.with_leading_visual_icon(icon: icon)
          end

          render(Item.new) do
            render(Primer::Beta::IconButton.new(id: item_id, icon: icon, "aria-label": label, size: @size, scheme: :invisible, **system_arguments))
          end
        },
        divider: lambda {
          @action_menu.with_divider(data: { targets: "action-bar.menuItems" }, hidden: true) if @overflow_menu
          Divider.new
        }
      }

      # @example Example goes here
      #
      #   <%= render(Primer::Alpha::ActionBar.new) { "Example" } %>
      #
      # @param size [Symbol] <%= one_of(Primer::Alpha::ActionBar::SIZE_OPTIONS) %>
      # @param overflow_menu [Boolean] Whether to render the overflow menu.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(size: Primer::Alpha::ActionBar::DEFAULT_SIZE, overflow_menu: true, **system_arguments)
        @system_arguments = system_arguments
        @overflow_menu = overflow_menu
        @system_arguments[:tag] = overflow_menu ? :"action-bar" : :div

        @size = fetch_or_fallback(Primer::Alpha::ActionBar::SIZE_OPTIONS, size, Primer::Alpha::ActionBar::DEFAULT_SIZE)

        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "ActionBar",
          SIZE_MAPPINGS[@size],
          "overflow-visible": !overflow_menu
        )
        @system_arguments[:role] = "toolbar"

        return unless overflow_menu

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
        return unless @overflow_menu

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
