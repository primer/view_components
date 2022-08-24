# frozen_string_literal: true

module Primer
  module Alpha
    class Dialog
      # A `Dialog::Header` is a compositional component, used to render the
      # Header of a dialog. See <%= link_to_component(Primer::Alpha::Dialog) %>.
      class Header < Primer::Component
        # @param title [String] The title of the dialog.
        # @param subtitle [String] The subtitle of the dialog. This will also set the `aria-describedby` attribute.
        # @param show_divider [Boolean] If true the visual dividing line between the body and footer will be visible
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(
          id:,
          title:,
          subtitle: nil,
          subtitle_id: nil,
          show_divider: true,
          **system_arguments
        )
          @id = id
          @title = title
          @subtitle = subtitle
          @system_arguments = deny_tag_argument(**system_arguments)
          @system_arguments[:tag] = :header
          @system_arguments[:classes] = class_names(
            "Overlay-header",
            { "Overlay-header--divided": show_divider },
            system_arguments[:classes]
          )
        end
      end
    end
  end
end
