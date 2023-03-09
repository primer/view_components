# frozen_string_literal: true

module Primer
  module Alpha
    # An ActionList is a styled list of links. It acts as the base component for many
    # other menu-type components, including `ActionMenu` and `SelectPanel`, as well as
    # the navigational component `NavList`.
    #
    # Each item in an action list can be augmented by specifying corresponding leading
    # and/or trailing visuals.
    class ActionList < Primer::Component
      status :alpha

      DEFAULT_ROLE = :list

      DEFAULT_SCHEME = :full
      SCHEME_MAPPINGS = {
        DEFAULT_SCHEME => nil,
        :inset => "ActionListWrap--inset"
      }.freeze
      SCHEME_OPTIONS = SCHEME_MAPPINGS.keys.freeze

      # :nocov:
      # @private
      def self.custom_element_name
        @custom_element_name ||= name.split("::").last.underscore.dasherize
      end

      # @private
      def custom_element_name
        self.class.custom_element_name
      end
      # :nocov:

      # Heading text rendered above the list of items.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList::Heading) %>.
      renders_one :heading, lambda { |**system_arguments|
        Heading.new(list_id: @id, **system_arguments)
      }

      # Adds an item to the list.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList::Item) %>.
      def with_item(**system_arguments)
        @items << build_item(**system_arguments).tap do |item|
          yield item if block_given?

          will_add_item(item)
        end
      end

      # Adds a divider to the list of items.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList::Divider) %>.
      def with_divider(**system_arguments)
        @items << ActionList::Divider.new(**system_arguments).tap do |divider|
          yield divider if block_given?
        end
      end

      # Returns the current list of items.
      attr_reader :items

      # @param role [Boolean] ARIA role describing the function of the list. listbox and menu are a common values.
      # @param item_classes [String] Additional CSS classes to attach to items.
      # @param scheme [Symbol] <%= one_of(Primer::Alpha::ActionList::SCHEME_OPTIONS) %>. `inset` children are offset (vertically and horizontally) from list edges. `full` (default) children are flush (vertically and horizontally) with list edges.
      # @param show_dividers [Boolean] Display a divider above each item in the list when it does not follow a header or divider.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        role: DEFAULT_ROLE,
        item_classes: nil,
        scheme: DEFAULT_SCHEME,
        show_dividers: false,
        **system_arguments
      )
        @items = []
        @id = self.class.generate_id

        @system_arguments = system_arguments
        @system_arguments[:tag] = :ul
        @system_arguments[:role] = role
        @item_classes = item_classes
        @scheme = fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)
        @show_dividers = show_dividers
        @system_arguments[:classes] = class_names(
          SCHEME_MAPPINGS[@scheme],
          system_arguments[:classes],
          "ActionListWrap",
          "ActionListWrap--divided" => @show_dividers
        )

        @list_wrapper_arguments = {}
      end

      # @private
      def before_render
        aria_label = aria(:label, @system_arguments)

        if heading.present?
          @system_arguments[:"aria-labelledby"] = @id
          raise ArgumentError, "An aria-label should not be provided if a heading is present" if aria_label.present?
        elsif aria_label.blank?
          raise ArgumentError, "An aria-label or heading must be provided"
        end
      end

      # @private
      def build_item(**system_arguments)
        system_arguments[:classes] = class_names(
          @item_classes,
          system_arguments[:classes]
        )

        ActionList::Item.new(list: self, **system_arguments)
      end

      # @private
      def will_add_item(_item); end
    end
  end
end
