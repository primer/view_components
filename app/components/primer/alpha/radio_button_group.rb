# frozen_string_literal: true

module Primer
  module Alpha
    RadioButtonGroup = Primer::FormComponents.from_input(Primer::Forms::Dsl::RadioButtonGroupInput)

    # A group of mutually exclusive radio buttons suitable for use outside a form. For a radio button
    # group suitable for use within an HTML form, see the Primer forms documentation.
    class RadioButtonGroup < Primer::Component
      status :alpha

      # @!method initialize
      #
      # @example Default
      #   <%= render(Primer::Alpha::RadioButtonGroup.new(name: :captain_default, label: "Favorite starship captain")) do |c| %>
      #     <% c.radio_button(label: "Kathryn M. Janeway", value: "janeway") %>
      #     <% c.radio_button(label: "Jean-Luc Picard", value: "picard") %>
      #     <% c.radio_button(label: "James T. Kirk", value: "kirk") %>
      #     <% c.radio_button(label: "Benjamin L. Sisko", value: "sisko") %>
      #   <% end %>
      #
      # @example Disabled
      #   <%= render(Primer::Alpha::RadioButtonGroup.new(name: :captain_disabled, label: "Favorite starship captain", disabled: true)) do |c| %>
      #     <% c.radio_button(label: "Kathryn M. Janeway", value: "janeway") %>
      #     <% c.radio_button(label: "Jean-Luc Picard", value: "picard") %>
      #     <% c.radio_button(label: "James T. Kirk", value: "kirk") %>
      #     <% c.radio_button(label: "Benjamin L. Sisko", value: "sisko") %>
      #   <% end %>
      #
      # @example With a caption
      #   <%= render(Primer::Alpha::RadioButtonGroup.new(name: :captain_caption, label: "Favorite starship captain", caption: "Make it so.")) do |c| %>
      #     <% c.radio_button(label: "Kathryn M. Janeway", value: "janeway") %>
      #     <% c.radio_button(label: "Jean-Luc Picard", value: "picard") %>
      #     <% c.radio_button(label: "James T. Kirk", value: "kirk") %>
      #     <% c.radio_button(label: "Benjamin L. Sisko", value: "sisko") %>
      #   <% end %>
      #
      # @macro form_input_attributes
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>

      # @!method radio_button
      #
      # Adds a radio button to the group.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::RadioButton) %>.
    end
  end
end
