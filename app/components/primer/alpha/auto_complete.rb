# frozen_string_literal: true

module Primer
  module Alpha
    # Use `AutoComplete` to provide a user with a list of selectable suggestions that appear when they type into the
    # input field. This list is populated by server search results.
    # @accessibility
    #   Always set an accessible label to help the user interact with the component.
    #
    #   * `label_text` is required and visible by default.
    #   * If you must use a non-visible label, set `is_label_visible` to `false`.
    #   However, please note that a visible label should almost always
    #   be used unless there is compelling reason not to. A placeholder is not a label.
    class AutoComplete < Primer::Component
      status :deprecated

      # Customizable results list.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :results, lambda { |**system_arguments|
        deny_tag_argument(**system_arguments)
        system_arguments[:tag] = :ul
        system_arguments[:id] = @list_id
        system_arguments[:classes] = class_names(
          "autocomplete-results",
          system_arguments[:classes]
        )
        Primer::BaseComponent.new(**system_arguments)
      }

      # Customizable input used to search for results.
      # It is preferred to use this slot sparingly - it will be created by default if not explicity added.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :input, lambda { |**system_arguments|
        sanitized_args = deny_tag_argument(**system_arguments)
        sanitized_args = deny_single_argument(:autofocus, "autofocus is not allowed for accessibility reasons. See https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/autofocus#accessibility_considerations for more information.", **sanitized_args)
        deny_aria_key(
          :label,
          "instead of `aria-label`, include `label_text` and set `is_label_visible` to `false` on the component initializer.",
          **sanitized_args
        )
        deny_single_argument(
          :id,
          "`id` will always be set to @input_id.",
          **sanitized_args
        )
        deny_single_argument(
          :name,
          "Set @input_name on the component initializer instead with `input_name`.",
          **sanitized_args
        )
        sanitized_args[:id] = @input_id
        sanitized_args[:name] = @input_name
        sanitized_args[:tag] = :input
        sanitized_args[:autocomplete] = "off"
        sanitized_args[:type] = :text
        sanitized_args[:classes] = class_names(
          "form-control",
          sanitized_args[:classes]
        )
        Primer::BaseComponent.new(**sanitized_args)
      }

      # @example Default
      #   @description
      #     Labels are stacked by default.
      #   @code
      #     <%= render(Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", input_id: "fruits-input--default", list_id: "fruits-popup--default")) %>
      #
      # @example With inline label
      #   @description
      #     Labels can be inline by setting `is_label_inline: true`. However, labels will always become stacked on smaller screen sizes.
      #   @code
      #     <%= render(Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", is_label_inline: true, input_id: "fruits-input--inline-label", list_id: "fruits-popup--inline-label")) %>
      #
      # @example With non-visible label
      #   @description
      #     A non-visible label may be rendered with `is_label_visible: false`, but it is highly discouraged. See <%= link_to_accessibility %>.
      #   @code
      #     <%= render(Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", input_id: "fruits-input--non-visible-label", list_id: "fruits-popup--non-visible-label", is_label_visible: false)) %>
      #
      # @example With icon
      #   @description
      #     To display a search icon, set `with_icon` to `true`.
      #   @code
      #     <%= render(Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", list_id: "fruits-popup--icon", input_id: "fruits-input--icon", with_icon: true)) %>
      #
      # @example With icon and non-visible label
      #   <%= render(Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", list_id: "fruits-popup--icon-no-label", input_id: "fruits-input--icon-no-label", with_icon: true, is_label_visible: false)) %>
      #
      # @example With clear button
      #   <%= render(Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", input_id: "fruits-input--clear", list_id: "fruits-popup--clear", is_clearable: true)) %>
      #
      # @example With custom classes for the input
      #   <%= render(Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", input_id: "fruits-input--custom-input", list_id: "fruits-popup--custom-input")) do |component| %>
      #     <% component.with_input(classes: "custom-class") %>
      #   <% end %>
      #
      # @example With custom classes for the results
      #   <%= render(Primer::Alpha::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", input_id: "fruits-input--custom-results", list_id: "fruits-popup--custom-results")) do |component| %>
      #     <% component.with_results(classes: "custom-class") do %>
      #       <%= render(Primer::Alpha::AutoComplete::Item.new(selected: true, value: "apple")) do %>
      #         Apple
      #       <% end %>
      #       <%= render(Primer::Alpha::AutoComplete::Item.new(value: "orange")) do %>
      #         Orange
      #       <% end %>
      #     <% end %>
      #   <% end %>
      #
      # @param label_text [String] The label of the input.
      # @param src [String] The route to query.
      # @param input_id [String] Id of the input element.
      # @param input_name [String] Optional name of the input element, defaults to `input_id` when not set.
      # @param list_id [String] Id of the list element.
      # @param with_icon [Boolean] Controls if a search icon is visible, defaults to `false`.
      # @param is_label_visible [Boolean] Controls if the label is visible. If `false`, screen reader only text will be added.
      # @param is_clearable [Boolean] Adds optional clear button.
      # @param is_label_inline [Boolean] Controls if the label is inline. On smaller screens, label will always become stacked.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(label_text:, src:, list_id:, input_id:, input_name: nil, is_label_visible: true, is_label_inline: false, with_icon: false, is_clearable: false, **system_arguments)
        @label_text = label_text
        @list_id = list_id
        @input_id = input_id
        @input_name = input_name || input_id
        @is_label_visible = is_label_visible
        @with_icon = with_icon
        @is_clearable = is_clearable
        @label_classes = label_classes(is_label_visible: is_label_visible, is_label_inline: is_label_inline)
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = "auto-complete"
        @system_arguments[:src] = src
        @system_arguments[:for] = list_id
      end

      # add `input` and `results` without needing to explicitly call them in the view
      def before_render
        with_results(classes: "") unless results?
        with_input(classes: "") unless input?
      end

      private

      # Private: determines the label classes based on component configration.
      #
      # If the label is not visible, return an empty string.
      #
      # @param args [Hash] The component configuration.
      # @return [String] The label classes.
      def label_classes(**args)
        return "" if args[:is_label_visible] == false

        args[:is_label_inline] ? "autocomplete-label-inline" : "autocomplete-label-stacked"
      end
    end
  end
end
