# frozen_string_literal: true

module Primer
  module Alpha
    class Overlay
      DEFAULT_PADDING = :normal
      PADDING_MAPPINGS = {
        :normal => nil,
        :condensed => "Overlay-body--paddingCondensed",
        :none => "Overlay-body--paddingNone",
      }.freeze
      PADDING_OPTIONS = PADDING_MAPPINGS.keys


      # A `Overlay::Body` is a compositional component, used to render the
      # Body of an overlay. See <%= link_to_component(Primer::Alpha::Overlay) %>.
      class Body < Primer::Component
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(padding: DEFAULT_PADDING, **system_arguments)
          @system_arguments = deny_tag_argument(**system_arguments)
          @system_arguments[:tag] = :div
          @system_arguments[:classes] = class_names(
            "Overlay-body",
            PADDING_MAPPINGS[fetch_or_fallback(PADDING_OPTIONS, padding, DEFAULT_PADDING)],
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
