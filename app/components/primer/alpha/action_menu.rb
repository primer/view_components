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
    # `ActionMenu`s render an `<action-menu>` custom element that exposes behavior to the client.
    #
    # #### Query methods
    #
    # * `getItemById(itemId: string): Element`: Returns the item's HTML `<li>` element. The return value can be passed as the `item` argument to the other methods listed below.
    # * `isItemChecked(item: Element): boolean`: Returns `true` if the item is checked, `false` otherwise.
    # * `isItemHidden(item: Element): boolean`: Returns `true` if the item is hidden, `false` otherwise.
    # * `isItemDisabled(item: Element): boolean`: Returns `true` if the item is disabled, `false` otherwise.
    #
    # NOTE: Item IDs are special values provided by the user that are attached to `ActionMenu` items as the `data-item-id`
    # HTML attribute. Item IDs can be provided by passing an `item_id:` attribute when adding items to the list, eg:
    #
    # ```erb
    # <%= render(Primer::Alpha::ActionMenu.new) do |menu| %>
    #   <% menu.with_item(item_id: "my-id") %>
    # <% end %>
    # ```
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
    # document.querySelector("action-menu").addEventListener("itemActivated", (event: CustomEvent<ItemActivatedEvent>) => {
    #   event.detail.item     // Element: the <li> item that was activated
    #   event.detail.checked  // boolean: whether or not the result of the activation checked the item
    # })
    # ```
    class ActionMenu < Primer::Component
      status :alpha

      delegate :preload, :preload?, :list, to: :@primary_menu
      delegate :with_show_button, :with_item, :items, :with_divider, :with_avatar_item, :with_group, :with_sub_menu_item, to: :@primary_menu

      # @!parse
      #   # Adds an item to the menu.
      #   #
      #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList) %>'s `item` slot.
      #   def with_item(**system_arguments)
      #   end
      #
      #   # Adds an avatar item to the menu.
      #   #
      #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList) %>'s `item` slot.
      #   def with_avatar_item(**system_arguments)
      #   end
      #
      #   # Adds a divider to the list. Dividers visually separate items.
      #   #
      #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList::Divider) %>.
      #   def with_divider(**system_arguments)
      #   end
      #
      #   # Adds a group to the menu. Groups are a logical set of items with a header.
      #   #
      #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionMenu::Group) %>.
      #   def with_group(**system_arguments)
      #   end
      #
      #   # Gets the list of configured menu items, which includes regular items, avatar items, groups, and dividers.
      #   #
      #   # @return [Array<ViewComponent::Slot>]
      #   def items
      #   end

      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionMenu::PrimaryMenu) %>.
      def initialize(**system_arguments)
        @primary_menu = PrimaryMenu.allocate
        @system_arguments = @primary_menu.send(:initialize, **system_arguments)

        @system_arguments[:tag] = :"action-menu"
        @system_arguments[:preload] = true if @primary_menu.preload?

        @system_arguments[:data] = merge_data(
          @system_arguments, {
            data: { "select-variant": @primary_menu.select_variant }
          }
        )

        @system_arguments[:"data-dynamic-label"] = "" if @primary_menu.dynamic_label

        if @primary_menu.dynamic_label_prefix.present?
          @system_arguments[:"data-dynamic-label-prefix"] = @primary_menu.dynamic_label_prefix
        end
      end

      private

      def before_render
        content
      end

      def render?
        @primary_menu.items.any? || @primary_menu.src.present?
      end
    end
  end
end
