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
        raise ArgumentError, "Title must be a string" unless block.call.is_a?(String)

        system_arguments[:tag] = fetch_or_fallback(TITLE_TAG_OPTIONS, tag, TITLE_TAG_FALLBACK)
        system_arguments[:font_size] ||= 3
        system_arguments[:mr] ||= 2

        Primer::OpenProject::Heading.new(**system_arguments, &block)
      }

      # Optional caption
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :caption, lambda { |**system_arguments, &block|
        raise ArgumentError, "Caption must be a string" unless block.call.is_a?(String)

        system_arguments[:color] ||= :subtle
        system_arguments[:mr] ||= 2
        system_arguments[:display] ||= [:none, :block]

        Primer::Beta::Text.new(**system_arguments, &block)
      }

      # Optional right-side content
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :additional_information, lambda { |**system_arguments, &block|
        raise ArgumentError, "The additional information must be a string" unless block.call.is_a?(String)

        Primer::BaseComponent.new(tag: :div, **system_arguments)
      }

      # Required collapsible content
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :collapsible_content, lambda { |**system_arguments|
        Primer::BaseComponent.new(tag: :div, **system_arguments)
      }

      # @param id [String] The unique ID of the collapsible section.
      # @param collapsed [Boolean] Whether the section is collapsed on initial render.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(id: self.class.generate_id, collapsed: false, **system_arguments)
        @title_id = "#{id}-title"
        @content_id = "#{id}-content"
        @collapsed = collapsed

        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = "collapsible-section"
        @system_arguments[:id] = id
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "CollapsibleSection",
          "CollapsibleSection--collapsed" => @collapsed
        )

        @system_arguments[:data] ||= {}
        @system_arguments[:data][:collapsed] = true if @collapsed
      end

      private

      def render?
        raise ArgumentError, "Title must be present" unless title.present?
        raise ArgumentError, "Collapsible content must be present" unless collapsible_content.present?

        true
      end
    end
  end
end
