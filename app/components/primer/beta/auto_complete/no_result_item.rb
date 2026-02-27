# frozen_string_literal: true

module Primer
  module Beta
    class AutoComplete
      # Use `NoResultItem` to display a message when no autocomplete results are found.
      # Renders as a simple div inside the overlay, not as a list item.
      class NoResultItem < Primer::Component
        status :beta

        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(**system_arguments)
          @system_arguments = deny_tag_argument(**system_arguments)
          @system_arguments[:tag] = :div
          @system_arguments[:"data-no-result-found"] = true
          @system_arguments[:"aria-hidden"] = true

          @system_arguments[:classes] = class_names(
            "p-2",
            "color-fg-muted",
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
