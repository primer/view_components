# frozen_string_literal: true

module Primer
  module Beta
    # Use `Flash` to inform users of successful or pending actions.
    class Flash < Banner
      status :beta

      # @example Schemes
      #   <div style="display: grid; row-gap: 15px">
      #     <%= render(Primer::Beta::Flash.new) { "This is a flash message!" } %>
      #     <%= render(Primer::Beta::Flash.new(scheme: :warning)) { "This is a warning flash message!" } %>
      #     <%= render(Primer::Beta::Flash.new(scheme: :danger)) { "This is a danger flash message!" } %>
      #     <%= render(Primer::Beta::Flash.new(scheme: :success)) { "This is a success flash message!" } %>
      #   </div>
      #
      # @example Full width
      #   <%= render(Primer::Beta::Flash.new(full: true)) { "This is a full width flash message!" } %>
      #
      # @example Dismissible
      #   <%= render(Primer::Beta::Flash.new(dismissible: true, reappear: true)) { "This is a dismissible flash message!" } %>
      #
      # @example Custom icon
      #   <%= render(Primer::Beta::Flash.new(icon: :people)) { "This is a flash message with an icon!" } %>
      #
      # @example With action button
      #   <%= render(Primer::Beta::Flash.new) do |component| %>
      #     This is a flash message with actions!
      #     <% component.with_action_button(size: :small) { "Take action" } %>
      #   <% end %>
      #
      # @example With custom action
      #   <%= render(Primer::Beta::Flash.new) do |component| %>
      #     Comment saved!
      #     <% component.with_action_content do %>
      #       <%= render(Primer::IconButton.new(icon: :pencil, mr: 1, "aria-label": "Edit")) %>
      #     <% end %>
      #   <% end %>
      #
      # @param system_arguments [Hash] The same arguments as <%= link_to_component(Primer::Beta::Banner) %>.
      def initialize(**system_arguments)
        super

        @message_arguments[:aria] ||= {}
        @message_arguments[:aria][:atomic] = "true"
        @message_arguments[:aria][:live] = "true"
        @message_arguments[:role] = @scheme == :danger ? "alert" : "status"
      end

      # @!parse
      #   # A button or custom content that will render on the right-hand side of the component.
      #   #
      #   # To render a button, call the `with_action_button` method, which accepts the arguments accepted by <%= link_to_component(Primer::Beta::Button) %>.
      #   #
      #   # To render custom content, call the `with_action_content` method and pass a block that returns HTML.
      #   renders_one :action

      private

      def custom_element_name
        "x-flash"
      end
    end
  end
end
