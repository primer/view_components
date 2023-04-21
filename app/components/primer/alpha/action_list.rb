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

      MENU_ROLE = :menu
      DEFAULT_MENU_ITEM_ROLE = :menuitem

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
        :multiple_checkbox,
        DEFAULT_SELECT_VARIANT
      ].freeze

      SELECT_VARIANT_ROLE_MAP = {
        single: :menuitemradio,
        multiple: :menuitemcheckbox,
        multiple_checkbox: :menuitemcheckbox
      }.freeze

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
        Heading.new(**system_arguments)
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

      attr_reader :id, :select_variant, :role

      # @param id [String] HTML ID value.
      # @param role [Boolean] ARIA role describing the function of the list. listbox and menu are a common values.
      # @param item_classes [String] Additional CSS classes to attach to items.
      # @param scheme [Symbol] <%= one_of(Primer::Alpha::ActionList::SCHEME_OPTIONS) %> `inset` children are offset (vertically and horizontally) from list edges. `full` (default) children are flush (vertically and horizontally) with list edges.
      # @param show_dividers [Boolean] Display a divider above each item in the list when it does not follow a header or divider.
      # @param select_variant [Symbol] How items may be selected in the list. <%= one_of(Primer::Alpha::ActionList::SELECT_VARIANT_OPTIONS) %>
      # @param form_arguments [Hash] Allows an `ActionList` to act as a select list in multi- and single-select modes. Pass the `builder:` and `name:` options to this hash. `builder:` should be an instance of `ActionView::Helpers::FormBuilder`, which are created by the standard Rails `#form_with` and `#form_for` helpers. The `name:` option is the desired name of the field that will be included in the params sent to the server on form submission. *NOTE*: Consider using an <%= link_to_component(Primer::Alpha::ActionMenu) %> instead of using this feature directly.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        id: self.class.generate_id,
        role: nil,
        item_classes: nil,
        scheme: DEFAULT_SCHEME,
        show_dividers: false,
        select_variant: DEFAULT_SELECT_VARIANT,
        form_arguments: {},
        **system_arguments
      )
        @system_arguments = system_arguments
        @id = id
        @system_arguments[:id] = @id
        @system_arguments[:tag] = :ul
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

        @role = role || (allows_selection? ? MENU_ROLE : DEFAULT_ROLE)
        @system_arguments[:role] = @role

        @list_wrapper_arguments = {}

        @form_builder = form_arguments[:builder]
        @input_name = form_arguments[:name]

        return unless required_form_arguments_given? && !allows_selection?

        raise ArgumentError, "lists/menus that act as form inputs must also allow item selection (please pass the `select_variant:` option)"
      end

      # @private
      def before_render
        return unless heading?

        @system_arguments[:"aria-labelledby"] = heading.title_id
        @system_arguments[:"aria-describedby"] = heading.subtitle_id if heading.subtitle?
      end

      # @private
      def build_item(**system_arguments)
        # rubocop:disable Style/IfUnlessModifier
        if single_select? && system_arguments[:active] && items.count(&:active?).positive?
          raise ArgumentError, "only a single item may be active when select_variant is set to :single"
        end
        # rubocop:enable Style/IfUnlessModifier

        system_arguments[:classes] = class_names(
          @item_classes,
          system_arguments[:classes]
        )

        ActionList::Item.new(list: self, **system_arguments)
      end

      def single_select?
        select_variant == :single
      end

      def multi_select?
        select_variant == :multiple || select_variant == :multiple_checkbox
      end

      def allows_selection?
        single_select? || multi_select?
      end

      def acts_as_menu?
        @system_arguments[:role] == :menu
      end

      def required_form_arguments_given?
        @form_builder && @input_name
      end

      def acts_as_form_input?
        required_form_arguments_given? && allows_selection?
      end

      # @private
      def will_add_item(_item); end

      private

      def with_post_list_content(&block)
        @post_list_content_block = block
      end

      attr_reader :post_list_content_block
    end
  end
end
