# typed: false
# frozen_string_literal: true

module Primer
  module Alpha
    # ActionMenu is used for actions, navigation, to display secondary options, or single/multi select lists. They appear when
    # users interact with buttons, actions, or other controls.
    #
    # The only allowed elements for the `Item` components are: `:a`, `:button`, and `:clipboard-copy`. The default is `:button`.
    #
    # ### Select variants
    #
    # While `ActionMenu`s default to a list of buttons that can link to other pages, copy text to the clipboard, etc, they also support
    # `single` and `multiple` select variants. The single select variant allows a single item to be "selected" (i.e. marked "active")
    # when clicked, which will cause a check mark to appear to the left of the item text. When the `multiple` select variant is chosen,
    # multiple items may be selected and check marks will appear next to each selected item.
    #
    # Use the `select_variant:` option to control which variant the `ActionMenu` uses. For more information, see the documentation on
    # supported arguments below.
    #
    # ### Dynamic labels
    #
    # When using the `single` select variant, an optional label indicating the selected item can be displayed inside the menu button.
    # Dynamic labels can also be prefixed with custom text.
    #
    # Pass `dynamic_label: true` to enable dynamic label behavior, and pass `dynamic_label_prefix: "<string>"` to set a custom prefix.
    # For more information, see the documentation on supported arguments below.
    #
    # ### `ActionMenu`s as form inputs
    #
    # When using either the `single` or `multiple` select variants, `ActionMenu`s can be used as form inputs. They behave very
    # similarly to how HTML `<select>` boxes behave, and play nicely with Rails' built-in form mechanisms. Pass arguments via the
    # `form_arguments:` argument, including the Rails form builder object and the name of the field:
    #
    # ```erb
    # <% form_with(url: update_merge_strategy_path) do |f| %>
    #   <%= render(Primer::Alpha::ActionMenu.new(form_arguments: { builder: f, name: "merge_strategy" })) do |menu| %>
    #     <% menu.with_item(label: "Fast forward", data: { value: "fast_forward" }) %>
    #     <% menu.with_item(label: "Recursive", data: { value: "recursive" }) %>
    #     <% menu.with_item(label: "Ours", data: { value: "ours" }) %>
    #     <% menu.with_item(label: "Theirs", data: { value: "theirs" }) %>
    #   <% end %>
    # <% end %>
    # ```
    #
    # The value of the `data: { value: ... }` argument is sent to the server on submit, keyed using the name provided above
    # (eg. `"merge_strategy"`). If no value is provided for an item, the value of that item is the item's label.  Here's the
    # corresponding `MergeStrategyController` that might be written to handle the form above:
    #
    # ```ruby
    # class MergeStrategyController < ApplicationController
    #   def update
    #     puts "You chose #{merge_strategy_params[:merge_strategy]}"
    #   end
    #
    #   private
    #
    #   def merge_strategy_params
    #     params.permit(:merge_strategy)
    #   end
    # end
    # ```
    #
    # ### `ActionMenu` items that submit forms
    #
    # Whereas `ActionMenu` items normally permit navigation via `<a>` tags which make HTTP `get` requests, `ActionMenu` items
    # also permit navigation via `POST` requests. To enable this behavior, include the `href:` argument as normal, but also pass
    # the `form_arguments:` argument to the appropriate item:
    #
    # ```erb
    # <%= render(Primer::Alpha::ActionMenu.new) do |menu| %>
    #   <% menu.with_item(
    #     label: "Repository",
    #     href: update_repo_grouping_path,
    #     form_arguments: {
    #       method: :post,
    #       name: "group_by",
    #       value: "repository"
    #     }
    #   ) %>
    # <% end %>
    # ```
    #
    # Make sure to specify `method: :post`, as the default is `:get`. When clicked, the list item will submit a POST request to
    # the URL passed in the `href:` argument, including a parameter named `"group_by"` with a value of `"repository"`. If no value
    # is given, the name, eg. `"group_by"`, will be used as the value.
    #
    # It is possible to include multiple fields on submit. Instead of passing the `name:` and `value:` arguments, pass an array via
    # the `inputs:` argument:
    #
    # ```erb
    # <%= render(Primer::Alpha::ActionMenu.new) do |menu| %>
    #   <% menu.with_show_button { "Group By" } %>
    #   <% menu.with_item(
    #     label: "Repository",
    #     href: update_repo_grouping_path,
    #     form_arguments: {
    #       method: :post,
    #       inputs: [{
    #         name: "group_by",
    #         value: "repository"
    #       }, {
    #         name: "some_other_field",
    #         value: "some value",
    #       }],
    #     }
    #   ) %>
    # <% end %>
    # ```
    #
    # ### Form arguments
    #
    # The following table summarizes the arguments allowed in the `form_arguments:` hash mentioned above.
    #
    # |Name             |Type          |Default|Description|
    # |:----------------|:-------------|:------|:----------|
    # |`method`         |`Symbol`      |`:get` |The HTTP request method to use to submit the form. One of `:get`, `:post`, `:patch`, `:put`, `:delete`, or `:head`|
    # |`name`           |`String`      |`nil`  |The name of the field that will be sent to the server on submit.|
    # |`value`          |`String`      |`nil`  |The value of the field that will be sent to the server on submit.|
    # |`input_arguments`|`Hash`        |`{}`   |Additional key/value pairs to emit as HTML attributes on the `<input type="hidden">` element.|
    # |`inputs`         |`Array<Hash>` |`[]`   |An array of hashes representing HTML `<input type="hidden">` elements. Must contain at least `name:` and `value:` keys. If additional key/value pairs are provided, they are emitted as HTML attributes on the `<input>` element. This argument supercedes the `name:`, `value:`, and `:input_arguments` arguments listed above.|
    #
    # The elements of the `inputs:` array will be emitted as HTML `<input type="hidden">` elements.
    #
    # @accessibility
    #   The action for the menu item needs to be on the element with `role="menuitem"`. Semantics are removed for everything
    #   nested inside of it. When a menu item is selected, the menu will close immediately.
    #
    #   Additional information around the keyboard functionality and implementation can be found on the
    #   [WAI-ARIA Authoring Practices](https://www.w3.org/TR/wai-aria-practices-1.2/#menu).
    #
    # ### JavaScript API
    #
    # `ActionList`s render an `<action-list>` custom element that exposes behavior to the client. For all these methods,
    # `itemId` refers to the value of the `item_id:` argument (see below) that is used to populate the `data-item-id` HTML
    # attribute.
    #
    # #### Query methods
    #
    # * `getItemById(itemId: string): Element`: Returns the item's HTML `<li>` element. The return value can be passed as the `item` argument to the other methods listed below.
    # * `isItemChecked(item: Element): boolean`: Returns `true` if the item is checked, `false` otherwise.
    # * `isItemHidden(item: Element): boolean`: Returns `true` if the item is hidden, `false` otherwise.
    # * `isItemDisabled(item: Element): boolean`: Returns `true` if the item is disabled, `false` otherwise.
    #
    # #### State methods
    #
    # * `showItem(item: Element)`: Shows the item, i.e. makes it visible.
    # * `hideItem(item: Element)`: Hides the item, i.e. makes it invisible.
    # * `enableItem(item: Element)`: Enables the item, i.e. makes it clickable by the mouse and keyboard.
    # * `disableItem(item: Element)`: Disables the item, i.e. makes it unclickable by the mouse and keyboard.
    # * `checkItem(item: Element)`: Checks the item. Only has an effect in single- and multi-select modes.
    # * `uncheckItem(item: Element)`: Unchecks the item. Only has an effect in multi-select mode, since items cannot be unchecked in single-select mode.
    #
    # #### Events
    #
    # The `<action-menu>` element fires an `itemActivated` event whenever an item is activated (eg. clicked) via the mouse or keyboard.
    #
    # ```typescript
    # document.querySelector("action-menu").addEventListener("itemActivated", (event: ItemActivatedEvent) => {
    #   event.item  // Element: the <li> item that was activated
    #   event.checked  // boolean: whether or not the result of the activation checked the item
    # })
    #
    # The `<action-menu>` element fires a `dialogItemActivated` event whenever an item is activated (eg. clicked) via the mouse or keyboard that displays a dialog.
    #
    # ```typescript
    # document.querySelector("action-menu").addEventListener("dialogItemActivated", (event: DialogItemActivatedEvent) => {
    #   event.item     // Element: the <li> item that was activated
    #   event.checked  // boolean: whether or not the result of the activation checked the item
    #   event.dialog   // Element: the <dialog> element that was shown.
    # })
    # ```
    class ActionMenu < Primer::Component
      status :alpha

      DEFAULT_PRELOAD = false

      DEFAULT_SELECT_VARIANT = :none
      SELECT_VARIANT_OPTIONS = [
        :single,
        :multiple,
        :multiple_checkbox,
        DEFAULT_SELECT_VARIANT
      ].freeze

      attr_reader :list, :preload

      alias preload? preload

      # @param menu_id [String] Id of the menu.
      # @param anchor_align [Symbol] <%= one_of(Primer::Alpha::Overlay::ANCHOR_ALIGN_OPTIONS) %>.
      # @param anchor_side [Symbol] <%= one_of(Primer::Alpha::Overlay::ANCHOR_SIDE_OPTIONS) %>.
      # @param size [Symbol] <%= one_of(Primer::Alpha::Overlay::SIZE_OPTIONS) %>.
      # @param src [String] Used with an `include-fragment` element to load menu content from the given source URL.
      # @param preload [Boolean] When true, and src is present, loads the `include-fragment` on trigger hover.
      # @param dynamic_label [Boolean] Whether or not to display the text of the currently selected item in the show button.
      # @param dynamic_label_prefix [String] If provided, the prefix is prepended to the dynamic label and displayed in the show button.
      # @param select_variant [Symbol] <%= one_of(Primer::Alpha::ActionMenu::SELECT_VARIANT_OPTIONS) %>
      # @param form_arguments [Hash] Allows an `ActionMenu` to act as a select list in multi- and single-select modes. Pass the `builder:` and `name:` options to this hash. `builder:` should be an instance of `ActionView::Helpers::FormBuilder`, which are created by the standard Rails `#form_with` and `#form_for` helpers. The `name:` option is the desired name of the field that will be included in the params sent to the server on form submission.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>.
      def initialize(
        menu_id: self.class.generate_id,
        anchor_align: Primer::Alpha::Overlay::DEFAULT_ANCHOR_ALIGN,
        anchor_side: Primer::Alpha::Overlay::DEFAULT_ANCHOR_SIDE,
        size: Primer::Alpha::Overlay::DEFAULT_SIZE,
        src: nil,
        preload: DEFAULT_PRELOAD,
        dynamic_label: false,
        dynamic_label_prefix: nil,
        select_variant: DEFAULT_SELECT_VARIANT,
        form_arguments: {},
        **system_arguments
      )
        @menu_id = menu_id
        @src = src
        @preload = fetch_or_fallback_boolean(preload, DEFAULT_PRELOAD)
        @system_arguments = deny_tag_argument(**system_arguments)

        @system_arguments[:preload] = true if @src.present? && preload?

        @select_variant = fetch_or_fallback(SELECT_VARIANT_OPTIONS, select_variant, DEFAULT_SELECT_VARIANT)

        @system_arguments[:tag] = :"action-menu"
        @system_arguments[:"data-select-variant"] = select_variant
        @system_arguments[:"data-dynamic-label"] = "" if dynamic_label
        @system_arguments[:"data-dynamic-label-prefix"] = dynamic_label_prefix if dynamic_label_prefix.present?

        @overlay = Primer::Alpha::Overlay.new(
          id: "#{@menu_id}-overlay",
          title: "Menu",
          visually_hide_title: true,
          anchor_align: anchor_align,
          anchor_side: anchor_side,
          size: size
        )

        @list = Primer::Alpha::ActionMenu::List.new(
          menu_id: @menu_id,
          select_variant: select_variant,
          form_arguments: form_arguments
        )
      end

      # @!parse
      #   # Button to activate the menu.
      #   #
      #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::Overlay) %>'s `show_button` slot.
      #   renders_one(:show_button)

      # Button to activate the menu.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::Overlay) %>'s `show_button` slot.
      def with_show_button(**system_arguments, &block)
        @overlay.with_show_button(**system_arguments, id: "#{@menu_id}-button", controls: "#{@menu_id}-list", &block)
      end

      # @!parse
      #   # Adds a new item to the list.
      #   #
      #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList::Item) %>.
      #   renders_many(:items)

      # Adds a new item to the list.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList::Item) %>.
      def with_item(**system_arguments, &block)
        @list.with_item(**system_arguments, &block)
      end

      # Adds a divider to the list.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList) %>'s `divider` slot.
      def with_divider(**system_arguments, &block)
        @list.with_divider(**system_arguments, &block)
      end

      # Adds an avatar item to the list. Avatar items are a convenient way to accessibly add an item with a leading avatar image.
      #
      # @param src [String] The source url of the avatar image.
      # @param username [String] The username associated with the avatar.
      # @param full_name [String] Optional. The user's full name.
      # @param full_name_scheme [Symbol] Optional. How to display the user's full name.
      # @param avatar_arguments [Hash] Optional. The arguments accepted by <%= link_to_component(Primer::Beta::Avatar) %>.
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList::Item) %>.
      def with_avatar_item(**system_arguments, &block)
        @list.with_avatar_item(**system_arguments, &block)
      end

      def with_group(**system_arguments, &block)
        @list.with_group(**system_arguments, &block)
      end

      private

      def before_render
        content

        raise ArgumentError, "`items` cannot be set when `src` is specified" if @src.present? && @list.items.any?
      end

      def render?
        @list.items.any? || @src.present?
      end
    end
  end
end
