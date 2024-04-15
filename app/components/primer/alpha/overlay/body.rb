# frozen_string_literal: true

module Primer
  module Alpha
    class Overlay
      # A `Overlay::Body` is a compositional component, used to render the
      # Body of an overlay. See <%= link_to_component(Primer::Alpha::Overlay) %>.
      class Body < Primer::Component

        attr_reader :tab_arguments, :tab_label

        # @param tab_arguments [Hash] Arguments passed to TabPanels component
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(padding: DEFAULT_PADDING, tab_label: nil, tab_arguments: {}, **system_arguments)
          @system_arguments = deny_tag_argument(**system_arguments)
          @system_arguments[:tag] = :div
          @system_arguments[:classes] = class_names(
            "Overlay-body",
            PADDING_MAPPINGS[fetch_or_fallback(PADDING_OPTIONS, padding, DEFAULT_PADDING)],
            system_arguments[:classes]
          )
          @tab_arguments = tab_arguments
          @tab_label = tab_label
        end

        def call
          render(Primer::BaseComponent.new(**@system_arguments)) { content }
        end
      end
    end
  end
end
