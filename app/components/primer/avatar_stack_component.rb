# frozen_string_literal: true

module Primer
  # Use `AvatarStack` to stack multiple avatars together.
  class AvatarStackComponent < Primer::Component
    status :beta

    ALIGN_DEFAULT = :left
    ALIGN_OPTIONS = [ALIGN_DEFAULT, :right].freeze

    DEFAULT_TAG = :div
    TAG_OPTIONS = [DEFAULT_TAG, :span].freeze
    # Required list of stacked avatars.
    #
    # @param kwargs [Hash] The same arguments as <%= link_to_component(Primer::AvatarComponent) %>.
    renders_many :avatars, Primer::AvatarComponent

    # @example Default
    #   <%= render(Primer::AvatarStackComponent.new) do |c| %>
    #     <%= c.avatar(src: "http://placekitten.com/200/200", alt: "@kittenuser") %>
    #     <%= c.avatar(src: "http://placekitten.com/200/200", alt: "@kittenuser") %>
    #     <%= c.avatar(src: "http://placekitten.com/200/200", alt: "@kittenuser") %>
    #   <% end  %>
    #
    # @example Align right
    #   <%= render(Primer::AvatarStackComponent.new(align: :right)) do |c| %>
    #     <%= c.avatar(src: "http://placekitten.com/200/200", alt: "@kittenuser") %>
    #     <%= c.avatar(src: "http://placekitten.com/200/200", alt: "@kittenuser") %>
    #     <%= c.avatar(src: "http://placekitten.com/200/200", alt: "@kittenuser") %>
    #   <% end  %>
    #
    # @example With tooltip
    #   <%= render(Primer::AvatarStackComponent.new(tooltipped: true, body_arguments: { label: 'This is a tooltip!' })) do |c| %>
    #     <%= c.avatar(src: "http://placekitten.com/200/200", alt: "@kittenuser") %>
    #     <%= c.avatar(src: "http://placekitten.com/200/200", alt: "@kittenuser") %>
    #     <%= c.avatar(src: "http://placekitten.com/200/200", alt: "@kittenuser") %>
    #   <% end  %>
    #
    # @param tag [Symbol] <%= one_of(Primer::AvatarStackComponent::TAG_OPTIONS) %>
    # @param align [Symbol] <%= one_of(Primer::AvatarStackComponent::ALIGN_OPTIONS) %>
    # @param tooltipped [Boolean] Whether to add a tooltip to the stack or not.
    # @param body_arguments [Hash] Parameters to add to the Body. If `tooltipped` is set, has the same arguments as <%= link_to_component(Primer::TooltipComponent) %>.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(tag: DEFAULT_TAG, align: ALIGN_DEFAULT, tooltipped: false, body_arguments: {}, **system_arguments)
      @align = fetch_or_fallback(ALIGN_OPTIONS, align, ALIGN_DEFAULT)
      @system_arguments = system_arguments
      @tooltipped = tooltipped
      @body_arguments = body_arguments

      @body_arguments[:tag] ||= :div
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
    end

    def body_component
      if @tooltipped
        Primer::TooltipComponent.new(**@body_arguments)
      else
        Primer::BaseComponent.new(**@body_arguments)
      end
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
