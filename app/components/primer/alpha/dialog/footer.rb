# frozen_string_literal: true

module Primer
  module Alpha
    class Dialog
      # A `Dialog::Footer` is a compositional component, used to render the
      # Footer of a dialog. See <%= link_to_component(Primer::Alpha::Dialog) %>.
      class Footer < Primer::Component
        # @param show_divider [Boolean] Show a divider between the footer and body.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(
          show_divider: false,
          **system_arguments
        )
          @system_arguments = deny_tag_argument(**system_arguments)
          @system_arguments[:tag] = :div
          @system_arguments[:classes] = class_names(
            "Overlay-footer",
            "Overlay-footer--alignEnd",
            { "Overlay-footer--divided": show_divider },
            system_arguments[:classes]
          )
        end

        def call
          render(Primer::BaseComponent.new(**@system_arguments)) { content }
        end
      end
    end
  end
end
