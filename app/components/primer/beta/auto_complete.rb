# frozen_string_literal: true

module Primer
  module Beta
    # Use `AutoComplete` to provide a user with a list of selectable suggestions that appear when they type into the
    # input field. This list is populated by server search results.
    # @accessibility
    #   Always set an accessible label to help the user interact with the component.
    #
    #   * Set the `label` slot to render a visible label. Alternatively, associate an existing visible text element
    #   as a label by setting `aria-labelledby`.
    #   * If you must use a non-visible label, set `is_label_visible` to `false`. However, please note that a visible label should almost
    #   always be used unless there is compelling reason not to. A placeholder is not a label.
    class AutoComplete < Primer::Component
      status :beta

      # Optionally render a visible label. See <%= link_to_accessibility %>
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      # renders_one :label, lambda { |**system_arguments|
      #   deny_tag_argument(**system_arguments)
      #   system_arguments[:for] = @input_id
      #   system_arguments[:tag] = :label

      #   Primer::BaseComponent.new(**system_arguments)
      # }

      # renders_one :span, lambda { |**system_arguments|
      #   deny_tag_argument(**system_arguments)

      #   @system_arguments[:tag] = :span
      #   system_arguments[:classes] = class_names(
      #     "sr-only",
      #     system_arguments[:classes]
      #   )

      #   Primer::BaseComponent.new(**system_arguments)
      # }

      # Required input used to search for results
      #
      # @param type [Symbol] <%= one_of(Primer::Beta::AutoComplete::Input::TYPE_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :input, lambda { |**system_arguments|
        # aria_label = aria("label", system_arguments) || @aria_label
        # if aria_label.present?
        #   system_arguments[:"aria-label"] = aria_label
        #   system_arguments[:aria]&.delete(:label)
        # end

        name = system_arguments[:name] || @input_id
        Input.new(id: @input_id, name: name, **system_arguments)
      }

      # Optional icon to be rendered before the input. Has the same arguments as <%= link_to_component(Primer::OcticonComponent) %>.
      #
      # TODO: Add aria-hidden="true"
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

        # aria_label = system_arguments[:"aria-label"] || system_arguments.dig(:aria, :label) || @aria_label
        # system_arguments[:"aria-label"] = aria_label if aria_label.present?
        # system_arguments[:aria]&.delete(:label)

        Primer::BaseComponent.new(**system_arguments)
      }

      # @example Default
      #   <%= render(Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", input_id: "fruits-input-1", list_id: "fruits-popup-1", position: :relative)) do |c| %>
      #     <% c.input(type: :text) %>
      #   <% end %>
      #
      # @example With Non-Visible Label
      #   <%= render(Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", input_id: "fruits-input-2", list_id: "fruits-popup-2", is_label_visible: false, position: :relative)) do |c| %>
      #     <% c.input(type: :text) %>
      #   <% end %>
      #
      # @example With `aria-labelledby`
      #   <%= render(Primer::HeadingComponent.new(tag: :h2, id: "search-1")) { "Search" } %>
      #   <%= render(Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", input_id: "fruits-input-3", list_id: "fruits-popup-3", position: :relative)) do |c| %>
      #     <% c.input("aria-labelledby": "search-1") %>
      #   <% end %>
      #
      # @example With custom classes for the results
      #   <%= render(Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", input_id: "fruits-input-4", list_id: "fruits-popup-4", position: :relative)) do |c| %>
      #     <% c.input(type: :text) %>
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
      #   <%= render(Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", list_id: "fruits-popup-5", input_id: "fruits-input-5", position: :relative)) do |c| %>
      #     <% c.input(type: :text) %>
      #     <% c.icon(icon: :search) %>
      #   <% end %>
      # @param label_text [String] The label of the input.
      # @param src [String] The route to query.
      # @param input_id [String] Id of the input element.
      # @param list_id [String] Id of the list element.
      # @param is_label_visible [Boolean] Controls if the label is visible. If `false`, screen reader only text will be added.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(label_text:, src:, list_id:, input_id:, is_label_visible: true, **system_arguments)
        @label_text = label_text
        @list_id = list_id
        @input_id = input_id
        # @aria_label = aria("label", system_arguments)
        @is_label_visible = is_label_visible

        # system_arguments.delete(:"aria-label") && system_arguments[:aria]&.delete(:label)

        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = "auto-complete"
        @system_arguments[:src] = src
        @system_arguments[:for] = list_id
      end

      # add `results` without needing to explicitly call it in the view
      def before_render
        raise ArgumentError, "Missing `input` slot" if input.blank?

        results(classes: "") unless results
      end

      # This component is part of `Primer::Beta::AutoCompleteComponent` and should not be
      # used as a standalone component.
      class Input < Primer::Component
        DEFAULT_TYPE = :text
        TYPE_OPTIONS = [DEFAULT_TYPE, :search].freeze

        # @param type [Symbol] <%= one_of(Primer::Beta::AutoComplete::Input::TYPE_OPTIONS) %>
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(type: DEFAULT_TYPE, **system_arguments)
          @system_arguments = deny_tag_argument(**system_arguments)
          @system_arguments[:tag] = :input

          # @aria_label = system_arguments[:"aria-label"]
          @aria_labelledby = system_arguments[:"aria-labelledby"] || system_arguments.dig(:aria, :labelledby)

          @system_arguments[:type] = fetch_or_fallback(TYPE_OPTIONS, type, DEFAULT_TYPE)
          @system_arguments[:classes] = class_names(
            "form-control",
            system_arguments[:classes]
          )
        end

        # def missing_label?
        #   @aria_label.blank? && @aria_labelledby.blank?
        # end

        def call
          render(Primer::BaseComponent.new(**@system_arguments))
        end
      end
    end
  end
end
