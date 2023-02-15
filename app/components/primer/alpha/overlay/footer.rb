# frozen_string_literal: true

module Primer
  module Alpha
    class Overlay
      DEFAULT_ALIGN_CONTENT = :end
      ALIGN_CONTENT_MAPPINGS = {
        :start => "Overlay-footer--alignStart",
        :center => "Overlay-footer--alignCenter",
        DEFAULT_ALIGN_CONTENT => "Overlay-footer--alignEnd",
      }.freeze
      ALIGN_CONTENT_OPTIONS = ALIGN_CONTENT_MAPPINGS.keys

      # A `Overlay::Footer` is a compositional component, used to render the
      # Footer of an overlay. See <%= link_to_component(Primer::Alpha::Overlay) %>.
      class Footer < Primer::Component
        # @param show_divider [Boolean] Show a divider between the footer and body.
        # @param align_content [Symbol] The alginment of contents. <%= one_of(Primer::Alpha::Overlay::ALIGN_CONTENT_OPTIONS) %>
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(
          show_divider: false,
          align_content: DEFAULT_ALIGN_CONTENT,
          **system_arguments
        )
          @system_arguments = deny_tag_argument(**system_arguments)
          @system_arguments[:tag] = :div
          @system_arguments[:classes] = class_names(
            "Overlay-footer",
            ALIGN_CONTENT_MAPPINGS[fetch_or_fallback(ALIGN_CONTENT_OPTIONS, align_content, DEFAULT_ALIGN_CONTENT)],
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
