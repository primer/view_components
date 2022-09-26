# frozen_string_literal: true

module Primer
  module Alpha
    # An ActionList is a styled list of links. It acts as the base component for many
    # other menu-type components, including `ActionMenu` and `SelectPanel`, as well as
    # the navigational component `NavList`.
    #
    # Each item in an action list can be augmented by specifying corresponding leading
    # and/or trailing visuals.
    #
    # List items can either be single items or sub lists. Rather than navigating to
    # to a URL, sub lists expand and collapse on click. To indicate this functionality,
    # sub lists automatically render with a trailing chevron that changes direction
    # when the sub list expands and collapses.
    class ActionList < Primer::Component
      status :alpha

      DEFAULT_ROLE = :list

      DEFAULT_SCHEME = :full
      SCHEME_MAPPINGS = {
        DEFAULT_SCHEME => nil,
        :inset => "ActionListWrap--inset"
      }.freeze
      SCHEME_OPTIONS = SCHEME_MAPPINGS.keys.freeze

      # @private
      def self.custom_element_name
        @custom_element_name ||= name.split("::").last.underscore.dasherize
      end

      # @private
      def custom_element_name
        self.class.custom_element_name
      end

      # Heading text rendered above the list of items.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList::Heading) %>.
      renders_one :heading, lambda { |**system_arguments|
        Heading.new(list_id: @id, **system_arguments)
      }

      # Top-level items that render above all sub lists.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList::Item) %>.
      renders_many :items, lambda { |**system_arguments|
        build_item(**system_arguments).tap do |item|
          will_add_item(item)
        end
      }

      # Sub lists, i.e. items that contain sub items.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList) %>.
      renders_many :lists, lambda { |**system_arguments|
        build_list(sub_list: true, **system_arguments).tap do |list|
          will_add_list(list)
        end
      }

      # @param role [Boolean] ARIA role describing the function of the list. listbox and menu are a common values.
      # @param item_classes [String] Additional CSS classes to attach to items.
      # @param scheme [Symbol] <%= one_of(Primer::Alpha::ActionList::SCHEME_OPTIONS) %>. `inset` children are offset (vertically and horizontally) from list edges. `full` (default) children are flush (vertically and horizontally) with list edges.
      # @param show_dividers [Boolean] Display a divider above each item in the list when it does not follow a header or divider.
      # @param sub_list [Boolean] Whether or not this `ActionList` is nested within another `ActionList`. Used internally.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        role: DEFAULT_ROLE,
        item_classes: nil,
        scheme: DEFAULT_SCHEME,
        show_dividers: false,
        sub_list: false,
        **system_arguments
      )
        @id = "action-list-sublist-#{SecureRandom.uuid}"
        @sub_list = sub_list

        @system_arguments = system_arguments
        @system_arguments[:tag] = :ul
        @system_arguments[:role] = role
        @item_classes = item_classes
        @scheme = fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)
        @show_dividers = show_dividers
        system_arguments[:classes] = class_names(
          SCHEME_MAPPINGS[@scheme],
          system_arguments[:classes],
          "ActionListWrap",
          "ActionListWrap--subGroup" => @sub_list,
          "ActionListWrap--divided" => @show_dividers
        )
      end

      # @private
      def before_render
        return if @sub_list

        if heading.present?
          @system_arguments[:"aria-labelledby"] = @id
        elsif aria(:label, @system_arguments).blank?
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
      def build_list(**system_arguments)
        ActionList.new(**system_arguments)
      end

      # @private
      def will_add_item(_item); end

      # @private
      def will_add_list(_list); end
    end
  end
end
