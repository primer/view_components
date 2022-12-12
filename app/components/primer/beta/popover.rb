# frozen_string_literal: true

module Primer
  module Beta
    # Use `Popover` to bring attention to specific user interface elements, typically to suggest an action or to guide users through a new experience.
    #
    # By default, the popover renders with absolute positioning, meaning it should usually be wrapped in an element with a relative position in order to be positioned properly. To render the popover with relative positioning, use the relative property.
    class Popover < Primer::Component
      status :beta

      CARET_DEFAULT = :top
      CARET_MAPPINGS = {
        CARET_DEFAULT => "",
        :bottom => "Popover-message--bottom",
        :bottom_right => "Popover-message--bottom-right",
        :bottom_left => "Popover-message--bottom-left",
        :left => "Popover-message--left",
        :left_bottom => "Popover-message--left-bottom",
        :left_top => "Popover-message--left-top",
        :right => "Popover-message--right",
        :right_bottom => "Popover-message--right-bottom",
        :right_top => "Popover-message--right-top",
        :top_left => "Popover-message--top-left",
        :top_right => "Popover-message--top-right"
      }.freeze

      DEFAULT_HEADING_TAG = :h4

      # The heading
      #
      # @param tag [Symbol] (Primer::Beta::Popover::DEFAULT_HEADING_TAG) <%= one_of(Primer::Beta::Heading::TAG_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :heading, lambda { |tag: DEFAULT_HEADING_TAG, **system_arguments|
        system_arguments[:tag] = tag
        system_arguments[:mb] ||= 2

        Primer::Beta::Heading.new(**system_arguments)
      }

      # The body
      #
      # @param caret [Symbol] <%= one_of(Primer::Beta::Popover::CARET_MAPPINGS.keys) %>
      # @param large [Boolean] Whether to use the large version of the component.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :body, lambda { |caret: CARET_DEFAULT, large: false, **system_arguments|
        @body_arguments = system_arguments
        @body_arguments[:classes] = class_names(
          @body_arguments[:classes],
          "Popover-message Box",
          CARET_MAPPINGS[fetch_or_fallback(CARET_MAPPINGS.keys, caret, CARET_DEFAULT)],
          "Popover-message--large" => large
        )
        @body_arguments[:p] ||= 4
        @body_arguments[:mt] ||= 2
        @body_arguments[:mx] ||= :auto
        @body_arguments[:text_align] ||= :left
        @body_arguments[:box_shadow] ||= :large

        Primer::Content.new
      }

      # @example Default
      #   <%= render Primer::Beta::Popover.new do |component| %>
      #     <% component.with_heading do %>
      #       Activity feed
      #     <% end %>
      #     <% component.with_body do %>
      #       This is the Popover body.
      #     <% end %>
      #   <% end %>
      #
      # @example Large
      #   <%= render Primer::Beta::Popover.new do |component| %>
      #     <% component.with_heading do %>
      #       Activity feed
      #     <% end %>
      #     <% component.with_body(large: true) do %>
      #       This is the large Popover body.
      #     <% end %>
      #   <% end %>
      #
      # @example Caret position
      #   <%= render Primer::Beta::Popover.new do |component| %>
      #     <% component.with_heading do %>
      #       Activity feed
      #     <% end %>
      #     <% component.with_body(caret: :left) do %>
      #       This is the Popover body.
      #     <% end %>
      #   <% end %>
      #
      # @example With multiple elements in the body
      #   <%= render Primer::Beta::Popover.new do |component| %>
      #     <% component.with_heading do %>
      #       Activity feed
      #     <% end %>
      #     <% component.with_body(caret: :left) do %>
      #       <p>This is the Popover body.</p>
      #       <%= render Primer::ButtonComponent.new(type: :submit) do %>
      #         Got it!
      #       <% end %>
      #     <% end %>
      #   <% end %>
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "Popover"
        )
        @system_arguments[:position] ||= :relative
        @system_arguments[:right] = false unless @system_arguments.delete(:right)
        @system_arguments[:left] = false unless @system_arguments.delete(:left)
      end

      def render?
        body.present?
      end

      def body_component
        Primer::Box.new(**@body_arguments)
      end
    end
  end
end
