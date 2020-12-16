# frozen_string_literal: true

module Primer
  # Use select menus to list clickable choices, allow filtering between them, and highlight
  # which ones are selected.
  class SelectMenuComponent < Primer::Component
    include ViewComponent::Slotable

    LIST_BORDER_CLASSES = {
      all: nil,
      omit_top: "border-top-0",
      none: "SelectMenu-list--borderless",
    }.freeze
    DEFAULT_LIST_BORDER_CLASS = :all
    DEFAULT_LOADING = false
    DEFAULT_BLANKSLATE = false
    DEFAULT_ALIGN_RIGHT = false

    with_slot :summary, class_name: "Summary"
    with_slot :header, class_name: "Header"
    with_slot :item, class_name: "Item", collection: true
    with_slot :filter, class_name: "Filter"
    with_slot :footer, class_name: "Footer"

    attr_reader :message

    #
    # @example 193|Basic example|
    #   <%= render Primer::SelectMenuComponent.new do |component| %>
    #     <%= component.slot(:summary) do %>
    #       Choose an option
    #     <% end %>
    #     <%= component.slot(:header) do %>
    #       My menu
    #     <% end %>
    #     <%= component.slot(:item, selected: true) do %>
    #       Item 1
    #     <% end %>
    #     <%= component.slot(:item) do %>
    #       Item 2
    #     <% end %>
    #     <%= component.slot(:item) do %>
    #       Item 3
    #     <% end %>
    #   <% end %>
    #
    # @example 193|Close button|Include a button to close the menu:
    #   <%= render Primer::SelectMenuComponent.new do |component| %>
    #     <%= component.slot(:summary) do %>
    #       Choose an option
    #     <% end %>
    #     <%= component.slot(:header, closeable: true) do %>
    #       My menu
    #     <% end %>
    #     <%= component.slot(:item) do %>
    #       Item 1
    #     <% end %>
    #     <%= component.slot(:item) do %>
    #       Item 2
    #     <% end %>
    #     <%= component.slot(:item) do %>
    #       Item 3
    #     <% end %>
    #   <% end %>
    #
    # @example 242|Filter|If the list is expected to get long, consider adding a filter input. On mobile devices it will add a fixed height and anchor the select menu to the top of the screen. This makes sure the filter input stays at the same position while typing.
    #   <%= render Primer::SelectMenuComponent.new do |component| %>
    #     <%= component.slot(:summary) do %>
    #       Choose an option
    #     <% end %>
    #     <%= component.slot(:header) do %>
    #       My menu
    #     <% end %>
    #     <%= component.slot(:filter) %>
    #     <%= component.slot(:item) do %>
    #       Item 1
    #     <% end %>
    #     <%= component.slot(:item) do %>
    #       Item 2
    #     <% end %>
    #     <%= component.slot(:item) do %>
    #       Item 3
    #     <% end %>
    #   <% end %>
    #
    # @example 155|Blankslate|Sometimes a select menu needs to communicate a "blank slate" where there's no content in the menu's list.
    #   <%= render Primer::SelectMenuComponent.new(blankslate: true) do |component| %>
    #     <%= component.slot(:summary, title: "Pick an item") do %>
    #       Choose an option
    #       <span class="dropdown-caret"></span>
    #     <% end %>
    #     <h4>No results</h4>
    #     <p>There are no results to show.</p>
    #   <% end %>
    #
    # @example 136|Loading|When fetching large lists, consider showing a loading message.
    #   <%= render Primer::SelectMenuComponent.new(loading: true) do |component| %>
    #     <%= component.slot(:summary, title: "Pick an item") do %>
    #       Choose an option
    #       <span class="dropdown-caret"></span>
    #     <% end %>
    #     <%= component.slot(:footer) do %>
    #       Loading...
    #     <% end %>
    #   <% end %>
    #
    # @example 193|details-menu example|Use a details-menu instead of a div for the `.SelectMenu` element.
    #   <%= render Primer::SelectMenuComponent.new(details_overlay: :default, reset_details: true, position: :relative, menu_tag: :"details-menu") do |component| %>
    #     <%= component.slot(:summary) do %>
    #       Choose an option
    #     <% end %>
    #     <%= component.slot(:header) do %>
    #       My menu
    #     <% end %>
    #     <%= component.slot(:item, selected: true) do %>
    #       Item 1
    #     <% end %>
    #     <%= component.slot(:item) do %>
    #       Item 2
    #     <% end %>
    #     <%= component.slot(:item) do %>
    #       Item 3
    #     <% end %>
    #   <% end %>
    #
    # @param align_right [Boolean] Align the whole menu to the right or not.
    # @param loading [Boolean] Whether the content will be a loading message.
    # @param blankslate [Boolean] Whether to style the content as a blankslate, to represent there is no content.
    # @param list_border [Symbol] What kind of border to have around the list element. One of `:all`, `:omit_top`, or `:none`.
    # @param message [String] A message shown above the contents.
    # @param list_role [String] Optional `role` attribute for the list element.
    # @param overlay [Symbol] options are `:none`, `:default`, and `:dark`. Dictates the type of overlay to render with.
    # @param menu_tag [Symbol] HTML element type for the `.SelectMenu` tag; defaults to `:div`, could also use `:"details-menu"`.
    # @param modal_classes [String] CSS classes to apply to the `.SelectMenu-modal` element.
    # @param list_classes [String] CSS classes to apply to the `.SelectMenu-list` element.
    # @param menu_classes [String] CSS classes to apply to the `.SelectMenu` element.
    # @param message_classes [String] CSS classes to apply to the message element, if a message is included.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(
      align_right: DEFAULT_ALIGN_RIGHT,
      loading: DEFAULT_LOADING,
      blankslate: DEFAULT_BLANKSLATE,
      list_border: DEFAULT_LIST_BORDER_CLASS,
      list_role: nil,
      message: nil,
      reset_details: false,
      menu_tag: :div,
      modal_classes: nil,
      message_classes: nil,
      menu_classes: nil,
      list_classes: nil,
      details_overlay: DetailsComponent::NO_OVERLAY,
      **system_arguments
    )
      @align_right = fetch_or_fallback_boolean(align_right, DEFAULT_ALIGN_RIGHT)
      @loading = fetch_or_fallback_boolean(loading, DEFAULT_LOADING)
      @blankslate = fetch_or_fallback_boolean(blankslate, DEFAULT_BLANKSLATE)
      @list_border = fetch_or_fallback(LIST_BORDER_CLASSES.keys, list_border,
        DEFAULT_LIST_BORDER_CLASS)
      @list_role = list_role
      @message = message
      @details_overlay = details_overlay
      @reset_details = reset_details
      @menu_tag = menu_tag
      @modal_classes = modal_classes
      @list_classes = list_classes
      @message_classes = message_classes
      @menu_classes = menu_classes
      @system_arguments = system_arguments
      overlay_option = fetch_or_fallback(DetailsComponent::OVERLAY_MAPPINGS.keys, @details_overlay,
        DetailsComponent::NO_OVERLAY)
      @system_arguments[:tag] = :details
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        DetailsComponent::OVERLAY_MAPPINGS[overlay_option],
        "details-reset" => @reset_details,
      )
    end

    def render?
      return false unless summary.present?

      items.any? || content.present? || message.present? ||
        footer.present? || header.present?
    end

    class Summary < Primer::Slot
      # @param button [Boolean] Whether the `summary` element should be styled as a button.
      # @param button_type [Symbol] Only applies when `button`=`true`. <%= one_of(Primer::ButtonComponent::BUTTON_TYPE_OPTIONS) %>
      # @param variant [Symbol] Only applies when `button`=`true`. <%= one_of(Primer::ButtonComponent::VARIANT_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        button: true,
        button_type: :default,
        variant: :medium,
        **system_arguments
      )
        @button = button
        @button_type = button_type
        @variant = variant
        @system_arguments = system_arguments
        @system_arguments[:tag] = :summary
        @system_arguments[:role] = "button"
      end

      def component
        return Primer::BaseComponent.new(**@system_arguments) unless @button
        Primer::ButtonComponent.new(
          button_type: @button_type,
          variant: @variant,
          **@system_arguments
        )
      end
    end

    # List items within the select menu.
    class Item < Primer::Slot
      DEFAULT_SELECTED = false
      DEFAULT_ICON = true

      attr_reader :divider

      # @param selected [Boolean] Whether item is the currently active one.
      # @param icon [Boolean] Whether or not to include a check Octicon when this item is selected.
      # @param divider [Boolean, String, nil] Whether to show a divider after item. Pass `true` to show a simple line divider, or pass a String to show a divider with a title.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>, including: `tag` (`Symbol`) - HTML element type for the item tag; defaults to `:button`. `role` (`String`) - HTML role attribute for the item tag; defaults to `"menuitem"`.
      def initialize(
        selected: DEFAULT_SELECTED,
        icon: DEFAULT_ICON,
        divider: nil,
        **system_arguments
      )
        @selected = fetch_or_fallback_boolean(selected, DEFAULT_SELECTED)
        @icon = fetch_or_fallback_boolean(icon, DEFAULT_ICON)
        @divider = divider
        @system_arguments = system_arguments
        @system_arguments[:tag] ||= :button
        @system_arguments[:role] ||= if @selected || @icon
          "menuitemcheckbox"
        else
          "menuitem"
        end
        @system_arguments[:classes] = class_names(
          "SelectMenu-item",
          system_arguments[:classes],
        )
        @system_arguments[:"aria-checked"] = "true" if @selected
      end

      def wrapper_component
        case @system_arguments[:tag]
        when :button
          Primer::ButtonComponent.new(**@system_arguments)
        when :a
          Primer::LinkComponent.new(**@system_arguments)
        else
          Primer::BaseComponent.new(**@system_arguments)
        end
      end

      # Private: Only used if `icon`=`true`.
      def icon_component
        return unless @icon

        Primer::OcticonComponent.new(
          icon: "check",
          classes: "SelectMenu-icon SelectMenu-icon--check",
        )
      end

      # Private: Only used if `divider` is non-nil.
      def divider_component
        Primer::BaseComponent.new(
          tag: divider.is_a?(String) ? :div : :hr,
          classes: "SelectMenu-divider"
        )
      end
    end

    # An optional header for the select menu.
    class Header < Primer::Slot
      DEFAULT_CLOSEABLE = false
      DEFAULT_TITLE_TAG = :h3

      # @param closeable [Boolean] Whether to include a close button in the header for closing the whole menu.
      # @param title_tag [Symbol] HTML element type for the `.SelectMenu-title` tag; defaults to `:h3`.
      # @param title_classes [String] CSS classes to apply to the title element within the header.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>, including: `tag` (`Symbol`) - HTML element type for the header tag; defaults to `:header`.
      def initialize(
        closeable: DEFAULT_CLOSEABLE,
        title_tag: DEFAULT_TITLE_TAG,
        title_classes: nil,
        **system_arguments
      )
        @closeable = fetch_or_fallback_boolean(closeable, DEFAULT_CLOSEABLE)
        @title_tag = title_tag
        @title_classes = title_classes
        @system_arguments = system_arguments
        @system_arguments[:tag] ||= :header
        @system_arguments[:classes] = class_names(
          "SelectMenu-header",
          system_arguments[:classes]
        )
      end

      def closeable?
        @closeable
      end

      def wrapper_component
        Primer::BaseComponent.new(**@system_arguments)
      end

      def title_component
        Primer::BaseComponent.new(
          tag: @title_tag || DEFAULT_TITLE_TAG,
          classes: class_names(
            "SelectMenu-title",
            @title_classes,
          )
        )
      end

      # Private: Only used if `closeable` is `true`.
      def close_button_component
        Primer::ButtonComponent.new(tag: :button, classes: "SelectMenu-closeButton")
      end

      # Private: Only used if `closeable` is `true`.
      def close_button_icon
        Primer::OcticonComponent.new(icon: "x")
      end
    end

    # An optional footer for the select menu.
    class Footer < Primer::Slot
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>, including: `tag` (`Symbol`) - HTML element type for the footer tag; defaults to `:footer`.
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] ||= :footer
        @system_arguments[:classes] = class_names(
          "SelectMenu-footer",
          system_arguments[:classes]
        )
      end

      def component
        Primer::BaseComponent.new(**@system_arguments)
      end
    end

    # An optional filter bar for the select menu, to allow limiting how much of its contents
    # is shown at a time.
    class Filter < Primer::Slot
      DEFAULT_PLACEHOLDER = "Filter"

      # @param placeholder [String] The placeholder attribute for the input field.
      # @param input_classes [String] CSS classes to apply to the input element within the modal.
      # @param aria_label [String] The aria-label attribute for the input field.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>, including: `tag` (`Symbol`) - HTML element type for the filter tag; defaults to `:form`.
      def initialize(
        placeholder: DEFAULT_PLACEHOLDER,
        input_classes: "form-control",
        aria_label: DEFAULT_PLACEHOLDER,
        **system_arguments
      )
        @placeholder = placeholder
        @input_classes = input_classes
        @aria_label = aria_label
        @system_arguments = system_arguments
        @system_arguments[:tag] ||= :form
        @system_arguments[:classes] = class_names(
          "SelectMenu-filter",
          system_arguments[:classes],
        )
      end

      def wrapper_component
        Primer::BaseComponent.new(**@system_arguments)
      end

      def input_component
        Primer::BaseComponent.new(
          tag: :input,
          type: "text",
          placeholder: @placeholder,
          "aria-label": @aria_label,
          classes: class_names(
            "SelectMenu-input",
            @input_classes,
          )
        )
      end
    end

    private

    def loading?
      @loading
    end

    def blankslate?
      @blankslate
    end

    def details_component
      Primer::BaseComponent.new(**@system_arguments)
    end

    def select_menu_component
      role = "menu" if @menu_tag == :"details-menu"
      Primer::BaseComponent.new(
        tag: @menu_tag,
        role: role,
        classes: class_names(
          "SelectMenu",
          @menu_classes,
          "right-0" => @align_right,
          "SelectMenu--hasFilter" => filter.present?,
        )
      )
    end

    def modal_component
      Primer::BaseComponent.new(
        tag: :div,
        classes: class_names(
          "SelectMenu-modal",
          @modal_classes,
        )
      )
    end

    # Private: Get a component to represent the `.SelectMenu-list` element that will
    # contain the items in the menu.
    #
    # Returns a component.
    def list_component
      Primer::BaseComponent.new(
        tag: :div,
        role: @list_role,
        classes: class_names(
          "SelectMenu-list",
          @list_classes,
          LIST_BORDER_CLASSES[@list_border],
        )
      )
    end

    def message_component
      Primer::BaseComponent.new(
        tag: :div,
        classes: class_names(
          "SelectMenu-message",
          @message_classes,
        )
      )
    end
  end
end
