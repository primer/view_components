# frozen_string_literal: true

module Primer
  # Use `DetailsComponent` to reveal content after clicking a button.
  class DetailsComponent < Primer::Component
    status :beta

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

      Primer::ButtonComponent.new(**system_arguments)
    }

    # Use the Body slot as the main content to be shown when triggered by the Summary.
    #
    # @param kwargs [Hash] The same arguments as <%= link_to_system_arguments_docs %>.
    renders_one :body, lambda { |**system_arguments|
      system_arguments[:tag] ||= :div # rubocop:disable Primer/NoTagMemoize
      Primer::BaseComponent.new(**system_arguments)
    }

    # @example Default
    #
    #   <%= render Primer::DetailsComponent.new do |c| %>
    #     component.summary do
    #       "Summary"
    #     end
    #     component.body do
    #       "Body"
    #     end
    #   <% end %>
    #
    # @param overlay [Symbol] Dictates the type of overlay to render with. <%= one_of(Primer::DetailsComponent::OVERLAY_MAPPINGS.keys) %>
    # @param reset [Boolean] Defatuls to false. If set to true, it will remove the default caret and remove style from the summary element
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(overlay: NO_OVERLAY, reset: false, **system_arguments)
      @system_arguments = system_arguments
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
