# frozen_string_literal: true

module Primer
  module Alpha
    module BorderBox
      # `BorderBox::Header` is used inside `BorderBox` to render its header slot.
      #
      # @accessibility When using `header.title`, set `tag` to one of `h1`, `h2`, `h3`, etc. based on what is appropriate for the page context. <%= link_to_heading_practices %>
      class Header < Primer::Component
        TITLE_TAG_FALLBACK = :h2
        TITLE_TAG_OPTIONS = [:h1, TITLE_TAG_FALLBACK, :h3, :h4, :h5, :h6].freeze

        # Optional Title.
        #
        # @param tag [Symbol] <%= one_of(Primer::Alpha::BorderBox::Header::TITLE_TAG_OPTIONS) %>
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        renders_one :title, lambda { |tag:, **system_arguments|
          system_arguments[:tag] = fetch_or_fallback(TITLE_TAG_OPTIONS, tag, TITLE_TAG_FALLBACK)
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
        #     <% h.title(tag: :h3) do %>I am a title<% end %>
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
