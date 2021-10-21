# frozen_string_literal: true

module Primer
  module Alpha
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class Nameplate < Primer::Component
      DEFAULT_TAG = :span
      TAG_OPTIONS = [DEFAULT_TAG, :a].freeze

      renders_one :avatar, lambda { |**system_arguments|
        system_arguments[:mr] ||= 1
        system_arguments[:size] = 24
        system_arguments[:alt] = ""
        system_arguments[:"aria-disabled"] = "true"

        Primer::Beta::Avatar.new(**system_arguments)
      }

      # @example Example goes here
      #
      #   <%= render(Primer::Nameplate.new) { "Example" } %>
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(name:, tag: DEFAULT_TAG, **system_arguments)
        @name = name

        @system_arguments = system_arguments
        @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)
        @system_arguments[:display] = :flex
        @system_arguments[:align_items] = :center
        @system_arguments[:font_weight] = :bold
      end

      def wrapper
        return Primer::BaseComponent.new(**@system_arguments) if @system_arguments[:tag] == :span

        Primer::LinkComponent.new(**@system_arguments)
      end
    end
  end
end
