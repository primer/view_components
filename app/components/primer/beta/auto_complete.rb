# frozen_string_literal: true

module Primer
  module Beta
    # Use `AutoComplete` to provide a user with a list of selectable suggestions that appear when they type into the
    # input field. This list is populated by server search results.
    # @accessibility
    #   Always set an accessible label to help the user interact with the component.
    #
    #   * `label_text` is required and visible by default.
    #   * If you must use a non-visible label, set `visually_hide_label` to `true`.
    #   However, please note that a visible label should almost always
    #   be used unless there is compelling reason not to. A placeholder is not a label.
    class AutoComplete < Primer::Component
      status :beta

      DEFAULT_SIZE = :medium
      SIZE_MAPPINGS = {
        :small => "FormControl--small",
        :medium => "FormControl--medium",
        :large => "FormControl--large",
        DEFAULT_SIZE => "FormControl--medium"
      }.freeze
      SIZE_OPTIONS = SIZE_MAPPINGS.keys

      #
      # Customizable results list.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :results, lambda { |**system_arguments|
        deny_tag_argument(**system_arguments)
        system_arguments[:tag] = :ul
        system_arguments[:id] = @list_id
        system_arguments[:classes] = class_names(
          "ActionList",
          system_arguments[:classes]
        )

        Primer::BaseComponent.new(**system_arguments)
      }

      #
      # Leading visual.
      #
      # - `leading_visual_icon` for a <%= link_to_component(Primer::OcticonComponent) %>.
      #
      # @param system_arguments [Hash] Same arguments as <%= link_to_component(Primer::OcticonComponent) %>.
      renders_one :leading_visual, types: {
        icon: lambda { |**system_arguments|
          system_arguments[:classes] = class_names("FormControl--input-leadingVisual")
          Primer::OcticonComponent.new(**system_arguments)
        }
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
          "instead of `aria-label`, include `label_text` and set `visually_hide_label` to `true` on the component initializer.",
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
        sanitized_args[:disabled] = true if @disabled
        sanitized_args[:invalid] = true if @invalid
        sanitized_args[:type] = :text
        sanitized_args[:classes] = class_names(
          "FormControl",
          "FormControl--input",
          @full_width && "FormControl--fullWidth",
          SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, @size, DEFAULT_SIZE)],
          sanitized_args[:classes]
        )
        sanitized_args[:placeholder] = @placeholder

        Primer::BaseComponent.new(**sanitized_args)
      }

      # @example Leading visual
      #   @description
      #     Display any Octicon as a leading visual within the field
      #   @code
      #     <%= render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", src: "/auto_complete", input_id:"input-id", list_id: "list-id")) do |c| %>
      #       <% c.leading_visual_icon(icon: :search) %>
      #       <% c.results do %>
      #         <%= render(Primer::Beta::AutoComplete::Item.new(selected: true, value: "apple")) do |_c| %>
      #           Apple
      #         <% end %>
      #         <%= render(Primer::Beta::AutoComplete::Item.new(value: "orange")) do |_c| %>
      #           Orange
      #         <% end %>
      #       <% end %>
      #     <% end %>
      #
      # @example Trailing action
      #   @description
      #     Labels can be inline by setting `is_label_inline: true`. However, labels will always become stacked on smaller screen sizes.
      #   @code
      #     <%= render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "list-id", src: "/auto_complete", show_clear_button: true )) do |c| %>
      #       <% c.results do %>
      #         <%= render(Primer::Beta::AutoComplete::Item.new(selected: true, value: "apple")) do |_c| %>
      #           Apple
      #         <% end %>
      #         <%= render(Primer::Beta::AutoComplete::Item.new(value: "orange")) do |_c| %>
      #           Orange
      #         <% end %>
      #       <% end %>
      #     <% end %>
      #
      # @example Visually hidden label
      #   @description
      #     A non-visible label may be rendered with `visually_hide_label: true`, but it is highly discouraged. See <%= link_to_accessibility %>.
      #   @code
      #     <%= render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "fruits-input--custom-results", list_id: "fruits-popup--custom-results", src: "/auto_complete", visually_hide_label: true)) do |c| %>
      #       <% c.leading_visual_icon(icon: :search) %>
      #       <% c.results do %>
      #         <%= render(Primer::Beta::AutoComplete::Item.new(selected: true, value: "apple")) do |_c| %>
      #           Apple
      #         <% end %>
      #         <%= render(Primer::Beta::AutoComplete::Item.new(value: "orange")) do |_c| %>
      #           Orange
      #         <% end %>
      #       <% end %>
      #     <% end %>
      #
      # @example Full width field
      #   @description
      #     To allow field to span width of its container, set `full_width` to `true`.
      #   @code
      #     <%= render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "fruits-input--custom-results", list_id: "fruits-popup--custom-results", src: "/auto_complete", full_width: true)) do |c| %>
      #       <% c.leading_visual_icon(icon: :search) %>
      #       <% c.results do %>
      #         <%= render(Primer::Beta::AutoComplete::Item.new(selected: true, value: "apple")) do |_c| %>
      #           Apple
      #         <% end %>
      #         <%= render(Primer::Beta::AutoComplete::Item.new(value: "orange")) do |_c| %>
      #           Orange
      #         <% end %>
      #       <% end %>
      #     <% end %>
      #
      # @example With custom classes for the input
      #   <%= render(Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", input_id: "fruits-input--custom-input", list_id: "fruits-popup--custom-input")) do |c| %>
      #     <% c.input(classes: "custom-class") %>
      #   <% end %>
      #
      # @example With custom classes for the results
      #   <%= render(Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", input_id: "fruits-input--custom-results", list_id: "fruits-popup--custom-results")) do |c| %>
      #     <% c.results(classes: "custom-class") do %>
      #       <%= render(Primer::Beta::AutoComplete::Item.new(selected: true, value: "apple")) do |c| %>
      #         Apple
      #       <% end %>
      #       <%= render(Primer::Beta::AutoComplete::Item.new(value: "orange")) do |c| %>
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
      # @param visually_hide_label [Boolean] Controls if the label is visible. If `true`, screen reader only text will be added.
      # @param show_clear_button [Boolean] Adds optional clear button.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      # @param size [Hash] Input size can be small, medium (default), or large
      # @param full_width [Boolean] Input can be full-width or fit to content
      # @param disabled [Boolean] Disabled input
      # @param invalid [Boolean] Invalid input
      # @param placeholder [String] The placeholder text displayed within the input
      def initialize(label_text:, src:, list_id:, input_id:, input_name: nil, placeholder: nil, show_clear_button: false, visually_hide_label: false, size: DEFAULT_SIZE, full_width: false, disabled: false, invalid: false, **system_arguments)
        @label_text = label_text
        @list_id = list_id
        @input_id = input_id
        @input_name = input_name || input_id
        @placeholder = placeholder
        @visually_hide_label = visually_hide_label
        @show_clear_button = show_clear_button
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = "auto-complete"
        @system_arguments[:src] = src
        @system_arguments[:for] = list_id
        @disabled = disabled
        @invalid = invalid
        @size = size
        @full_width = full_width
        @field_wrap_classes = class_names(
          "FormControl-fieldWrap",
          "FormControl-fieldWrap--input",
          SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, @size, DEFAULT_SIZE)],
          "FormControl-fieldWrap--disabled": disabled,
          "FormControl-fieldWrap--invalid": invalid,
          "FormControl-fieldWrap--input-trailingAction": show_clear_button
        )
        @form_group_classes = class_names(
          "FormGroup",
          "FormGroup--fullWidth": full_width
        )
      end

      # add `input` and `results` without needing to explicitly call them in the view
      def before_render
        results(classes: "") unless results
        input(classes: "") unless input
      end
    end
  end
end
