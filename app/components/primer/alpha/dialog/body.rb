# frozen_string_literal: true

module Primer
  module Alpha
    class Dialog
      # A `Dialog::Body` is a compositional component, used to render the
      # Body of a dialog. See <%= link_to_component(Primer::Alpha::Dialog) %>.
      class Body < Primer::Component
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(**system_arguments)
          @system_arguments = deny_tag_argument(**system_arguments)
          @system_arguments[:tag] = :div
          @system_arguments[:classes] = class_names(
            "Overlay-body",
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
