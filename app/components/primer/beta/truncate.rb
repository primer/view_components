# frozen_string_literal: true

module Primer
  module Beta
    # Use `Truncate` to shorten overflowing text with an ellipsis.
    class Truncate < Primer::Component
      warn_on_deprecated_slot_setter
      status :beta

      # Text slot used for the truncated text.
      #
      # @param priority [Boolean] if true, the text will be given priority
      # @param expandable [Boolean] if true, the text will expand on hover or focus
      # @param max_width [Integer] if provided, the text will be truncated at a maximum width
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :items, "TruncateText"

      # @example Default
      #   <%= render(Primer::Beta::Truncate.new) { "branch-name-that-is-really-long" } %>
      #
      # @example Multiple items
      #   <%= render(Primer::Beta::Truncate.new) do |component| %>
      #     <% component.with_item do %>really-long-repository-owner-name<% end %>
      #     <% component.with_item(font_weight: :bold) do %>
      #       <%= render(Primer::BaseComponent.new(tag: :span, font_weight: :normal)) { "/" } %> really-long-repository-name
      #     <% end %>
      #   <% end %>
      #
      # @example Advanced multiple items
      #   <%= render(Primer::Beta::Truncate.new(tag: :ol)) do |component| %>
      #     <% component.with_item(tag: :li) do %>primer<% end %>
      #     <% component.with_item(tag: :li, priority: true) do %>/ css<% end %>
      #     <% component.with_item(tag: :li) do %>/ Issues<% end %>
      #     <% component.with_item(tag: :li) do %>/ #123 —<% end %>
      #     <% component.with_item(tag: :li, priority: true) do %>
      #       Visual bug on primer.style found in lists
      #     <% end %>
      #   <% end %>
      #
      # @example Expand on hover or focus
      #   <%= render(Primer::Beta::Truncate.new) do |component| %>
      #     <% component.with_item(tag: :a, href: "#", expandable: true) do %>really-long-repository-owner-name<% end %>
      #     <% component.with_item(tag: :a, href: "#", expandable: true) do %>really-long-repository-owner-name<% end %>
      #     <% component.with_item(tag: :a, href: "#", expandable: true) do %>really-long-repository-owner-name<% end %>
      #     <% component.with_item(tag: :a, href: "#", expandable: true) do %>really-long-repository-owner-name<% end %>
      #   <% end %>
      #
      # @example Max widths
      #   <%= render(Primer::Beta::Truncate.new) do |component| %>
      #     <% component.with_item(max_width: 300, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
      #     <% component.with_item(max_width: 200, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
      #     <% component.with_item(max_width: 100, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
      #   <% end %>
      #
      # @example Max widths on new lines
      #   <%= render(Primer::Beta::Truncate.new) do |component| %>
      #     <% component.with_item(max_width: 300, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
      #   <% end %>
      #   <br/>
      #   <%= render(Primer::Beta::Truncate.new) do |component| %>
      #     <% component.with_item(max_width: 200, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
      #   <% end %>
      #   <br/>
      #   <%= render(Primer::Beta::Truncate.new) do |component| %>
      #     <% component.with_item(max_width: 100, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
      #   <% end %>
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = system_arguments[:tag] || :span
        @system_arguments[:classes] = class_names(
          "Truncate",
          system_arguments[:classes]
        )
      end

      def before_render
        return unless content.present? && items.empty?

        with_item { content }
      end

      def render?
        items?
      end

      # This component is part of `Primer::Beta::Truncate` and should not be
      # used as a standalone component.
      class TruncateText < Primer::Component
        def initialize(priority: false, expandable: false, max_width: nil, **system_arguments)
          @system_arguments = system_arguments
          @system_arguments[:tag] = system_arguments[:tag] || :span
          @system_arguments[:classes] = class_names(
            "Truncate-text",
            system_arguments[:classes],
            "Truncate-text--primary": priority,
            "Truncate-text--expandable": expandable
          )

          @system_arguments[:style] = join_style_arguments(@system_arguments[:style], "max-width: #{max_width}px;") unless max_width.nil?
        end

        def call
          render(Primer::BaseComponent.new(**@system_arguments)) do
            content
          end
        end
      end
    end
  end
end
