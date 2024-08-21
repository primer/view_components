# frozen_string_literal: true

module Primer
  module OpenProject
    # A view component for success messages, inspired by the Primer Blankslate,
    # which serves a different use-case (messages for when data is missing).
    # We decided to wrap the Blankslate, because we don't want to have to adapt
    # lots of different usages if Primer decides to change the Blankslate
    # in a way that does not go well with our "misuse".
    class ConfirmationMessage < Primer::Component
      status :open_project

      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = "confirmation-message"
        @system_arguments[:icon] ||= :"check-circle"
        @system_arguments[:icon_color] ||= :success

        @blankslate = Primer::Beta::Blankslate.new(**@system_arguments)
        @blankslate.with_visual_icon(icon: @system_arguments[:icon], size: :medium, color: @system_arguments[:icon_color])
      end

      delegate :description?, :description, :with_description, :with_description_content,
               :heading?, :heading, :with_heading, :with_heading_content,
               to: :@blankslate

      private

      def before_render
        content
      end
    end
  end
end
