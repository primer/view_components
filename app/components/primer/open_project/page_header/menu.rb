# frozen_string_literal: true

module Primer
  module OpenProject
    class PageHeader
      # A Helper class to create ActionMenus inside the PageHeader action slot
      # It should not be used standalone
      class Menu < Primer::Component
        status :open_project

        # @param menu_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionMenu) %>.
        # @param button_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Beta::Button) %> or <%= link_to_component(Primer::Beta::IconButton) %>, depending on the value of the `icon:` argument.
        def initialize(menu_arguments: {}, button_arguments: {})
          callback = button_arguments.delete(:button_block)

          @menu = Primer::Alpha::ActionMenu.new(**menu_arguments)
          @button = @menu.with_show_button(**button_arguments) do |button|
            callback&.call(button)
          end
        end

        def render_in(view_context, &block)
          super(view_context) do
            block&.call(@menu, @button)
          end
        end

        def before_render
          content
        end

        def call
          render(@menu)
        end
      end
    end
  end
end
