# frozen_string_literal: true

module Primer
  module Beta
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
      status :beta

      # Optional icon to be rendered before the input. Has the same arguments as <%= link_to_component(Primer::OcticonComponent) %>.
      renders_one :icon, Primer::OcticonComponent

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

      # Required input used to search for results
      #
      # @param type [Symbol] <%= one_of(Primer::Beta::AutoComplete::Input::TYPE_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :input, lambda { |**system_arguments|
        deny_tag_argument(**system_arguments)
        deny_single_argument(:autofocus, "autofocus is not allowed for accessibility reasons.", **system_arguments)
        system_arguments[:id] = @input_id
        system_arguments[:name] = @input_id
        system_arguments[:tag] = :input
        system_arguments[:autocomplete] = "off"

        system_arguments[:type] = :text
        system_arguments[:classes] = class_names(
          "form-control",
          system_arguments[:classes]
        )

        Primer::BaseComponent.new(**system_arguments)
      }

      # @example Default
      #   <%= render(Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", input_id: "fruits-input-1", list_id: "fruits-popup-1", position: :relative)) %>
      #
      # @example With Non-Visible Label
      #   <%= render(Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", input_id: "fruits-input-2", list_id: "fruits-popup-2", is_label_visible: false, position: :relative)) %>
      #
      # @example With Custom Classes for the Results
      #   <%= render(Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", input_id: "fruits-input-3", list_id: "fruits-popup-3", position: :relative)) do |c| %>
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
      # @example With Icon
      #   <%= render(Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", list_id: "fruits-popup-4", input_id: "fruits-input-4", position: :relative)) do |c| %>
      #     <% c.icon(icon: :search) %>
      #   <% end %>
      #
      # @example With Icon and Non-Visible Label
      #   <%= render(Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", list_id: "fruits-popup-5", input_id: "fruits-input-5", is_label_visible: false, position: :relative)) do |c| %>
      #     <% c.icon(icon: :search) %>
      #   <% end %>
      #
      # @example With Clear Button
      #   <%= render(Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", input_id: "fruits-input-6", list_id: "fruits-popup-6", is_clearable: true, position: :relative)) %>
      # @param label_text [String] The label of the input.
      # @param src [String] The route to query.
      # @param input_id [String] Id of the input element.
      # @param list_id [String] Id of the list element.
      # @param is_label_visible [Boolean] Controls if the label is visible. If `false`, screen reader only text will be added.
      # @param is_clearable [Boolean] Adds optional clear button.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(label_text:, src:, list_id:, input_id:, is_label_visible: true, is_clearable: false, **system_arguments)
        @label_text = label_text
        @list_id = list_id
        @input_id = input_id
        @is_label_visible = is_label_visible
        @is_clearable = is_clearable

        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = "auto-complete"
        @system_arguments[:src] = src
        @system_arguments[:for] = list_id
      end

      # add `results` without needing to explicitly call them in the view
      def before_render
        results(classes: "") unless results
        input(classes: "") unless input
      end
    end
  end
end
