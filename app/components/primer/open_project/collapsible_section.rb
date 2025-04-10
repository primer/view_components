# frozen_string_literal: true

module Primer
  module OpenProject
    # A component consisting of a title and collapsible content.
    # Clicking the title will hide the collapsible content
    class CollapsibleSection < Primer::Component
      status :open_project

      TITLE_TAG_FALLBACK = :h2
      TITLE_TAG_OPTIONS = [:h1, TITLE_TAG_FALLBACK, :h3, :h4, :h5, :h6, :span].freeze

      # Required Title
      #
      # @param tag [Symbol] Customize the element type of the rendered title container.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :title, lambda { |tag: TITLE_TAG_FALLBACK, **system_arguments, &block|
        system_arguments[:tag] = fetch_or_fallback(TITLE_TAG_OPTIONS, tag, TITLE_TAG_FALLBACK)
        system_arguments[:font_size] ||= 3
        system_arguments[:mr] = 2

        Primer::OpenProject::Heading.new(**system_arguments, &block)
      }

      # Optional caption
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :caption, lambda { |**system_arguments, &block|
        system_arguments[:color] ||= :subtle
        system_arguments[:mr] = 2

        Primer::Beta::Text.new(**system_arguments, &block)
      }

      # Optional right-side content
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :additional_information, lambda { |**system_arguments|
        Primer::BaseComponent.new(tag: :div, **system_arguments)
      }

      # Required collapsible content
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :collapsible_content, lambda { |**system_arguments|
        Primer::BaseComponent.new(tag: :div, **system_arguments)
      }


      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(collapsed: false, **system_arguments)
        @collapsed = collapsed

        @system_arguments = system_arguments
        @system_arguments[:tag] = "collapsible-section"
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "CollapsibleSection",
          "CollapsibleSection--collapsed" => @collapsed
        )

        @system_arguments[:data] = merge_data(
          @system_arguments, {
          data: {
            collapsed: @collapsed
          }
        }
        )
      end

      private

      def render?
        title? && collapsible_content?
      end
    end
  end
end
