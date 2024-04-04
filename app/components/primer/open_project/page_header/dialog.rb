# frozen_string_literal: true

module Primer
  module OpenProject
    class PageHeader
      # A Helper class to create ActionMenus inside the PageHeader action slot
      # Do not use standalone
      class Dialog < Primer::Component
        status :open_project

        # @param dialog_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::Dialog) %>.
        # @param button_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Beta::Button) %> or <%= link_to_component(Primer::Beta::IconButton) %>, depending on the value of the `icon:` argument.
        def initialize(dialog_arguments: {}, button_arguments: {})
          callback = button_arguments.delete(:button_block)

          @dialog = Primer::Alpha::Dialog.new(**dialog_arguments)
          @button = @dialog.with_show_button(**button_arguments) do |button|
            callback&.call(button)
          end
        end

        def render_in(view_context, &block)
          super(view_context) do
            block&.call(@dialog, @button)
          end
        end

        def before_render
          content
        end

        def call
          render(@dialog)
        end
      end
    end
  end
end
