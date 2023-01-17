# frozen_string_literal: true

module Primer
  module Alpha
    SelectList = Primer::FormComponents.from_input(Primer::Forms::Dsl::SelectListInput)

    # A select list suitable for use outside a form. For a select list input suitable for use
    # within an HTML form, see the `Primer::Forms` namespace.
    class SelectList < Primer::Component
      status :alpha

      # @!method initialize
      #
      # @example Default
      #   <%= render(Primer::Alpha::SelectList.new(name: :places, label: "Places")) do |c| %>
      #     <% c.option(label: "Lopez Island", value: "lopez") %>
      #     <% c.option(label: "Shaw Island", value: "shaw") %>
      #     <% c.option(label: "Orcas Island", value: "orcas") %>
      #     <% c.option(label: "San Juan Island", value: "san_juan") %>
      #   <% end %>
      #
      # @example Full width
      #   <%= render(Primer::Alpha::SelectList.new(name: :places, label: "Places", full_width: true)) do |c| %>
      #     <% c.option(label: "Lopez Island", value: "lopez") %>
      #     <% c.option(label: "Shaw Island", value: "shaw") %>
      #     <% c.option(label: "Orcas Island", value: "orcas") %>
      #     <% c.option(label: "San Juan Island", value: "san_juan") %>
      #   <% end %>
      #
      # @example Disabled
      #   <%= render(Primer::Alpha::SelectList.new(name: :places, label: "Places", disabled: true)) do |c| %>
      #     <% c.option(label: "Lopez Island", value: "lopez") %>
      #     <% c.option(label: "Shaw Island", value: "shaw") %>
      #     <% c.option(label: "Orcas Island", value: "orcas") %>
      #     <% c.option(label: "San Juan Island", value: "san_juan") %>
      #   <% end %>
      #
      # @example Invalid
      #   <%= render(Primer::Alpha::SelectList.new(name: :places, label: "Places", invalid: true)) do |c| %>
      #     <% c.option(label: "Lopez Island", value: "lopez") %>
      #     <% c.option(label: "Shaw Island", value: "shaw") %>
      #     <% c.option(label: "Orcas Island", value: "orcas") %>
      #     <% c.option(label: "San Juan Island", value: "san_juan") %>
      #   <% end %>
      #
      # @example With a caption
      #   <%= render(Primer::Alpha::SelectList.new(name: :places, label: "Places", caption: "Choose your favorite place!")) do |c| %>
      #     <% c.option(label: "Lopez Island", value: "lopez") %>
      #     <% c.option(label: "Shaw Island", value: "shaw") %>
      #     <% c.option(label: "Orcas Island", value: "orcas") %>
      #     <% c.option(label: "San Juan Island", value: "san_juan") %>
      #   <% end %>
      #
      # @example With a validation message
      #   <%= render(Primer::Alpha::SelectList.new(name: :places, label: "Places", include_blank: "Select a place", validation_message: "Place can't be blank")) do |c| %>
      #     <% c.option(label: "Lopez Island", value: "lopez") %>
      #     <% c.option(label: "Shaw Island", value: "shaw") %>
      #     <% c.option(label: "Orcas Island", value: "orcas") %>
      #     <% c.option(label: "San Juan Island", value: "san_juan") %>
      #   <% end %>
      #
      # @param multiple [Boolean] If set to true, the selection will allow multiple choices.
      # @param include_blank [Boolean, String] If set to true, an empty option will be created. If set to a string, the string will be used as the option's content and the value will be empty.
      # @param prompt [String] Create a prompt option with blank value and the text asking user to select something.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    end
  end
end
