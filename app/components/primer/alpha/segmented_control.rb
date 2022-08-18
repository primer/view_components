# frozen_string_literal: true

module Primer
  module Alpha
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class SegmentedControl < Primer::Component
      status :alpha

      FULL_WIDTH_DEFAULT = false

      # Use to render a button and an associated panel slot. See the example below or refer to <%= link_to_component(Primer::Navigation::TabComponent) %>.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :buttons, "Primer::Alpha::SegmentedControl::Button"

      # @example Basic usage
      #
      #   <%= render(Primer::Alpha::SegmentedControl.new) do |c| %>
      #     <%= c.with_button(selected: true) { "Preview" } %>
      #     <%= c.with_button { "Raw" } %>
      #     <%= c.with_button { "Blame" } %>
      #   <% end %>
      #
      # @example With icons
      #   <%= render(Primer::Alpha::SegmentedControl.new) do |c| %>
      #     <%= c.with_button(icon: :eye, selected: true) { "Preview" } %>
      #     <%= c.with_button(icon: :"file-code") { "Raw" } %>
      #     <%= c.with_button(icon: :people) { "Blame" } %>
      #   <% end %>
      #
      # @example With icons only
      #   <%= render(Primer::Alpha::SegmentedControl.new) do |c| %>
      #     <%= c.with_button(icon: :eye, icon_only: :always, selected: true) { "Preview" } %>
      #     <%= c.with_button(icon: :"file-code", icon_only: :always) { "Raw" } %>
      #     <%= c.with_button(icon: :people, icon_only: :always) { "Blame" } %>
      #   <% end %>
      #
      # @example With icons only when narrow
      #   <%= render(Primer::Alpha::SegmentedControl.new) do |c| %>
      #     <%= c.with_button(icon: :eye, icon_only: :when_narrow, selected: true) { "Preview" } %>
      #     <%= c.with_button(icon: :"file-code", icon_only: :when_narrow) { "Raw" } %>
      #     <%= c.with_button(icon: :people, icon_only: :when_narrow) { "Blame" } %>
      #   <% end %>
      #
      # @example Fill width of parent
      #   <%= render(Primer::Alpha::SegmentedControl.new(full_width: true)) do |c| %>
      #     <%= c.with_button(icon: :eye, selected: true) { "Preview" } %>
      #     <%= c.with_button(icon: :"file-code") { "Raw" } %>
      #     <%= c.with_button(icon: :people) { "Blame" } %>
      #   <% end %>
      #
      # @param full_width [Boolean] If the component should be full width
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(full_width: FULL_WIDTH_DEFAULT, **system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "SegmentedControl",
          "SegmentedControl--fullWidth": full_width
        )
      end
    end
  end
end
