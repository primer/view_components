# frozen_string_literal: true

module Primer
  module Alpha
    # `Tooltip` is a wrapper component that will apply a tooltip to the provided content.
    #
    # The element that triggers the tooltip must be rendered through the `trigger` slot.
    # If the trigger element is a view component, use the `trigger_component` slot.
    class Tooltip < Primer::Component

      TYPE_FALLBACK = :describe
      TYPE_OPTIONS = [TYPE_FALLBACK, :label].freeze

      TRIGGER_ELEMENT_FALLBACK_TAG = :button
      TRIGGER_ELEMENT_TAG_OPTIONS = [
        TRIGGER_ELEMENT_FALLBACK_TAG,
        :a,
        :summary,
        :"md-header",
        :"md-bold",
        :"md-italic",
        :"md-quote",
        :"md-code",
        :"md-link",
        :"md-ordered-list",
        :"md-task-list",
        :"md-unordered-list"
      ].freeze

      DIRECTION_DEFAULT = :n
      MULTILINE_DEFAULT = false

      DIRECTION_OPTIONS = [DIRECTION_DEFAULT] + %i[
        n
        w
        e
        s
        ne
        se
        sw
        nw
      ]

      # The element that triggers the tooltip
      #
      # @param tag [Symbol] <%= one_of(Primer::Alpha::Tooltip::TRIGGER_ELEMENT_TAG_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :trigger, lambda { |tag:, **system_arguments|
        system_arguments[:tag] = fetch_or_fallback(TRIGGER_ELEMENT_TAG_OPTIONS, tag, TRIGGER_ELEMENT_FALLBACK_TAG)
        @type == :describe ? system_arguments[:"aria-describedby"] = @tooltip_id : system_arguments[:"aria-labelledby"] = @tooltip_id
        Primer::BaseComponent.new(**system_arguments)
      }

      # The component that triggers the tooltip
      #
      # @param klass [Class] View component that triggers the tooltip.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :trigger_component, lambda { |klass:, **system_arguments|
        @type == :describe ? system_arguments[:"aria-describedby"] = @tooltip_id : system_arguments[:"aria-labelledby"] = @tooltip_id
        klass.new(**system_arguments)
      }

      # @example north direction
      #   <%= render(Primer::Alpha::Tooltip.new(id: "unique-1", type: :describe, text: "An awesome place for developers"))  do |component| %>
      #     <% component.trigger(tag: :a) { "GitHub"} %>
      #   <% end %>
      #
      # @example south direction
      #   <%= render(Primer::Alpha::Tooltip.new(id: "unique-2", type: :describe, direction: :s, text: "An awesome place for developers"))  do |component| %>
      #     <% component.trigger(tag: :button) { "GitHub"} %>
      #   <% end %>
      #
      # @example east direction
      #   <%= render(Primer::Alpha::Tooltip.new(id: "unique-3", type: :describe, direction: :e, text: "An awesome place for developers"))  do |component| %>
      #     <% component.trigger(tag: :a) { "GitHub"} %>
      #   <% end %>
      #
      # @example west direction
      #   <%= render(Primer::Alpha::Tooltip.new(id: "unique-4", type: :describe, direction: :w, text: "An awesome place for developers"))  do |component| %>
      #     <% component.trigger(tag: :a) { "GitHub"} %>
      #   <% end %>
      #
      # @example northeast direction
      #   <%= render(Primer::Alpha::Tooltip.new(id: "unique-5", type: :describe, direction: :ne, text: "An awesome place for developers"))  do |component| %>
      #     <% component.trigger(tag: :a) { "GitHub"} %>
      #   <% end %>
      #
      # @example southeast direction
      #   <%= render(Primer::Alpha::Tooltip.new(id: "unique-6", type: :describe, direction: :se, text: "An awesome place for developers"))  do |component| %>
      #     <% component.trigger(tag: :a) { "GitHub"} %>
      #   <% end %>
      #
      # @example northwest direction
      #   <%= render(Primer::Alpha::Tooltip.new(id: "unique-7", type: :describe, direction: :nw, text: "An awesome place for developers"))  do |component| %>
      #     <% component.trigger(tag: :a) { "GitHub"} %>
      #   <% end %>
      #
      # @example southwest direction
      #   <%= render(Primer::Alpha::Tooltip.new(id: "unique-8", type: :describe, direction: :sw, text: "An awesome place for developers"))  do |component| %>
      #     <% component.trigger(tag: :a) { "GitHub"} %>
      #   <% end %>
      #
      # @example multiple lines
      #   <%= render(Primer::Alpha::Tooltip.new(id: "unique-9", type: :describe, direction: :n, multiline: true, text: "This is the tooltip with multiple lines. This is the tooltip with multiple lines."))  do |component| %>
      #     <% component.trigger(tag: :a) { "GitHub"} %>
      #   <% end %>
      #
      # @example tooltip on view component
      #   <%= render(Primer::Alpha::Tooltip.new(id: "unique-10", type: :label, text: "Edit"))  do |component| %>
      #     <% component.trigger_component(klass: Primer::IconButton, icon: :pencil, box: true) %>
      #   <% end %>
      #
      # @param id [String] unique tooltip id
      # @param type [Symbol]  <%= one_of(Primer::Alpha::Tooltip::TYPE_OPTIONS) %>. `:describe` indicates the tooltip provides supplementary information, while `:label` indicates the tooltip provides an accessible label.
      # @param text [String] the text to appear in the tooltip
      # @param direction [String] Direction of the tooltip. <%= one_of(Primer::Alpha::Tooltip::DIRECTION_OPTIONS) %>
      # @param align [String] Align tooltips to the left or right of an element, combined with a `direction` to specify north or south. <%= one_of(Primer::Tooltip::ALIGN_MAPPING.keys) %>
      # @param multiline [Boolean] Use this when you have long content
      # @param tooltip_arguments [Hash] System arguments for the tooltip element
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        id:,
        type:,
        text:,
        direction: DIRECTION_DEFAULT,
        multiline: MULTILINE_DEFAULT,
        tooltip_arguments: {},
        **system_arguments
      )
        @system_arguments = system_arguments
        @system_arguments[:tag] = :"tooltip-container"
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "hx-tooltip-container"
        )
        @text = text
        @type = fetch_or_fallback(TYPE_OPTIONS, type, TYPE_FALLBACK)
        @tooltip_id = id

        @tooltip_system_arguments = { tag: :p, id: @tooltip_id, role: "tooltip", "aria-hidden": true, hidden: true }.merge(tooltip_arguments)
        @tooltip_system_arguments[:classes] = class_names(
          @tooltip_system_arguments[:classes],
          "hx-tooltip",
          "hx-tooltip-#{fetch_or_fallback(DIRECTION_OPTIONS, direction, DIRECTION_DEFAULT)}",
          "hx-tooltip-multiline" => fetch_or_fallback_boolean(multiline, MULTILINE_DEFAULT)
        )
      end
    end
  end
end
