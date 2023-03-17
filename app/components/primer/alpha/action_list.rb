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

      DEFAULT_SELECT_VARIANT = :none
      SELECT_VARIANT_OPTIONS = [
        :single,
        :multiple,
        DEFAULT_SELECT_VARIANT
      ].freeze

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

      # Items.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList::Item) %>.
      renders_many :items, lambda { |**system_arguments|
        build_item(**system_arguments).tap do |item|
          will_add_item(item)
        end
      }

      # Adds a divider to the list of items.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList::Divider) %>.
      def with_divider(**system_arguments, &block)
        # This is a giant hack that should be removed when :items can be converted into a polymorphic slot.
        # This feature needs to land in view_component first: https://github.com/ViewComponent/view_component/pull/1652
        set_slot(:items, { renderable: Divider, collection: true }, **system_arguments, &block)
      end

      attr_reader :select_variant

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
        select_variant: DEFAULT_SELECT_VARIANT,
        **system_arguments
      )
        @id = self.class.generate_id

        @system_arguments = system_arguments
        @system_arguments[:tag] = :ul
        @system_arguments[:role] = role
        @item_classes = item_classes
        @scheme = fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)
        @show_dividers = show_dividers
        @select_variant = select_variant
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
        aria_labelledby = aria(:labelledby, @system_arguments)

        if heading.present?
          @system_arguments[:"aria-labelledby"] = @id
          raise ArgumentError, "An aria-label should not be provided if a heading is present" if aria_label.present?
        elsif aria_label.blank? && aria_labelledby.blank?
          raise ArgumentError, "An aria-label, aria-labelledby, or heading must be provided"
        end
      end

      # @private
      def build_item(**system_arguments)
        if select_variant == :single && system_arguments[:active] && items.count(&:active?) > 0
          raise ArgumentError, "only a single item may be active when select_variant is set to :single"
        end

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
