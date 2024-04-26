# frozen_string_literal: true

module Primer
  module Alpha
    class Dialog
      # A `Dialog::Header` is a compositional component, used to render the
      # Header of a dialog. See <%= link_to_component(Primer::Alpha::Dialog) %>.
      class Header < Primer::Component
        status :alpha
        audited_at "2022-10-10"

        DEFAULT_VARIANT = :medium
        VARIANT_MAPPINGS = {
          DEFAULT_VARIANT => "",
          :large => "Overlay-header--large"
        }.freeze
        VARIANT_OPTIONS = VARIANT_MAPPINGS.keys

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

                # Optional subtitle slot for adding a subtitle to the header.
        #
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        renders_one :subtitle, lambda { |**system_arguments|
          raise ArgumentError, "Do not use the subtitle slot if you are passing subtitle in as an argument" if @subtitle.present? && !Rails.env.production?

          system_arguments[:tag] = :h2
          system_arguments[:classes] = class_names(
            "Overlay-description",
            system_arguments[:classes]
          )
          Primer::BaseComponent.new(**system_arguments)
        }

        # @param id [String] The HTML element's ID value.
        # @param title [String] Describes the content of the dialog.
        # @param subtitle [String] Provides additional context for the dialog, also setting the `aria-describedby` attribute.
        # @param show_divider [Boolean] Show a divider between the header and body.
        # @param visually_hide_title [Boolean] Visually hide the `title` while maintaining a label for assistive technologies.
        # @param variant [Symbol] <%= one_of(Primer::Alpha::Dialog::Header::VARIANT_OPTIONS) %>
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(
          id:,
          title:,
          subtitle: nil,
          show_divider: false,
          visually_hide_title: false,
          variant: DEFAULT_VARIANT,
          **system_arguments
        )
          @id = id
          @title = title
          @subtitle = subtitle
          @visually_hide_title = visually_hide_title
          @system_arguments = deny_tag_argument(**system_arguments)
          @system_arguments[:tag] = :div

          @system_arguments[:classes] = class_names(
            "Overlay-header",
            VARIANT_MAPPINGS[fetch_or_fallback(VARIANT_OPTIONS, variant, DEFAULT_VARIANT)],
            { "Overlay-header--divided": show_divider },
            system_arguments[:classes]
          )
        end
      end
    end
  end
end
