# frozen_string_literal: true

module Primer
  module Alpha
    class Overlay
      # A `Overlay::Header` is a compositional component, used to render the
      # Header of an overlay. See <%= link_to_component(Primer::Alpha::Overlay) %>.
      class Header < Primer::Component
        DEFAULT_SIZE = :medium
        SIZE_MAPPINGS = {
          DEFAULT_SIZE => nil,
          :large => "Overlay-header--large"
        }.freeze
        SIZE_OPTIONS = SIZE_MAPPINGS.keys

        # Optional filter slot for adding a filter input to the header.
        #
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        renders_one :filter, lambda { |**system_arguments|
          system_arguments[:tag] = :div
          system_arguments[:classes] = class_names(
            "Overlay-headerFilter",
            system_arguments[:classes]
          )
          Primer::BaseComponent.new(**system_arguments)
        }

        # @param title [String] Describes the content of the Overlay.
        # @param subtitle [String] Provides additional context for the Overlay, also setting the `aria-describedby` attribute.
        # @param overlay_id [String] Provides the id of the overlay element so the close button can close it
        # @param size [Symbol] The size of the Header. <%= one_of(Primer::Alpha::Overlay::Header::SIZE_OPTIONS) %>
        # @param divider [Boolean] Show a divider between the header and body.
        # @param visually_hide_title [Boolean] Visually hide the `title` while maintaining a label for assistive technologies.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(
          id:,
          title:,
          overlay_id: nil,
          subtitle: nil,
          size: DEFAULT_SIZE,
          divider: false,
          visually_hide_title: false,
          **system_arguments
        )
          @overlay_id = overlay_id
          @id = id
          @title = title
          @subtitle = subtitle
          @visually_hide_title = visually_hide_title
          @system_arguments = deny_tag_argument(**system_arguments)
          @system_arguments[:tag] = :header
          @system_arguments[:classes] = class_names(
            "Overlay-header",
            { "Overlay-header--divided": divider },
            SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, DEFAULT_SIZE)],
            system_arguments[:classes]
          )
        end
      end
    end
  end
end
