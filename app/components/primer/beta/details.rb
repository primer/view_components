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
      ARIA_LABEL_OPEN_DEFAULT = "Collapse"
      ARIA_LABEL_CLOSED_DEFAULT = "Expand"

      attr_reader :disabled
      alias disabled? disabled

      attr_reader :open
      alias open? open

      # Use the Summary slot as the target for toggling the Details content open/closed.
      #
      # @param button [Boolean] Whether or not to render the summary element as a button.
      # @param aria_label_open [String] Defaults to "Collapse". Value to announce when details element is open.
      # @param aria_label_closed [String] Defaults to "Expand". Value to announce when details element is closed.
      renders_one :summary, lambda { |button: true, **system_arguments|
        system_arguments[:tag] = :summary
        system_arguments[:role] = "button"

        aria_label_closed = system_arguments[:aria_label_closed]
        aria_label_open = system_arguments[:aria_label_open]

        data_attributes = {
          target: "details-toggle.summaryTarget",
          action: "click:details-toggle#toggle",
        }

        # Only add aria-label data attributes if explicitly provided
        if aria_label_closed || aria_label_open
          data_attributes[:aria_label_closed] = aria_label_closed || ARIA_LABEL_CLOSED_DEFAULT
          data_attributes[:aria_label_open] = aria_label_open || ARIA_LABEL_OPEN_DEFAULT
        end

        system_arguments[:data] = merge_data(
          system_arguments, {
            data: data_attributes
          }
        )

        aria_attributes = { expanded: open? }
        # Only add aria-label if explicitly provided
        if aria_label_closed || aria_label_open
          current_label = open? ? (aria_label_open || ARIA_LABEL_OPEN_DEFAULT) : (aria_label_closed || ARIA_LABEL_CLOSED_DEFAULT)
          aria_attributes[:label] = current_label
        end

        system_arguments[:aria] = merge_aria(
          system_arguments, {
            aria: aria_attributes
          }
        )

        if disabled?
          # rubocop:disable Primer/ComponentNameMigration
          Primer::ButtonComponent.new(**system_arguments, disabled: true)
          # rubocop:enable Primer/ComponentNameMigration
        elsif button
          # rubocop:disable Primer/ComponentNameMigration
          Primer::ButtonComponent.new(**system_arguments)
          # rubocop:enable Primer/ComponentNameMigration
        else
          Primer::BaseComponent.new(**system_arguments)
        end
      }

      # Use the Body slot as the main content to be shown when triggered by the Summary.
      #
      # @param tag [Symbol] (Primer::Beta::Details::BODY_TAG_DEFAULT) <%= one_of(Primer::Beta::Details::BODY_TAG_OPTIONS) %>
      # @param kwargs [Hash] The same arguments as <%= link_to_system_arguments_docs %>.
      renders_one :body, lambda { |tag: BODY_TAG_DEFAULT, **system_arguments|
        system_arguments[:tag] = fetch_or_fallback(BODY_TAG_OPTIONS, tag, BODY_TAG_DEFAULT)

        Primer::BaseComponent.new(**system_arguments)
      }

      # @param overlay [Symbol] Dictates the type of overlay to render with. <%= one_of(Primer::Beta::Details::OVERLAY_MAPPINGS.keys) %>
      # @param reset [Boolean] Defaults to false. If set to true, it will remove the default caret and remove style from the summary element
      # @param disabled [Boolean] Whether or not to disable the summary button.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(overlay: NO_OVERLAY, reset: false, disabled: false, **system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :details
        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          OVERLAY_MAPPINGS[fetch_or_fallback(OVERLAY_MAPPINGS.keys, overlay, NO_OVERLAY)],
          "details-reset" => reset
        )
        @system_arguments[:data] = merge_data(
          @system_arguments, {
            data: {
              target: "details-toggle.detailsTarget",
            }
          }
        )
        # https://developer.mozilla.org/en-US/docs/Web/HTML/Element/details#open
        @open = !!@system_arguments[:open]
        @disabled = disabled
        @summary_info = nil
      end

      def render?
        summary.present? && body.present?
      end
    end
  end
end
