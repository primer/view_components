# frozen_string_literal: true

module Primer
  module OpenProject
    # A view component for messages, inspired by the Primer Blankslate,
    # which serves a different use-case (messages for when data is missing).
    # We decided to wrap the Blankslate, because we don't want to have to adapt
    # lots of different usages if Primer decides to change the Blankslate
    # in a way that does not go well with our "misuse".
    class FeedbackMessage < Primer::Component
      status :open_project

      # @param icon_arguments [Hash] special arguments for the icon
      # @param loading [Boolean] Show a loading spinner instead of an icon
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(icon_arguments: {}, loading: false, **system_arguments)
        @system_arguments = system_arguments
        @icon_arguments = icon_arguments
        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "FeedbackMessage"
        )

        @icon_arguments[:icon] ||= :"check-circle"
        @icon_arguments[:color] ||= :success

        @blankslate = Primer::Beta::Blankslate.new(**@system_arguments)

        if loading
          @blankslate.with_visual_spinner(size: :medium)
        else
          @blankslate.with_visual_icon(size: :medium, **@icon_arguments)
        end
      end

      delegate :description?, :description, :with_description, :with_description_content,
               :heading?, :heading, :with_heading, :with_heading_content,
               to: :@blankslate

      private

      def before_render
        content
      end

      def render?
        heading.present?
      end
    end
  end
end
