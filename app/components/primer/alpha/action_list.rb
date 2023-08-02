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
      audited_at "2023-07-10"

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

      # @!parse
      #   # Adds an item to the list.
      #   #
      #   # @param component_klass [Class] The class to use instead of the default <%= link_to_component(Primer::Alpha::ActionList::Item) %>
      #   # @param system_arguments [Hash] These arguments are forwarded to <%= link_to_component(Primer::Alpha::ActionList::Item) %>, or whatever class is passed as the `component_klass` argument.
      #   def with_item(**system_arguments, &block)
      #   end

      # @!parse
      #   # Adds a divider to the list. Dividers visually separate items.
      #   #
      #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList::Divider) %>.
      #   def with_divider(**system_arguments, &block)
      #   end

      # @!parse
      #   # Adds an avatar item to the list. Avatar items are a convenient way to accessibly add an item with a leading avatar image.
      #   #
      #   # @param src [String] The source url of the avatar image.
      #   # @param username [String] The username associated with the avatar.
      #   # @param full_name [String] Optional. The user's full name.
      #   # @param full_name_scheme [Symbol] Optional. How to display the user's full name. <%= one_of(Primer::Alpha::ActionList::Item::DESCRIPTION_SCHEME_OPTIONS) %>
      #   # @param component_klass [Class] The class to use instead of the default <%= link_to_component(Primer::Alpha::ActionList::Item) %>
      #   # @param avatar_arguments [Hash] Optional. The arguments accepted by <%= link_to_component(Primer::Beta::Avatar) %>
      #   # @param system_arguments [Hash] These arguments are forwarded to <%= link_to_component(Primer::Alpha::ActionList::Item) %>, or whatever class is passed as the `component_klass` argument.
      #   def with_avatar_item(src:, username:, full_name: nil, full_name_scheme: Primer::Alpha::ActionList::Item::DEFAULT_DESCRIPTION_SCHEME, component_klass: ActionList::Item, avatar_arguments: {}, **system_arguments, &block)
      #   end

      # Items. Items can be individual items, avatar items, or dividers. See the documentation for `#with_item`, `#with_divider`, and `#with_avatar_item` respectively for more information.
      #
      renders_many :items, types: {
        item: {
          renders: lambda { |**system_arguments|
            build_item(**system_arguments).tap do |item|
              will_add_item(item)
            end
          },

          as: :item
        },

        avatar_item: {
          renders: lambda { |**system_arguments|
            build_avatar_item(**system_arguments).tap do |item|
              will_add_item(item)
            end
          },

          as: :avatar_item
        },

        divider: {
          renders: ActionList::Divider,
          as: :divider
        }
      }

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

      # Builds a new item but does not add it to the list. Use this method
      # instead of the `#with_item` slot if you need to render an item outside
      # the context of a list, eg. if rendering additional items to append to
      # an existing list, perhaps via a separate HTTP request.
      #
      # @param component_klass [Class] The class to use instead of the default <%= link_to_component(Primer::Alpha::ActionList::Item) %>
      # @param system_arguments [Hash] These arguments are forwarded to <%= link_to_component(Primer::Alpha::ActionList::Item) %>, or whatever class is passed as the `component_klass` argument.
      def build_item(component_klass: ActionList::Item, **system_arguments)
        # rubocop:disable Style/IfUnlessModifier
        if single_select? && system_arguments[:active] && items.count(&:active?).positive?
          raise ArgumentError, "only a single item may be active when select_variant is set to :single"
        end
        # rubocop:enable Style/IfUnlessModifier

        system_arguments[:classes] = class_names(
          @item_classes,
          system_arguments[:classes]
        )

        component_klass.new(list: self, **system_arguments)
      end

      # Builds a new avatar item but does not add it to the list. Avatar items
      # are a convenient way to accessibly add an item with a leading avatar
      # image. Use this method instead of the `#with_avatar_item` slot if you
      # need to render an avatar item outside the context of a list, eg. if
      # rendering additional items to append to an existing list, perhaps via
      # a separate HTTP request.
      #
      # @param src [String] The source url of the avatar image.
      # @param username [String] The username associated with the avatar.
      # @param full_name [String] Optional. The user's full name.
      # @param full_name_scheme [Symbol] Optional. How to display the user's full name. <%= one_of(Primer::Alpha::ActionList::Item::DESCRIPTION_SCHEME_OPTIONS) %>
      # @param component_klass [Class] The class to use instead of the default <%= link_to_component(Primer::Alpha::ActionList::Item) %>
      # @param avatar_arguments [Hash] Optional. The arguments accepted by <%= link_to_component(Primer::Beta::Avatar) %>
      # @param system_arguments [Hash] These arguments are forwarded to <%= link_to_component(Primer::Alpha::ActionList::Item) %>, or whatever class is passed as the `component_klass` argument.
      def build_avatar_item(src:, username:, full_name: nil, full_name_scheme: Primer::Alpha::ActionList::Item::DEFAULT_DESCRIPTION_SCHEME, component_klass: ActionList::Item, avatar_arguments: {}, **system_arguments)
        build_item(label: username, description_scheme: full_name_scheme, component_klass: component_klass, **system_arguments).tap do |item|
          item.with_leading_visual_raw_content do
            # no alt text necessary for presentational item
            item.render(Primer::Beta::Avatar.new(src: src, **avatar_arguments, role: :presentation, size: 16))
          end

          item.with_description_content(full_name) if full_name
        end
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
