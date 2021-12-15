# frozen_string_literal: true

require "securerandom"

module Primer
  module Alpha
    # Use `Dialog` for an overlayed dialog window.
    class Dialog < Primer::Component
      # Optional list of buttons to be rendered.
      #
      # @param system_arguments [Hash] The same arguments as <%= link_to_component(Primer::ButtonComponent) %> except for `size` and `group_item`.
      renders_many :buttons, lambda { |**system_arguments|
        Primer::ButtonComponent.new(**system_arguments)
      }

      # Required body content.
      #
      # @param system_arguments [Hash] The same arguments as <%= link_to_component(Primer::ButtonComponent) %> except for `size` and `group_item`.
      renders_one :body, lambda { |**system_arguments|
        deny_tag_argument(**system_arguments)
        Primer::BaseComponent.new(**system_arguments)
      }

      # @example Default
      #   <%= render(Alpha::Primer::Dialog.new(
      #    title: "Title",
      #    description: "Description"
      #   )) do |c| %>
      #     c.buttons << Primer::ButtonComponent.new() { "Button 1" }
      #     c.buttons << Primer::ButtonComponent.new() { "Button 2" }
      #     c.body do
      #       <em>Your custom content here</em>
      #     end
      #   <% end %>
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(title:, description:, **system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)

        @system_arguments[:tag] = :div
        @system_arguments[:role] = :dialog
        @title = title
        @description = description
        id = SecureRandom.hex(4)
        @header_id = `dialog-#{id}`.freeze

        if @description.present?
          @description_id = `dialog-description-#{id}`.freeze
          @system_arguments[:aria] = { labelledby: @header_id, describedby: @description_id }
        else
          @system_arguments[:aria] = { labelledby: @header_id }
        end
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) { content }
      end
    end
  end
end
