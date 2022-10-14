# frozen_string_literal: true

module Primer
  module Beta
    # Use `Flash` to inform users of successful or pending actions.
    class Flash < Primer::Component
      status :beta

      # Optional action content showed on the right side of the component.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :action, lambda { |**system_arguments|
        deny_tag_argument(**system_arguments)

        Primer::Beta::Button.new(**system_arguments)
      }

      DEFAULT_SCHEME = :default
      SCHEME_MAPPINGS = {
        DEFAULT_SCHEME => "",
        :warning => "Banner--warning",
        :danger => "Banner--error",
        :success => "Banner--success"
      }.freeze
      # @example Schemes
      #   <%= render(Primer::Beta::Flash.new) { "This is a flash message!" } %>
      #   <%= render(Primer::Beta::Flash.new(scheme: :warning)) { "This is a warning flash message!" } %>
      #   <%= render(Primer::Beta::Flash.new(scheme: :danger)) { "This is a danger flash message!" } %>
      #   <%= render(Primer::Beta::Flash.new(scheme: :success)) { "This is a success flash message!" } %>
      #
      # @example Full width
      #   <%= render(Primer::Beta::Flash.new(full: true)) { "This is a full width flash message!" } %>
      #
      # @example Dismissible
      #   <%= render(Primer::Beta::Flash.new(dismissible: true)) { "This is a dismissible flash message!" } %>
      #
      # @example Icon
      #   <%= render(Primer::Beta::Flash.new(icon: :people)) { "This is a flash message with an icon!" } %>
      #
      # @example With actions
      #   <%= render(Primer::Beta::Flash.new) do |component| %>
      #     This is a flash message with actions!
      #     <% component.with_action(size: :small) { "Take action" } %>
      #   <% end %>
      #
      # @param full [Boolean] Whether the component should take up the full width of the screen.
      # @param full_when_narrow [Boolean] Whether the component should take up the full width of the screen when rendered inside smaller viewports.
      # @param dismissible [Boolean] Whether the component can be dismissed with an X button.
      # @param description [String] Description text rendered underneath the message.
      # @param icon [Symbol] Name of Octicon icon to use.
      # @param scheme [Symbol] <%= one_of(Primer::Beta::Flash::SCHEME_MAPPINGS.keys) %>
      # @param description [String] Optional description.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(full: false, full_when_narrow: false, dismissible: false, description: nil, icon: nil, scheme: DEFAULT_SCHEME, **system_arguments)
        @icon = icon
        @dismissible = dismissible
        @description = description
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "Banner",
          SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_MAPPINGS.keys, scheme, DEFAULT_SCHEME)],
          "Banner--full": full,
          "Banner--full-whenNarrow": full_when_narrow
        )
      end
    end
  end
end
