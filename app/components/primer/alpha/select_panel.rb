# frozen_string_literal: true

module Primer
  module Alpha
    # A select panel is a dropdown that displays a filterable list of items. The list of items can be fetched dynamically
    # from a remote URL or provided statically, and the component allows selecting single items or multiple items.
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
    # `Primer::Alpha::SelectPanel::ItemList (an alias of `<%= link_to_component(Primer::Alpha::ActionList) %>)
    # in the response containing the filtered list of items. The component achieves remote fetching via the
    # [remote-input-element](https://github.com/github/remote-input-element), which sends a request to the
    # server with the filter string in the `q=` parameter. Responses must be HTML fragments, eg. have a content
    # type of `text/html+fragment`. You can either name the template eg. show.html_fragment.erb or respond to
    # that content type directly using Rails' `respond_to` method. Here's an example Rails controller action
    # that accepts the query parameter and renders an HTML fragment:
    #
    # ```ruby
    # class SearchItemsController < ApplicationController
    #   def show
    #     # NOTE: params[:q] may be nil since there is no filter string available
    #     # when the panel is first opened
    #     results = SomeModel.search(params[:q] || "")
    #
    #     respond_to do |format|
    #       format.html_fragment do
    #         # this assumes the template exists in a file named search_items/show.html.erb
    #         render(
    #           "search_items/show",
    #           locals: { results: results },
    #           layout: false,
    #           formats: [:html]
    #         )
    #       end
    #     end
    #   end
    # end
    # ```
    #
    # It is also possible to respond to requests with different content types using the same template:
    #
    # ```ruby
    # respond_to do |format|
    #   format.any(:html, :html_fragment) do
    #     render(
    #       "search_items/show",
    #       locals: { results: results },
    #       layout: false,
    #       formats: [:html, :html_fragment]
    #     )
    #   end
    # end
    # ```
    #
    # The search_items/show.html.erb (or show.html_fragment.erb) template might look like this:
    #
    # ```erb
    # <%= render(Primer::Alpha::SelectPanel::ItemList.new) do |list| %>
    #   <% results.each do |result| %>
    #     <% list.with_item(label: result.title) do |item| %>
    #       <% item.with_description(result.description) %>
    #     <% end %>
    #   <% end %>
    # <% end %>
    # ```
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
    class SelectPanel < Primer::Component
      status :alpha

      # The component that should be used to render the list of items in the body of a SelectPanel.
      ItemList = Primer::Alpha::ActionList

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

      # @return [String] The URL to fetch search results from.
      attr_reader :src

      # @return [String] The unique ID of the panel.
      attr_reader :panel_id

      # @return [String] The unique ID of the panel body.
      attr_reader :body_id

      # @return [Symbol] <%= one_of(Primer::Alpha::ActionMenu::SELECT_VARIANT_OPTIONS) %>
      attr_reader :select_variant

      # @return [Symbol] <%= one_of(Primer::Alpha::SelectPanel::FETCH_STRATEGIES) %>
      attr_reader :fetch_strategy

      # @!visibility private
      attr_reader :preload

      # @return [Boolean] Whether to preload search results when the page loads. If this option is false, results are loaded when the panel is opened.
      alias preload? preload

      # @!visibility private
      attr_reader :show_filter

      # @return [Boolean] Whether or not to show the filter input.
      alias show_filter? show_filter

      # @param src [String] The URL to fetch search results from.
      # @param title [String] The title that appears at the top of the panel.
      # @param id [String] The unique ID of the panel.
      # @param size [Symbol] The size of the panel. <%= one_of(Primer::Alpha::Overlay::SIZE_OPTIONS) %>
      # @param select_variant [Symbol] <%= one_of(Primer::Alpha::ActionList::SELECT_VARIANT_OPTIONS) %>
      # @param fetch_strategy [Symbol] <%= one_of(Primer::Alpha::SelectPanel::FETCH_STRATEGIES) %>
      # @param no_results_label [String] The label to display when no results are found.
      # @param preload [Boolean] Whether to preload search results when the page loads. If this option is false, results are loaded when the panel is opened.
      # @param dynamic_label [Boolean] Whether or not to display the text of the currently selected item in the show button.
      # @param dynamic_label_prefix [String] If provided, the prefix is prepended to the dynamic label and displayed in the show button.
      # @param dynamic_aria_label_prefix [String] If provided, the prefix is prepended to the dynamic label and set as the value of the `aria-label` attribute on the show button.
      # @param body_id [String] The unique ID of the panel body. If not provided, the body ID will be set to the panel ID with a "-body" suffix.
      # @param list_arguments [Hash] Arguments to pass to the underlying `Primer::Alpha::ActionList` component. Only has an effect for the local fetch strategy.
      # @param show_filter [Boolean] Whether or not to show the filter input.
      # @param open_on_load [Boolean] Open the panel when the page loads.
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
        show_filter: true,
        open_on_load: false,
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

        @title = title
        @system_arguments[:tag] = :"select-panel"
        @system_arguments[:preload] = true if @src.present? && preload?

        @system_arguments[:data] = merge_data(
          system_arguments, {
            data: { select_variant: select_variant, open_on_load: open_on_load }.tap do |data|
              data[:dynamic_label] = dynamic_label if dynamic_label
              data[:dynamic_label_prefix] = dynamic_label_prefix if dynamic_label_prefix.present?
              data[:dynamic_aria_label_prefix] = dynamic_aria_label_prefix if dynamic_aria_label_prefix.present?
            end
          }
        )

        @dialog = Primer::BaseComponent.new(
          id: "#{@panel_id}-dialog",
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
          id: "#{@panel_id}-list",
          select_variant: @select_variant,
          body_id: @body_id,
          role: "listbox",
          aria_selection_variant: @select_variant == :multiple ? :checked : :selected,
          aria: {
            label: "#{title} options"
          },
          p: 2
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
          { aria: { controls: "#{@panel_id}-dialog" } }
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
