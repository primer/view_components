# frozen_string_literal: true

module Primer
  module Alpha
    # Use `Truncate` to shorten overflowing text with an ellipsis.
    class Truncate < Primer::Component
      status :alpha

      # @param primary [Boolean] if true, the text will be treated as primary
      # @param expandable [Boolean] if true, the text will expand on hover or focus
      # @param max_width [Integer] if provided, the text will be truncated at a maximum width
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :texts, "TruncateText"

      # @example Default
      #   <%= render(Primer::Alpha::Truncate.new) do |component| %>
      #     <% component.text do %>branch-name-that-is-really-long<% end %>
      #   <% end %>
      #
      # @example Multiple items
      #   <%= render(Primer::Alpha::Truncate.new) do |component| %>
      #     <% component.text do %>really-long-repository-owner-name<% end %>
      #     <% component.text(font_weight: :bold) do %>
      #       <%= render(Primer::BaseComponent.new(tag: :span, font_weight: :normal)) { "/" } %> really-long-repository-name
      #     <% end %>
      #   <% end %>
      #
      # @example Advanced multiple items
      #   <%= render(Primer::Alpha::Truncate.new(tag: :ol)) do |component| %>
      #     <% component.text(tag: :li) do %>primer<% end %>
      #     <% component.text(tag: :li, primary: true) do %>/ css<% end %>
      #     <% component.text(tag: :li) do %>/ Issues<% end %>
      #     <% component.text(tag: :li) do %>/ #123 —<% end %>
      #     <% component.text(tag: :li, primary: true) do %>
      #       Visual bug on primer.style found in lists
      #     <% end %>
      #   <% end %>
      #
      # @example Expand on hover or focus
      #   <%= render(Primer::Alpha::Truncate.new) do |component| %>
      #     <% component.text(tag: :a, href: "#", expandable: true) do %>really-long-repository-owner-name<% end %>
      #     <% component.text(tag: :a, href: "#", expandable: true) do %>really-long-repository-owner-name<% end %>
      #     <% component.text(tag: :a, href: "#", expandable: true) do %>really-long-repository-owner-name<% end %>
      #     <% component.text(tag: :a, href: "#", expandable: true) do %>really-long-repository-owner-name<% end %>
      #   <% end %>
      #
      # @example Max widths
      #   <%= render(Primer::Alpha::Truncate.new) do |component| %>
      #     <% component.text(max_width: 300, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
      #     <% component.text(max_width: 200, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
      #     <% component.text(max_width: 100, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
      #   <% end %>
      #
      # @example Max widths on new lines
      #   <%= render(Primer::Alpha::Truncate.new) do |component| %>
      #     <% component.text(max_width: 300, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
      #   <% end %>
      #   <br/>
      #   <%= render(Primer::Alpha::Truncate.new) do |component| %>
      #     <% component.text(max_width: 200, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
      #   <% end %>
      #   <br/>
      #   <%= render(Primer::Alpha::Truncate.new) do |component| %>
      #     <% component.text(max_width: 100, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
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

      def render?
        texts.any?
      end

      # This component is part of `Primer::Alpha::Truncate` and should not be
      # used as a standalone component.
      class TruncateText < Primer::Component
        def initialize(primary: false, expandable: false, max_width: nil, **system_arguments)
          @system_arguments = system_arguments
          @system_arguments[:tag] = system_arguments[:tag] || :span
          @system_arguments[:classes] = class_names(
            "Truncate-text",
            "Truncate-text--primary": primary,
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
