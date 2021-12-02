# frozen_string_literal: true

module Primer
  # Use `Popover` to bring attention to specific user interface elements, typically to suggest an action or to guide users through a new experience.
  #
  # By default, the popover renders with absolute positioning, meaning it should usually be wrapped in an element with a relative position in order to be positioned properly. To render the popover with relative positioning, use the relative property.
  class PopoverComponent < Primer::Component
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
    # @param tag [Symbol] (Primer::PopoverComponent::DEFAULT_HEADING_TAG) <%= one_of(Primer::HeadingComponent::TAG_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :heading, lambda { |tag: DEFAULT_HEADING_TAG, **system_arguments|
      system_arguments[:tag] = tag
      system_arguments[:mb] ||= 2

      Primer::HeadingComponent.new(**system_arguments)
    }

    # The body
    #
    # @param caret [Symbol] <%= one_of(Primer::PopoverComponent::CARET_MAPPINGS.keys) %>
    # @param large [Boolean] Whether to use the large version of the component.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :body, lambda { |caret: CARET_DEFAULT, large: false, **system_arguments, &block|
      system_arguments[:classes] = class_names(
        system_arguments[:classes],
        "Popover-message Box",
        CARET_MAPPINGS[fetch_or_fallback(CARET_MAPPINGS.keys, caret, CARET_DEFAULT)],
        "Popover-message--large" => large
      )
      system_arguments[:p] ||= 4
      system_arguments[:mt] ||= 2
      system_arguments[:mx] ||= :auto
      system_arguments[:text_align] ||= :left
      system_arguments[:box_shadow] ||= :large

      # This is a hack to allow the parent to set the slot's content
      @body_arguments = system_arguments
      view_context.capture { block&.call }
    }

    # @example Default
    #   <%= render Primer::PopoverComponent.new do |component| %>
    #     <% component.heading do %>
    #       Activity feed
    #     <% end %>
    #     <% component.body do %>
    #       This is the Popover body.
    #     <% end %>
    #   <% end %>
    #
    # @example Large
    #   <%= render Primer::PopoverComponent.new do |component| %>
    #     <% component.heading do %>
    #       Activity feed
    #     <% end %>
    #     <% component.body(large: true) do %>
    #       This is the large Popover body.
    #     <% end %>
    #   <% end %>
    #
    # @example Caret position
    #   <%= render Primer::PopoverComponent.new do |component| %>
    #     <% component.heading do %>
    #       Activity feed
    #     <% end %>
    #     <% component.body(caret: :left) do %>
    #       This is the Popover body.
    #     <% end %>
    #   <% end %>
    #
    # @example With HTML body
    #   <%= render Primer::PopoverComponent.new do |component| %>
    #     <% component.heading do %>
    #       Activity feed
    #     <% end %>
    #     <% component.body(caret: :left) do %>
    #       <p> This is the Popover body.</p>
    #       <div>
    #         This is using HTML.
    #         <ul>
    #           <li>Thing #1</li>
    #           <li>Thing #2</li>
    #         </ul>
    #       </div>
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
      @system_arguments[:right] = false unless system_arguments.delete(:right)
      @system_arguments[:left] = false unless system_arguments.delete(:left)
    end

    def render?
      body.present?
    end

    def body_component
      Primer::BoxComponent.new(**@body_arguments)
    end
  end
end
