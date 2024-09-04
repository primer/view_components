# frozen_string_literal: true

module Primer
  module Alpha
    # Select panels allow for selecting from a large number of options and can be thought of as a more capable
    # version of the traditional HTML `<select>` element.
    #
    # Select panels:
    #
    # 1. feature an input field at the top that allows an end user to filter the list of results.
    # 1. can render their items statically or dynamically by fetching results from the server.
    # 1. allow selecting a single item or multiple items.
    # 1. permit leading visuals like Octicons, avatars, and custom SVGs.
    # 1. can be used as form inputs in Rails forms.
    #
    # ## Static list items
    #
    # The Rails `SelectPanel` component allows items to be provided statically or loaded dynamically from the
    # server. Providing items statically is done using a fetch strategy of `:local` in combination with the
    # `item` slot:
    #
    # ```erb
    # <%= render(Primer::Alpha::SelectPanel.new(fetch_strategy: :local))) do |panel| %>
    #   <% panel.with_show_button { "Select item" } %>
    #   <% panel.with_item(label: "Item 1") %>
    #   <% panel.with_item(label: "Item 2") %>
    # <% end %>
    # ```
    #
    # ## Dynamic list items
    #
    # List items can also be fetched dynamically from the server and will require creating a Rails controller action
    # to respond with the list of items in addition to rendering the `SelectPanel` instance. Render the instance as
    # normal, providing your desired [fetch strategy](#fetch-strategies):
    #
    # ```erb
    # <%= render(
    #   Primer::Alpha::SelectPanel.new(
    #     fetch_strategy: :remote,
    #     src: search_items_path  # perhaps a Rails URL helper
    #   )
    # ) %>
    # ```
    #
    # Define a controller action to serve the list of items. The `SelectPanel` component passes any filter text in
    # the `q=` URL parameter.
    #
    # ```ruby
    # class SearchItemsController < ApplicationController
    #   def show
    #     # NOTE: params[:q] may be nil since there is no filter string available
    #     # when the panel is first opened
    #     @results = SomeModel.search(params[:q] || "")
    #   end
    # end
    # ```
    #
    # Responses must be HTML fragments, eg. have a content type of `text/html+fragment`. This content type isn't
    # available by default in Rails, so you may have to register it eg. in an initializer:
    #
    # ```ruby
    # Mime::Type.register("text/fragment+html", :html_fragment)
    # ```
    #
    # Render a `Primer::Alpha::SelectPanel::ItemList` in the action's template, search_items/show.html_fragment.erb:
    #
    # ```erb
    # <%= render(Primer::Alpha::SelectPanel::ItemList.new) do |list| %>
    #   <% @results.each do |result| %>
    #     <% list.with_item(label: result.title) do |item| %>
    #       <% item.with_description(result.description) %>
    #     <% end %>
    #   <% end %>
    # <% end %>
    # ```
    #
    # ### Selection consistency
    #
    # The `SelectPanel` component automatically "remembers" which items have been selected across item fetch requests,
    # meaning the controller that renders dynamic list items does not (and should not) remember these selections or
    # persist them until the user has confirmed them, either by submitting the form or otherwise indicating completion.
    # The `SelectPanel` component does not include unconfirmed selection data in requests.
    #
    # ## Fetch strategies
    #
    # The list of items can be fetched from a remote URL, or provided as a static list, configured using the
    # `fetch_strategy` attribute. Fetch strategies are summarized below.
    #
    # 1. `:remote`: a query is made to the URL in the `src` attribute every time the input field changes.
    #
    # 2. `:eventually_local`: a query is made to the URL in the `src` attribute when the panel is first opened. The
    #     results are "remembered" and filtered in-memory for all subsequent filter operations, i.e. when the input
    #     field changes.
    #
    # 3. `:local`: the list of items is provided statically ahead of time and filtered in-memory. No requests are made
    #     to the server.
    #
    # ## Customizing filter behavior
    #
    # If the fetch strategy is `:remote`, then filtering is handled server-side. The server should render a
    # `Primer::Alpha::SelectPanel::ItemList` (an alias of <%= link_to_component(Primer::Alpha::ActionList) %>)
    # in the response containing the filtered list of items. The component achieves remote fetching via the
    # [remote-input-element](https://github.com/github/remote-input-element), which sends a request to the
    # server with the filter string in the `q=` parameter. Responses must be HTML fragments, eg. have a content
    # type of `text/html+fragment`.
    #
    # ### Local filtering
    #
    # If the fetch strategy is `:local` or `:eventually_local`, filtering is performed client-side. Filter behavior can
    # be customized in JavaScript by setting the `filterFn` attribute on the instance of `SelectPanelElement`, eg:
    #
    # ```javascript
    # document.querySelector("select-panel").filterFn = (item: HTMLElement, query: string): boolean => {
    #   // return true if the item should be displayed, false otherwise
    # }
    # ```
    #
    # The element's default filter function uses the value of the `data-filter-string` attribute, falling back to the
    # element's `innerText` property. It performs a case-insensitive substring match against the filter string.
    #
    # ### `SelectPanel`s as form inputs
    #
    # `SelectPanel`s can be used as form inputs. They behave very similarly to how HTML `<select>` boxes behave, and
    # play nicely with Rails' built-in form mechanisms. Pass arguments via the `form_arguments:` argument, including
    # the Rails form builder object and the name of the field. Each list item must also have a value specified in
    # `content_arguments: { data: { value: } }`.
    #
    # ```erb
    # <% form_with(model: Address.new) do |f| %>
    #   <%= render(Primer::Alpha::SelectPanel.new(form_arguments: { builder: f, name: "country" })) do |menu| %>
    #     <% countries.each do |country|
    #       <% menu.with_item(label: country.name, content_arguments: { data: { value: country.code } }) %>
    #     <% end %>
    #   <% end %>
    # <% end %>
    # ```
    #
    # The value of the `data: { value: ... }` argument is sent to the server on submit, keyed using the name provided above
    # (eg. `"country"`). If no value is provided for an item, the value of that item is the item's label.  Here's the
    # corresponding `AddressesController` that might be written to handle the form above:
    #
    # ```ruby
    # class AddressesController < ApplicationController
    #   def create
    #     puts "You chose #{address_params[:country]} as your country"
    #   end
    #
    #   private
    #
    #   def address_params
    #     params.require(:address).permit(:country)
    #   end
    # end
    # ```
    #
    # If items are provided dynamically, things become a bit more complicated. The `form_for` or `form_with` method call
    # happens in the view that renders the `SelectPanel`, which means the form builder object but isn't available in the
    # view that renders the list items. In such a case, it can be useful to create an instance of the form builder maually:
    #
    # ```erb
    # <% builder = ActionView::Helpers::FormBuilder.new(
    #   "address",  # the name of the model, used to wrap input names, eg 'address[country]'
    #   nil,        # object (eg. the Address instance, which we can omit)
    #   self,       # template
    #   {}          # options
    # ) %>
    # <%= render(Primer::Alpha::SelectPanel::ItemList.new(
    #   form_arguments: { builder: builder, name: "country" }
    # )) do |list| %>
    #   <% countries.each do |country| %>
    #     <% menu.with_item(label: country.name, content_arguments: { data: { value: country.code } }) %>
    #   <% end %>
    # <% end %>
    # ```
    #
    # ### JavaScript API
    #
    # `SelectPanel`s render a `<select-panel>` custom element that exposes behavior to the client.
    #
    # #### Utility methods
    #
    # * `show()`: Manually open the panel. Under normal circumstances, a show button is used to show the panel, but this method exists to support unusual use-cases.
    # * `hide()`: Manually hides (closes) the panel.
    #
    # #### Query methods
    #
    # * `getItemById(itemId: string): Element`: Returns the item's HTML `<li>` element. The return value can be passed as the `item` argument to the other methods listed below.
    # * `isItemChecked(item: Element): boolean`: Returns `true` if the item is checked, `false` otherwise.
    # * `isItemHidden(item: Element): boolean`: Returns `true` if the item is hidden, `false` otherwise.
    # * `isItemDisabled(item: Element): boolean`: Returns `true` if the item is disabled, `false` otherwise.
    #
    # NOTE: Item IDs are special values provided by the user that are attached to `SelectPanel` list items as the `data-item-id`
    # HTML attribute. Item IDs can be provided by passing an `item_id:` attribute when adding items to the panel, eg:
    #
    # ```erb
    # <%= render(Primer::Alpha::SelectPanel.new) do |panel| %>
    #   <% panel.with_item(item_id: "my-id") %>
    # <% end %>
    # ```
    #
    # The same is true when rendering `ItemList`s:
    #
    # ```erb
    # <%= render(Primer::Alpha::SelectPanel::ItemList.new) do |list| %>
    #   <% list.with_item(item_id: "my-id") %>
    # <% end %>
    # ```
    #
    # #### State methods
    #
    # * `enableItem(item: Element)`: Enables the item, i.e. makes it clickable by the mouse and keyboard.
    # * `disableItem(item: Element)`: Disables the item, i.e. makes it unclickable by the mouse and keyboard.
    # * `checkItem(item: Element)`: Checks the item. Only has an effect in single- and multi-select modes.
    # * `uncheckItem(item: Element)`: Unchecks the item. Only has an effect in multi-select mode, since items cannot be unchecked in single-select mode.
    #
    # #### Events
    #
    # |Name                 |Type                                       |Bubbles |Cancelable |
    # |:--------------------|:------------------------------------------|:-------|:----------|
    # |`itemActivated`      |`CustomEvent<ItemActivatedEvent>`          |Yes     |No         |
    # |`beforeItemActivated`|`CustomEvent<ItemActivatedEvent>`          |Yes     |Yes        |
    # |`dialog:open`        |`CustomEvent<{dialog: HTMLDialogElement}>` |No      |No         |
    # |`panelClosed`        |`CustomEvent<{panel: SelectPanelElement}>` |Yes     |No         |
    #
    # _Item activation_
    #
    # The `<select-panel>` element fires an `itemActivated` event whenever an item is activated (eg. clicked) via the mouse or keyboard.
    #
    # ```typescript
    # document.querySelector("select-panel").addEventListener(
    #   "itemActivated",
    #   (event: CustomEvent<ItemActivatedEvent>) => {
    #     event.detail.item     // Element: the <li> item that was activated
    #     event.detail.checked  // boolean: whether or not the result of the activation checked the item
    #   }
    # )
    # ```
    #
    # The `beforeItemActivated` event fires before an item is activated. Canceling this event will prevent the item
    # from being activated.
    #
    # ```typescript
    # document.querySelector("select-panel").addEventListener(
    #   "beforeItemActivated",
    #   (event: CustomEvent<ItemActivatedEvent>) => {
    #     event.detail.item      // Element: the <li> item that was activated
    #     event.detail.checked   // boolean: whether or not the result of the activation checked the item
    #     event.preventDefault() // Cancel the event to prevent activation (eg. checking/unchecking)
    #   }
    # )
    # ```
    class SelectPanel < Primer::Component
      # The component that should be used to render the list of items in the body of a SelectPanel.
      class ItemList < Primer::Alpha::ActionList
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList) %>.
        def initialize(**system_arguments)
          select_variant = system_arguments[:select_variant] || Primer::Alpha::ActionList::DEFAULT_SELECT_VARIANT

          super(
            p: 2,
            role: "listbox",
            aria_selection_variant: select_variant == :single ? :selected : :checked,
            **system_arguments
          )
        end
      end

      status :alpha

      DEFAULT_PRELOAD = false

      DEFAULT_FETCH_STRATEGY = :remote
      FETCH_STRATEGIES = [
        DEFAULT_FETCH_STRATEGY,
        :eventually_local,
        :local
      ]

      DEFAULT_SELECT_VARIANT = :single
      SELECT_VARIANT_OPTIONS = [
        DEFAULT_SELECT_VARIANT,
        :multiple,
        :none,
      ].freeze

      # The URL to fetch search results from.
      #
      # @return [String]
      attr_reader :src

      # The unique ID of the panel.
      #
      # @return [String]
      attr_reader :panel_id

      # The unique ID of the panel body.
      #
      # @return [String]
      attr_reader :body_id

      # <%= one_of(Primer::Alpha::ActionMenu::SELECT_VARIANT_OPTIONS) %>
      #
      # @return [Symbol]
      attr_reader :select_variant

      # <%= one_of(Primer::Alpha::SelectPanel::FETCH_STRATEGIES) %>
      #
      # @return [Symbol]
      attr_reader :fetch_strategy

      # Whether to preload search results when the page loads. If this option is false, results are loaded when the panel is opened.
      #
      # @return [Boolean]
      attr_reader :preload

      alias preload? preload

      # Whether or not to show the filter input.
      #
      # @return [Boolean]
      attr_reader :show_filter

      alias show_filter? show_filter

      # @param src [String] The URL to fetch search results from.
      # @param title [String] The title that appears at the top of the panel.
      # @param id [String] The unique ID of the panel.
      # @param size [Symbol] The size of the panel. <%= one_of(Primer::Alpha::Overlay::SIZE_OPTIONS) %>
      # @param select_variant [Symbol] <%= one_of(Primer::Alpha::SelectPanel::SELECT_VARIANT_OPTIONS) %>
      # @param fetch_strategy [Symbol] <%= one_of(Primer::Alpha::SelectPanel::FETCH_STRATEGIES) %>
      # @param no_results_label [String] The label to display when no results are found.
      # @param preload [Boolean] Whether to preload search results when the page loads. If this option is false, results are loaded when the panel is opened.
      # @param dynamic_label [Boolean] Whether or not to display the text of the currently selected item in the show button.
      # @param dynamic_label_prefix [String] If provided, the prefix is prepended to the dynamic label and displayed in the show button.
      # @param dynamic_aria_label_prefix [String] If provided, the prefix is prepended to the dynamic label and set as the value of the `aria-label` attribute on the show button.
      # @param body_id [String] The unique ID of the panel body. If not provided, the body ID will be set to the panel ID with a "-body" suffix.
      # @param list_arguments [Hash] Arguments to pass to the underlying <%= link_to_component(Primer::Alpha::ActionList) %> component. Only has an effect for the local fetch strategy.
      # @param form_arguments [Hash] Form arguments to pass to the underlying <%= link_to_component(Primer::Alpha::ActionList) %> component. Only has an effect for the local fetch strategy.
      # @param show_filter [Boolean] Whether or not to show the filter input.
      # @param open_on_load [Boolean] Open the panel when the page loads.
      # @param anchor_align [Symbol] The anchor alignment of the Overlay. <%= one_of(Primer::Alpha::Overlay::ANCHOR_ALIGN_OPTIONS) %>
      # @param anchor_side [Symbol] The side to anchor the Overlay to. <%= one_of(Primer::Alpha::Overlay::ANCHOR_SIDE_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        src: nil,
        title: "Menu",
        id: self.class.generate_id,
        size: :small,
        select_variant: DEFAULT_SELECT_VARIANT,
        fetch_strategy: DEFAULT_FETCH_STRATEGY,
        no_results_label: "No results found",
        preload: DEFAULT_PRELOAD,
        dynamic_label: false,
        dynamic_label_prefix: nil,
        dynamic_aria_label_prefix: nil,
        body_id: nil,
        list_arguments: {},
        form_arguments: {},
        show_filter: true,
        open_on_load: false,
        anchor_align: Primer::Alpha::Overlay::DEFAULT_ANCHOR_ALIGN,
        anchor_side: Primer::Alpha::Overlay::DEFAULT_ANCHOR_SIDE,
        **system_arguments
      )
        if src.present?
          url = URI(src)
          query = url.query || ""
          url.query = query.split("&").push("experimental=1").join("&")
          @src = url
        end

        @panel_id = id
        @body_id = body_id || "#{@panel_id}-body"
        @preload = fetch_or_fallback_boolean(preload, DEFAULT_PRELOAD)
        @select_variant = fetch_or_fallback(SELECT_VARIANT_OPTIONS, select_variant, DEFAULT_SELECT_VARIANT)
        @fetch_strategy = fetch_or_fallback(FETCH_STRATEGIES, fetch_strategy, DEFAULT_FETCH_STRATEGY)
        @no_results_label = no_results_label
        @show_filter = show_filter
        @dynamic_label = dynamic_label
        @dynamic_label_prefix = dynamic_label_prefix
        @dynamic_aria_label_prefix = dynamic_aria_label_prefix

        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:id] = @panel_id
        @system_arguments[:"anchor-align"] = fetch_or_fallback(Primer::Alpha::Overlay::ANCHOR_ALIGN_OPTIONS, anchor_align, Primer::Alpha::Overlay::DEFAULT_ANCHOR_ALIGN)
        @system_arguments[:"anchor-side"] = Primer::Alpha::Overlay::ANCHOR_SIDE_MAPPINGS[fetch_or_fallback(Primer::Alpha::Overlay::ANCHOR_SIDE_OPTIONS, anchor_side, Primer::Alpha::Overlay::DEFAULT_ANCHOR_SIDE)]

        @title = title
        @system_arguments[:tag] = :"select-panel"
        @system_arguments[:preload] = true if @src.present? && preload?

        @system_arguments[:data] = merge_data(
          system_arguments, {
            data: { select_variant: @select_variant, fetch_strategy: @fetch_strategy, open_on_load: open_on_load }.tap do |data|
              data[:dynamic_label] = dynamic_label if dynamic_label
              data[:dynamic_label_prefix] = dynamic_label_prefix if dynamic_label_prefix.present?
              data[:dynamic_aria_label_prefix] = dynamic_aria_label_prefix if dynamic_aria_label_prefix.present?
            end
          }
        )

        @dialog = Primer::BaseComponent.new(
          id: "#{@panel_id}-dialog",
          "aria-labelledby": "#{@panel_id}-dialog-title",
          tag: :dialog,
          data: { target: "select-panel.dialog" },
          classes: class_names(
            "Overlay",
            "Overlay-whenNarrow",
            Primer::Alpha::Dialog::SIZE_MAPPINGS[
              fetch_or_fallback(Primer::Alpha::Dialog::SIZE_OPTIONS, size, Primer::Alpha::Dialog::DEFAULT_SIZE)
            ],
          ),
          style: "position: absolute;",
        )

        @list = Primer::Alpha::SelectPanel::ItemList.new(
          **list_arguments,
          form_arguments: form_arguments,
          id: "#{@panel_id}-list",
          select_variant: @select_variant,
          role: "listbox",
          aria_selection_variant: @select_variant == :multiple ? :checked : :selected,
          aria: {
            label: "#{title} options"
          },
          p: 2
        )

        return if @show_filter || @fetch_strategy != :remote
        return if shouldnt_raise_error?

        raise(
          "Hiding the filter input with a remote fetch strategy is not permitted, "\
          "since such a combinaton of options will cause the component to only "\
          "fetch items from the server once when the panel opens for the first time; "\
          "this is what the `:eventually_local` fetch strategy is designed to do. "\
          "Consider passing `show_filter: true` or use the `:eventually_local` fetch "\
          "strategy instead."
        )
      end

      # @!parse
      #   # Adds an item to the list. Note that this method only has an effect for the local fetch strategy.
      #   #
      #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList) %>'s `item` slot.
      #   def with_item(**system_arguments)
      #   end
      #
      #   # Adds an avatar item to the list. Note that this method only has an effect for the local fetch strategy.
      #
      #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList) %>'s `item` slot.
      #   def with_avatar_item
      #   end

      delegate :with_item, :with_avatar_item, to: :@list

      # Renders content in a footer region below the list of items.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::Dialog::Footer) %>.
      renders_one :footer, Primer::Alpha::Dialog::Footer

      # Renders content underneath the title at the top of the panel.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::Dialog::Header) %>'s `subtitle` slot.
      renders_one :subtitle

      # Adds a show button (i.e. a button) that will open the panel when clicked.
      #
      # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Beta::Button) %>.
      renders_one :show_button, lambda { |**system_arguments|
        system_arguments[:id] = "#{@panel_id}-button"

        system_arguments[:aria] = merge_aria(
          system_arguments,
          { aria: { controls: "#{@panel_id}-dialog", "haspopup": "dialog", "expanded": "false" } }
        )

        Primer::Beta::Button.new(**system_arguments)
      }

      # Customizable content for the error message that appears when items are fetched for the first time. This message
      # appears in place of the list of items.
      # For more information, see the [documentation regarding SelectPanel error messaging](/components/selectpanel#errorwarning).
      renders_one :preload_error_content

      # Customizable content for the error message that appears when items are fetched as the result of a filter
      # operation. This message appears as a banner above the previously fetched list of items.
      # For more information, see the [documentation regarding SelectPanel error messaging](/components/selectpanel#errorwarning).
      renders_one :error_content

      private

      def before_render
        content
      end
    end
  end
end
