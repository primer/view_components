# frozen_string_literal: true

module Primer
  module Alpha
    # `Dropdown` is a lightweight context menu for housing navigation and actions.
    # They're great for instances where you don't need the full power (and code) of the SelectMenu.
    class Dropdown < Primer::Component
      status :alpha

      # Required trigger for the dropdown. Has the same arguments as <%= link_to_component(Primer::ButtonComponent) %>,
      # but it is locked as a `summary` tag.
      renders_one :button, lambda { |**system_arguments|
        @button_arguments = system_arguments
        @button_arguments[:button] = true
        @button_arguments[:dropdown] = @with_caret

        Primer::Content.new
      }

      # Required context menu for the dropdown.
      #
      # @param as [Symbol] When `as` is `:list`, wraps the menu in a `<ul>` with a `<li>` for each item.
      # @param direction [Symbol] <%= one_of(Primer::Alpha::Dropdown::Menu::DIRECTION_OPTIONS) %>
      # @param scheme [Symbol] Pass `:dark` for dark mode theming
      # @param header [String] Optional string to display as the header
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :menu, "Primer::Alpha::Dropdown::Menu"

      # @param overlay [Symbol] <%= one_of(Primer::Beta::Details::OVERLAY_MAPPINGS.keys) %>
      # @param with_caret [Boolean] Whether or not a caret should be rendered in the button.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(overlay: :default, with_caret: false, **system_arguments)
        @with_caret = with_caret

        @system_arguments = system_arguments
        @system_arguments[:overlay] = overlay
        @system_arguments[:reset] = true
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "dropdown"
        )
      end

      def render?
        button? && menu?
      end
    end
  end
end
