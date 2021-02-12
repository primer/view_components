# frozen_string_literal: true

module Primer
  # Use AvatarStack to stack multiple avatars together.
  class AvatarStackComponent < Primer::Component
    include ViewComponent::SlotableV2

    ALIGN_DEFAULT = :left
    ALIGN_OPTIONS = [ALIGN_DEFAULT, :right].freeze

    # Customizable body of the Stack.
    #
    # @param tooltiped [Boolean] Whether to add a tooltip or not. If `true`, has the same arguments as <%= link_to_component(Primer::TooltipComponent) %>.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :body, ->(tooltipped: false, **system_arguments) do
      system_arguments[:tag] ||= :div
      system_arguments[:classes] = class_names(
        "AvatarStack-body",
        system_arguments[:classes],
      )

      if tooltipped
        Primer::TooltipComponent.new(**system_arguments)
      else
        Primer::BaseComponent.new(**system_arguments)
      end
    end

    # Required list of stacked avatars. Has the same arguments as <%= link_to_component(Primer::AvatarComponent) %>.
    renders_many :avatars, Primer::AvatarComponent

    # @example auto|Default
    #   <%= render(Primer::AvatarComponent.new(src: "http://placekitten.com/200/200", alt: "@kittenuser")) %>
    #
    # @param align [Boolean] <%= one_of(Primer::AvatarStackComponent::ALIGN_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(align: ALIGN_DEFAULT, **system_arguments)
      @align = fetch_or_fallback(ALIGN_OPTIONS, align, ALIGN_DEFAULT)
      @system_arguments = system_arguments
      @system_arguments[:tag] ||= :div
      @system_arguments[:classes] = class_names(
        "AvatarStack",
        system_arguments[:classes],
        "AvatarStack--right" => @align == :right
      )
    end

    def before_render
      body(classes: "") unless body
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
