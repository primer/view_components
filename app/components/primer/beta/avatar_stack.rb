# frozen_string_literal: true

module Primer
  module Beta
    # Use `AvatarStack` to stack multiple avatars together.
    class AvatarStack < Primer::Component
      status :beta

      ALIGN_DEFAULT = :left
      ALIGN_OPTIONS = [ALIGN_DEFAULT, :right].freeze

      DEFAULT_TAG = :div
      TAG_OPTIONS = [DEFAULT_TAG, :span].freeze

      DEFAULT_BODY_TAG = :div
      BODY_TAG_OPTIONS = [DEFAULT_BODY_TAG, :span].freeze
      # Required list of stacked avatars.
      #
      # @param kwargs [Hash] The same arguments as <%= link_to_component(Primer::Beta::Avatar) %>.
      renders_many :avatars, "Primer::Beta::Avatar"

      # @param tag [Symbol] <%= one_of(Primer::Beta::AvatarStack::TAG_OPTIONS) %>
      # @param align [Symbol] <%= one_of(Primer::Beta::AvatarStack::ALIGN_OPTIONS) %>
      # @param tooltipped [Boolean] Whether to add a tooltip to the stack or not.
      # @param body_arguments [Hash] Parameters to add to the Body. If `tooltipped` is set, has the same arguments as <%= link_to_component(Primer::Tooltip) %>.
      #   The default tag is <%= pretty_value(Primer::Beta::AvatarStack::DEFAULT_BODY_TAG) %> but can be changed using `tag:`
      #   to <%= one_of(Primer::Beta::AvatarStack::BODY_TAG_OPTIONS, lower: true) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(tag: DEFAULT_TAG, align: ALIGN_DEFAULT, tooltipped: false, body_arguments: {}, **system_arguments)
        @align = fetch_or_fallback(ALIGN_OPTIONS, align, ALIGN_DEFAULT)
        @system_arguments = system_arguments
        @tooltipped = tooltipped
        @body_arguments = body_arguments
        @direction = @body_arguments[:direction]

        body_tag = @body_arguments[:tag] || DEFAULT_BODY_TAG
        @body_arguments[:tag] = fetch_or_fallback(BODY_TAG_OPTIONS, body_tag, DEFAULT_BODY_TAG)
        @body_arguments[:classes] = class_names(
          "AvatarStack-body",
          @body_arguments[:classes]
        )

        @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)
        @system_arguments[:classes] = class_names(
          "AvatarStack",
          system_arguments[:classes],
          "AvatarStack--right" => @align == :right
        )

        @body_arguments[:tabindex] = tooltipped ? 0 : nil
        @body_arguments[:id] = tooltipped ? @body_arguments[:id] ||= self.class.generate_id : @body_arguments[:id]

        @tooltip_arguments = {
          for_id: @body_arguments[:id],
          direction: @body_arguments.delete(:direction),
        }

        @tooltip_arguments[:direction] = @direction || Primer::Alpha::Tooltip::DIRECTION_DEFAULT
        @tooltip_arguments[:text] = @body_arguments[:label]
        @tooltip_arguments[:type] = :description

        @body_arguments[:aria] ||= {}
        if tooltipped && @body_arguments[:label].present?
          @body_arguments[:aria][:label] = @body_arguments[:label]
          @body_arguments[:label] = nil
        end
      end

      def body_component
        Primer::BaseComponent.new(**@body_arguments)
      end

      def before_render
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "AvatarStack--two" => avatars.size == 2,
          "AvatarStack--three-plus" => avatars.size > 2
        )
      end

      def render?
        avatars.any?
      end
    end
  end
end
