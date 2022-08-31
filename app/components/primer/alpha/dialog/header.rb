# frozen_string_literal: true

module Primer
  module Alpha
    class Dialog
      # A `Dialog::Header` is a compositional component, used to render the
      # Header of a dialog. See <%= link_to_component(Primer::Alpha::Dialog) %>.
      class Header < Primer::Component
        # @param title [String] Describes the content of the dialog.
        # @param subtitle [String] Provides dditional context for the dialog, also setting the `aria-describedby` attribute.
        # @param show_divider [Boolean] Show a divider between the header and body.
        # @param visually_hide_title [Boolean] Visually hide the `title` while maintaining a label for assistive technologies.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(
          id:,
          title:,
          subtitle: nil,
          show_divider: false,
          visually_hide_title: false,
          **system_arguments
        )
          @id = id
          @title = title
          @subtitle = subtitle
          @visually_hide_title = visually_hide_title
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
