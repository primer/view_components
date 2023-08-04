# frozen_string_literal: true

module Primer
  module Alpha
    # Use `Menu` to create vertical lists of navigational links.
    class Menu < Primer::Component
      HEADING_TAG_OPTIONS = [:h1, :h2, :h3, :h4, :h5, :h6].freeze
      HEADING_TAG_FALLBACK = :h2

      # Optional menu heading
      #
      # @param tag [Symbol] <%= one_of(Primer::Alpha::Menu::HEADING_TAG_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :heading, lambda { |tag:, **system_arguments|
        system_arguments[:tag] = fetch_or_fallback(HEADING_TAG_OPTIONS, tag, HEADING_TAG_FALLBACK)
        system_arguments[:classes] = class_names(
          "menu-heading",
          system_arguments[:classes]
        )

        Primer::BaseComponent.new(**system_arguments)
      }

      # Required list of navigational links
      #
      # @param href [String] URL to be used for the Link
      # @param selected [Boolean] Whether the item is the current selection
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :items, lambda { |href:, selected: false, **system_arguments|
        deny_tag_argument(**system_arguments)
        system_arguments[:tag] = :a
        system_arguments[:href] = href
        system_arguments[:"aria-current"] = :page if selected
        system_arguments[:classes] = class_names(
          "menu-item",
          system_arguments[:classes]
        )

        Primer::BaseComponent.new(**system_arguments)
      }

      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :nav
        @system_arguments[:classes] = class_names(
          "menu",
          @system_arguments[:classes]
        )
      end

      def render?
        items.any?
      end
    end
  end
end
