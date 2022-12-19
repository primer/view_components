# frozen_string_literal: true

module Primer
  module Beta
    # Use `DetailsComponent` to reveal content after clicking a button.
    class Details < Primer::Component
      status :beta

      BODY_TAG_DEFAULT = :div
      BODY_TAG_OPTIONS = [:ul, :"details-menu", :"details-dialog", BODY_TAG_DEFAULT].freeze
      NO_OVERLAY = :none
      OVERLAY_MAPPINGS = {
        NO_OVERLAY => "",
        :default => "details-overlay",
        :dark => "details-overlay details-overlay-dark"
      }.freeze

      # Use the Summary slot as a trigger to reveal the content.
      #
      # @param button [Boolean] (true) Whether to render the Summary as a button or not.
      # @param kwargs [Hash] The same arguments as <%= link_to_system_arguments_docs %>.
      renders_one :summary, lambda { |button: true, **system_arguments|
        system_arguments[:tag] = :summary
        system_arguments[:role] = "button"

        return Primer::BaseComponent.new(**system_arguments) unless button

        # rubocop:disable Primer/ComponentNameMigration
        Primer::ButtonComponent.new(**system_arguments)
        # rubocop:enable Primer/ComponentNameMigration
      }

      # Use the Body slot as the main content to be shown when triggered by the Summary.
      #
      # @param tag [Symbol] (Primer::Beta::Details::BODY_TAG_DEFAULT) <%= one_of(Primer::Beta::Details::BODY_TAG_OPTIONS) %>
      # @param kwargs [Hash] The same arguments as <%= link_to_system_arguments_docs %>.
      renders_one :body, lambda { |tag: BODY_TAG_DEFAULT, **system_arguments|
        system_arguments[:tag] = fetch_or_fallback(BODY_TAG_OPTIONS, tag, BODY_TAG_DEFAULT)

        Primer::BaseComponent.new(**system_arguments)
      }

      # @example Default
      #
      #   <%= render Primer::Beta::Details.new do |component| %>
      #     <% component.with_summary do %>
      #       Summary
      #     <% end %>
      #     <% component.with_body do %>
      #       Body
      #     <% end %>
      #   <% end %>
      #
      # @param overlay [Symbol] Dictates the type of overlay to render with. <%= one_of(Primer::Beta::Details::OVERLAY_MAPPINGS.keys) %>
      # @param reset [Boolean] Defaults to false. If set to true, it will remove the default caret and remove style from the summary element
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(overlay: NO_OVERLAY, reset: false, **system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :details
        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          OVERLAY_MAPPINGS[fetch_or_fallback(OVERLAY_MAPPINGS.keys, overlay, NO_OVERLAY)],
          "details-reset" => reset
        )
      end

      def render?
        summary.present? && body.present?
      end
    end
  end
end
