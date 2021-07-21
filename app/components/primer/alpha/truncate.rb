# frozen_string_literal: true

module Primer
  module Alpha
    # Use `Truncate` to shorten overflowing text with an ellipsis.
    class Truncate < Primer::Component
      status :alpha

      # Text slot used for the truncated text.
      #
      # @param primary [Boolean] if true, the text will be treated as primary
      # @param expandable [Boolean] if true, the text will expand on hover or focus
      # @param max_width [Integer] if provided, the text will be truncated at a maximum width
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :items, "TruncateText"

      # @example Default
      #   <%= render(Primer::Alpha::Truncate.new) { "branch-name-that-is-really-long" } %>
      #
      # @example Multiple items
      #   <%= render(Primer::Alpha::Truncate.new) do |component| %>
      #     <% component.item do %>really-long-repository-owner-name<% end %>
      #     <% component.item(font_weight: :bold) do %>
      #       <%= render(Primer::BaseComponent.new(tag: :span, font_weight: :normal)) { "/" } %> really-long-repository-name
      #     <% end %>
      #   <% end %>
      #
      # @example Advanced multiple items
      #   <%= render(Primer::Alpha::Truncate.new(tag: :ol)) do |component| %>
      #     <% component.item(tag: :li) do %>primer<% end %>
      #     <% component.item(tag: :li, primary: true) do %>/ css<% end %>
      #     <% component.item(tag: :li) do %>/ Issues<% end %>
      #     <% component.item(tag: :li) do %>/ #123 —<% end %>
      #     <% component.item(tag: :li, primary: true) do %>
      #       Visual bug on primer.style found in lists
      #     <% end %>
      #   <% end %>
      #
      # @example Expand on hover or focus
      #   <%= render(Primer::Alpha::Truncate.new) do |component| %>
      #     <% component.item(tag: :a, href: "#", expandable: true) do %>really-long-repository-owner-name<% end %>
      #     <% component.item(tag: :a, href: "#", expandable: true) do %>really-long-repository-owner-name<% end %>
      #     <% component.item(tag: :a, href: "#", expandable: true) do %>really-long-repository-owner-name<% end %>
      #     <% component.item(tag: :a, href: "#", expandable: true) do %>really-long-repository-owner-name<% end %>
      #   <% end %>
      #
      # @example Max widths
      #   <%= render(Primer::Alpha::Truncate.new) do |component| %>
      #     <% component.item(max_width: 300, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
      #     <% component.item(max_width: 200, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
      #     <% component.item(max_width: 100, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
      #   <% end %>
      #
      # @example Max widths on new lines
      #   <%= render(Primer::Alpha::Truncate.new) do |component| %>
      #     <% component.item(max_width: 300, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
      #   <% end %>
      #   <br/>
      #   <%= render(Primer::Alpha::Truncate.new) do |component| %>
      #     <% component.item(max_width: 200, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
      #   <% end %>
      #   <br/>
      #   <%= render(Primer::Alpha::Truncate.new) do |component| %>
      #     <% component.item(max_width: 100, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
      #   <% end %>
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = system_arguments[:tag] || :span
        @system_arguments[:classes] = "Truncate"
      end

      def before_render
        if content.present? && items.empty?
          # Get the tag and classes out of the system arguments
          args = @system_arguments.slice(:tag, :classes)
          @system_arguments.delete(:tag)
          @system_arguments.delete(:classes)

          # Duplicate to slot arguments
          slot_arguments = @system_arguments.dup

          @system_arguments = args
          self.set_slot(:items, **slot_arguments) { content }
        end
      end

      def render?
        items.any?
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
