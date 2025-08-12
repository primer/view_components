# frozen_string_literal: true

module Primer
  module OpenProject
    # A Helper class to create an ActionMenu with a required icon on the trigger button.
    # It is meant to be used inside the SubHeader
    # Do not use standalone
    class SubHeader::Menu < Primer::Component
      status :open_project

      renders_one :show_button, lambda { |**system_arguments|
        # Do nothing as this slot is reserved for the enforced leading icon
      }

      def set_show_button(**system_arguments)
        aria_label = aria("label", system_arguments) || @label

        if @icon_only
          @menu.with_show_button(icon: @leading_icon, "aria-label": aria_label, **system_arguments)
        else
          @menu.with_show_button("aria-label": aria_label, **system_arguments) do |button|
            button.with_leading_visual_icon(icon: @leading_icon)
            button.with_trailing_action_icon(icon: @trailing_icon) unless @trailing_icon.nil?
            @label
          end
        end
      end

      # @param icon_only [Boolean] Whether the trigger button is an IconButton
      # @param leading_icon [Symbol] Name of Octicon icon to use as either leading icon or IconButton.
      # @param label [String] The button label
      # @param button_arguments [Hash] Additional arguments for the button
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(icon_only: false, leading_icon:, label:, trailing_icon: nil, button_arguments: {}, **system_arguments)
        @icon_only = icon_only
        @leading_icon = leading_icon
        @trailing_icon = trailing_icon
        @label = label

        if @label.nil? || @label.empty?
          raise ArgumentError, "You need to provide a valid label."
        end

        @button_arguments = button_arguments

        @menu = Primer::Alpha::ActionMenu.new(**system_arguments)
      end

      delegate :with_item, :with_divider, :with_avatar_item, :with_group, :with_sub_menu_item,
               to: :@menu

      def before_render
        if show_button
          raise ArgumentError,
                "Do not use the show_button slot within the SubHeader, as it is reserved. Instead provide a leading_icon within the subHeader button slot"
        end
      end

      def call
        render(@menu) do
          set_show_button(**@button_arguments)
          content
        end
      end
    end
  end
end
