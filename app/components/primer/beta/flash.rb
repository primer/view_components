# frozen_string_literal: true

module Primer
  module Beta
    # This component has been deprecated. Use [Banner](<%= link_to_component(Primer::Alpha::Banner) %>) instead.
    #
    # Use `Flash` to inform users of successful or pending actions.
    class Flash < Primer::Component
      status :deprecated

      # Optional action content showed on the right side of the component.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :action, lambda { |**system_arguments|
        deny_tag_argument(**system_arguments)
        system_arguments[:tag] = :div
        system_arguments[:classes] = class_names(system_arguments[:classes], "flash-action")

        Primer::BaseComponent.new(**system_arguments)
      }

      DEFAULT_SCHEME = :default
      SCHEME_MAPPINGS = {
        DEFAULT_SCHEME => "",
        :warning => "flash-warn",
        :danger => "flash-error",
        :success => "flash-success"
      }.freeze

      # @param full [Boolean] Whether the component should take up the full width of the screen.
      # @param spacious [Boolean] Whether to add margin to the bottom of the component.
      # @param dismissible [Boolean] Whether the component can be dismissed with an X button.
      # @param icon [Symbol] Name of Octicon icon to use.
      # @param scheme [Symbol] <%= one_of(Primer::Beta::Flash::SCHEME_MAPPINGS.keys) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(full: false, spacious: false, dismissible: false, icon: nil, scheme: DEFAULT_SCHEME, **system_arguments)
        @icon = icon
        @dismissible = dismissible
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "flash",
          SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_MAPPINGS.keys, scheme, DEFAULT_SCHEME)],
          "flash-full": full
        )
        @system_arguments[:mb] ||= spacious ? 4 : nil
      end
    end
  end
end
