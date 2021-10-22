# frozen_string_literal: true

module Primer
  module Alpha
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class Nameplate < Primer::Component
      DEFAULT_TAG = :span
      TAG_OPTIONS = [DEFAULT_TAG, :a].freeze

      # Required Avatar
      #
      # @param kwargs [Hash] The same arguments as <%= link_to_component(Primer::Beta::Avatar) %>.
      renders_one :avatar, lambda { |**system_arguments|
        system_arguments[:mr] ||= 1
        system_arguments[:size] = 24
        system_arguments[:alt] = ""
        system_arguments[:"aria-disabled"] = "true"

        Primer::Beta::Avatar.new(**system_arguments)
      }

      # @example Default
      #
      #   <%= render(Primer::Alpha::Nameplate.new(name: "github")) do |c| %>
      #     <% c.avatar(src: "https://github.com/github.png") %>
      #   <% end %>
      #
      # @example As a link
      #
      #   <%= render(Primer::Alpha::Nameplate.new(tag: :a, name: "github", href: "#")) do |c| %>
      #     <% c.avatar(src: "https://github.com/github.png") %>
      #   <% end %>
      #
      # @param name [String] Name to be rendered beside the Avatar.
      # @param tag [Symbol] <% one_of(Primer::Alpha::Nameplate::TAG_OPTIONS) %>
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
        return Primer::LinkComponent.new(**@system_arguments) if @system_arguments[:tag] == :a

        Primer::BaseComponent.new(**@system_arguments)
      end
    end
  end
end
