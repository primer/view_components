# frozen_string_literal: true

require "securerandom"

module Primer
  module Alpha
    # Use `Dialog` for an overlayed dialog window.
    class Dialog < Primer::Component
      # Optional list of buttons to be rendered.
      #
      # @param system_arguments [Hash] The same arguments as <%= link_to_component(Primer::ButtonComponent) %>.
      renders_many :buttons, lambda { |**system_arguments|
        Primer::ButtonComponent.new(**system_arguments)
      }

      # Required body content.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :body, lambda { |**system_arguments|
        deny_tag_argument(**system_arguments)
        system_arguments[:tag] = :div

        @system_arguments[:classes] = class_names(
          "dialog-body",
          system_arguments[:classes]
        )
        Primer::BaseComponent.new(**system_arguments)
      }

      # @example Default
      #   <%= render(Primer::Alpha::Dialog.new(
      #    title: "Title",
      #    description: "Description",
      #    dialog_id: "my-custom-id"
      #   )) do |c| %>
      #     <% c.body do %>
      #       <em>Your custom content here</em>
      #     <% end %>
      #   <% end %>
      #
      # @example With buttons
      #   <%= render(Primer::Alpha::Dialog.new(
      #    title: "Title",
      #    description: "Description",
      #    dialog_id: "my-custom-id"
      #   )) do |c| %>
      #     <% c.button { "Button 1" } %>
      #     <% c.button { "Button 2" } %>
      #     <% c.body do %>
      #       <em>Your custom content here</em>
      #     <% end %>
      #   <% end %>
      #
      # @param title [String] The title of the dialog.
      # @param description [String] The optional description of the dialog.
      # @param dialog_id [String] The optional ID of the dialog, defaults to random string.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(title:, description: nil, dialog_id: nil, **system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)

        @system_arguments[:tag] = "modal-dialog"
        @system_arguments[:role] = :dialog
        @title = title
        @description = description
        dialog_id ||= "dialog-#{SecureRandom.hex(4)}"
        @system_arguments[:id] = dialog_id.to_s

        @header_id = "#{dialog_id}-header"

        @system_arguments[:classes] = class_names(
          "dialog",
          "hidden",
          system_arguments[:classes]
        )

        if @description.present?
          @description_id = "#{dialog_id}-description"
          @system_arguments[:aria] = { labelledby: @header_id, describedby: @description_id }
        else
          @system_arguments[:aria] = { labelledby: @header_id }
        end
      end
    end
  end
end
