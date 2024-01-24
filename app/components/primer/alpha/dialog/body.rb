# frozen_string_literal: true

module Primer
  module Alpha
    class Dialog
      # A `Dialog::Body` is a compositional component, used to render the
      # Body of a dialog. See <%= link_to_component(Primer::Alpha::Dialog) %>.
      class Body < Primer::Component
        status :alpha
        audited_at "2022-10-10"

        DEFAULT_PADDING = :normal
        PADDING_MAPPINGS = {
          DEFAULT_PADDING => "",
          :condensed => "Overlay-body--paddingCondensed",
          :none => "Overlay-body--paddingNone"
        }.freeze
        PADDING_OPTIONS = PADDING_MAPPINGS.keys

        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(
          padding: DEFAULT_PADDING,
          **system_arguments
        )
          @padding = padding
          @system_arguments = deny_tag_argument(**system_arguments)
          @system_arguments[:tag] = :div
          @system_arguments[:classes] = class_names(
            "Overlay-body",
            PADDING_MAPPINGS[fetch_or_fallback(PADDING_MAPPINGS, padding, DEFAULT_PADDING)],
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
