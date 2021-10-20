# frozen_string_literal: true

module Primer
  module Alpha
    module BorderBox
      # BorderBox::Header: used inside the BorderBoxComponent to render its header slot
      # Optional title slot
      #
      # @accessibility When using `header.title`, set `tag` to one of `h1`, `h2`, `h3`, etc. based on what is appropriate for the page context. <%= link_to_heading_practices %>
      class Header < Primer::Component
        # Optional Title.
        #
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        renders_one :title, lambda { |**system_arguments|
          system_arguments[:tag] = :div
          system_arguments[:classes] = class_names(
            "Box-title",
            system_arguments[:classes]
          )

          Primer::BaseComponent.new(**system_arguments)
        }

        # @example default use case
        #
        #   <%= render(Primer::Alpha::BorderBox::Header.new) do %>
        #     Header
        #   <% end %>
        #
        # @example with title
        #   <%= render(Primer::Alpha::BorderBox::Header.new) do |h| %>
        #     <% h.title do %>I am a title<% end %>
        #   <% end %>
        #
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(**system_arguments)
          @system_arguments = system_arguments
          @system_arguments[:tag] = :div
          @system_arguments[:classes] = class_names(
            "Box-header",
            system_arguments[:classes]
          )
        end
      end
    end
  end
end
