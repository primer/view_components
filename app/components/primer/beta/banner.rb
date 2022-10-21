# frozen_string_literal: true

module Primer
  module Beta
    # Use `Banner` to highlight important information.
    class Banner < Primer::Component
      status :beta

      # A button or custom content that will render on the right-hand side of the component.
      #
      # To render a button, call the `with_action_button` method, which accepts the arguments accepted by <%= link_to_component(Primer::Beta::Button) %>.
      #
      # To render custom content, call the `with_action_content` method and pass a block that returns HTML.
      renders_one :action, types: {
        button: lambda { |**system_arguments|
          deny_tag_argument(**system_arguments)

          Primer::Beta::Button.new(**system_arguments)
        },

        content: lambda { |**system_arguments|
          deny_tag_argument(**system_arguments)
          system_arguments[:tag] = :div

          Primer::BaseComponent.new(**system_arguments)
        }
      }

      DEFAULT_SCHEME = :default
      SCHEME_MAPPINGS = {
        DEFAULT_SCHEME => "",
        :warning => "Banner--warning",
        :danger => "Banner--error",
        :success => "Banner--success"
      }.freeze

      DEFAULT_ICONS = {
        default: :bell,
        warning: :alert,
        danger: :stop,
        success: :"check-circle"
      }.freeze

      # @example Schemes
      #   <div style="display: grid; row-gap: 15px">
      #     <%= render(Primer::Beta::Banner.new) { "This is a banner message!" } %>
      #     <%= render(Primer::Beta::Banner.new(scheme: :warning)) { "This is a warning banner!" } %>
      #     <%= render(Primer::Beta::Banner.new(scheme: :danger)) { "This is a danger banner!" } %>
      #     <%= render(Primer::Beta::Banner.new(scheme: :success)) { "This is a success banner!" } %>
      #   </div>
      #
      # @example Full width
      #   <%= render(Primer::Beta::Banner.new(full: true)) { "This is a full width banner!" } %>
      #
      # @example Dismissible
      #   <%= render(Primer::Beta::Banner.new(dismissible: true, reappear: true)) { "This is a dismissible banner!" } %>
      #
      # @example Custom icon
      #   <%= render(Primer::Beta::Banner.new(icon: :people)) { "This is a banner with a custom icon!" } %>
      #
      # @example With action button
      #   <%= render(Primer::Beta::Banner.new) do |component| %>
      #     This is a banner with an action button!
      #     <% component.with_action_button(size: :small) { "Take action" } %>
      #   <% end %>
      #
      # @example With custom action
      #   <%= render(Primer::Beta::Banner.new) do |component| %>
      #     Comment saved!
      #     <% component.with_action_content do %>
      #       <%= render(Primer::IconButton.new(icon: :pencil, mr: 1, "aria-label": "Edit")) %>
      #     <% end %>
      #   <% end %>
      #
      # @param full [Boolean] Whether the component should take up the full width of the screen.
      # @param full_when_narrow [Boolean] Whether the component should take up the full width of the screen when rendered inside smaller viewports.
      # @param dismissible [Boolean] Whether the component can be dismissed with an "x" button.
      # @param description [String] Description text rendered underneath the message.
      # @param icon [Symbol] The name of an <%= link_to_octicons %> icon to use. If no icon is provided, a default one will be chosen based on the scheme.
      # @param scheme [Symbol] <%= one_of(Primer::Beta::Banner::SCHEME_MAPPINGS.keys) %>
      # @param reappear [Boolean] Whether or not the flash banner should reappear after being dismissed. Only for use in test and preview environments.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(full: false, full_when_narrow: false, dismissible: false, description: nil, icon: nil, scheme: DEFAULT_SCHEME, reappear: false, **system_arguments)
        @scheme = fetch_or_fallback(SCHEME_MAPPINGS.keys, scheme, DEFAULT_SCHEME)
        @icon = icon || DEFAULT_ICONS[@scheme]
        @dismissible = dismissible
        @description = description
        @reappear = reappear

        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :div
        @system_arguments[:data] ||= {}
        @system_arguments[:data][:target] = catalyst_target(field: "root")
        @system_arguments[:data][:reappear] = @reappear if @reappear
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "Banner",
          SCHEME_MAPPINGS[@scheme],
          "Banner--full": full,
          "Banner--full-whenNarrow": full_when_narrow
        )

        @message_arguments = {
          tag: :div,
          classes: "Banner-message"
        }

        @wrapper_arguments = {
          tag: custom_element_name
        }
      end

      private

      def custom_element_name
        "x-banner"
      end

      def catalyst_action(event:, function:)
        "#{event}:#{custom_element_name}##{function}"
      end

      def catalyst_target(field:)
        "#{custom_element_name}.#{field}"
      end
    end
  end
end
