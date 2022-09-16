# frozen_string_literal: true

module Primer
  module Alpha
    # An ActionList is a list of items that can be activated or selected. ActionList is the base component for many menu-type components, including ActionMenu and SelectPanel.
    class ActionList < Primer::Component
      DEFAULT_ROLE = :list
      DEFAULT_TAG = :ul

      DEFAULT_SCHEME = :full
      SCHEME_MAPPINGS = {
        DEFAULT_SCHEME => nil,
        :inset => "ActionListWrap--inset"
      }.freeze
      SCHEME_OPTIONS = SCHEME_MAPPINGS.keys.freeze

      def self.custom_element_name
        @custom_element_name ||= name.split("::").last.underscore.dasherize
      end

      def custom_element_name
        self.class.custom_element_name
      end

      renders_one :heading, lambda { |**system_arguments|
        Heading.new(section_id: @id, **system_arguments)
      }

      renders_many :items, lambda { |**system_arguments|
        build_item(**system_arguments).tap do |item|
          will_add_item(item)
        end
      }

      renders_many :lists, lambda { |**system_arguments|
        build_list(child: true, **system_arguments).tap do |group|
          will_add_list(group)
        end
      }

      # `inset` children are offset (vertically and horizontally) from list edges. `full` children are flush (vertically and horizontally) with list edges
      # @param role [Boolean] ARIA role describing the function of the list. listbox and menu are a common values.
      # @param scheme [Symbol] `inset` children are offset (vertically and horizontally) from list edges. `full` (default) children are flush (vertically and horizontally) with list edges
      # @param show_dividers [Boolean] Display a divider above each item in the list when it does not follow a header or divider.
      # @param child [Boolean] If an ActionList is nested within another ActionList.
      def initialize(
        tag: DEFAULT_TAG,
        role: DEFAULT_ROLE,
        item_classes: nil,
        scheme: DEFAULT_SCHEME,
        show_dividers: false,
        child: false,
        **system_arguments
      )
        @id = "action-list-section-#{SecureRandom.uuid}"
        @child = child

        @system_arguments = system_arguments
        @system_arguments[:tag] = tag
        @system_arguments[:role] = role
        @item_classes = item_classes
        @scheme = fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)
        @show_dividers = show_dividers
        system_arguments[:classes] = class_names(
          SCHEME_MAPPINGS[@scheme],
          system_arguments[:classes],
          "ActionListWrap",
          "ActionListWrap--subGroup" => child,
          "ActionListWrap--divided" => @show_dividers
        )
      end

      def before_render
        return if @child

        if heading.present?
          @system_arguments[:"aria-labelledby"] = @id
        elsif aria(:label, @system_arguments).blank?
          raise ArgumentError, "An aria-label or heading must be provided"
        end
      end

      def build_item(**system_arguments)
        system_arguments[:classes] = class_names(
          @item_classes,
          system_arguments[:classes],
          "ActionListItem--subItem" => @child
        )

        ActionList::Item.new(list: self, **system_arguments)
      end

      def build_list(**system_arguments)
        ActionList.new(**system_arguments)
      end

      def will_add_item(_item); end

      def will_add_list(_list); end
    end
  end
end
