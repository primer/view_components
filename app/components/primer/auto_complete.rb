# frozen_string_literal: true

module Primer
  # Use `AutoComplete` to provide a user with a list of selectable suggestions that appear when they type into the
  # input field. This list is populated by server search results.
  # @accessibility
  #   Always provide an accessible label to help the user interact with the input element and listbox popup.
  #
  #   To show a visible label, set the `label` slot. The`for` attribute must be set to the `id` of
  #   `input` in order for the `<label>` to be properly linked.
  #
  #   If you do not wish to provide a visible label, you must set an `aria-label` attribute. You may set
  #   `:"aria-label"` directly on `AutoComplete` instead of the slots and Primer will apply it to the correct elements.
  class AutoComplete < Primer::Component
    status :beta

    DEFAULT_INPUT_TYPE = :text
    INPUT_TYPE_OPTIONS = [DEFAULT_INPUT_TYPE, :search].freeze

    # Optionally render a visible label. See <%= link_to_accessibility %>
    #
    # @param for [Symbol] id of input
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :label, lambda { |**system_arguments|
      raise ArgumentError, "missing keyword: for" if !system_arguments.key?(:for) && !Rails.env.production?

      @label_for_id = system_arguments[:for]
      system_arguments[:tag] = :label
      Primer::BaseComponent.new(**system_arguments)
    }

    # Required input used to search for results
    #
    # @param type [Symbol] <%= one_of(Primer::AutoComplete::INPUT_TYPE_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :input, lambda { |type: DEFAULT_INPUT_TYPE, classes: "form-control", **system_arguments|
      system_arguments[:tag] = :input
      @input_id = system_arguments[:id]
      @input_aria_label = system_arguments[:"aria-label"] || system_arguments.dig(:aria, :label) || @aria_label
      system_arguments[:"aria-label"] = @input_aria_label
      system_arguments[:aria]&.delete(:label)

      system_arguments[:type] = fetch_or_fallback(INPUT_TYPE_OPTIONS, type, DEFAULT_INPUT_TYPE)
      system_arguments[:classes] = classes
      Primer::BaseComponent.new(**system_arguments)
    }

    # Optional icon to be rendered before the input. Has the same arguments as <%= link_to_component(Primer::OcticonComponent) %>.
    #
    renders_one :icon, Primer::OcticonComponent

    # Customizable results list.
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :results, lambda { |**system_arguments|
      system_arguments[:tag] = :ul
      system_arguments[:id] = @list_id
      system_arguments[:classes] = class_names(
        "autocomplete-results",
        system_arguments[:classes]
      )

      aria_label = system_arguments[:"aria-label"] || system_arguments.dig(:aria, :label) || @aria_label
      system_arguments[:"aria-label"] = aria_label if aria_label.present?
      system_arguments[:aria]&.delete(:label)

      Primer::BaseComponent.new(**system_arguments)
    }

    # @example Default
    #   <%= render(Primer::AutoComplete.new(src: "/auto_complete", id: "fruits-popup-1", position: :relative)) do |c| %>
    #     <% c.label(for: "example-input").with_content("Fruits") %>
    #     <% c.input(id: "example-input", type: :text, name: "input") %>
    #   <% end %>
    #
    # @example With `aria-label`
    #   <%= render(Primer::AutoComplete.new("aria-label": "Fruits", src: "/auto_complete", id: "fruits-popup-2", position: :relative)) do |c| %>
    #     <% c.input(type: :text, name: "input") %>
    #   <% end %>
    #
    # @example With custom classes for the results
    #   <%= render(Primer::AutoComplete.new(src: "/auto_complete", id: "fruits-popup-3", position: :relative)) do |c| %>
    #     <% c.label(for: "example-input-2").with_content("Fruits") %>
    #     <% c.input(id: 'example-input-2', type: :text, name: "input") %>
    #     <% c.results(classes: "custom-class") do %>
    #       <%= render(Primer::AutoComplete::Item.new(selected: true, value: "apple")) do |c| %>
    #         Apple
    #       <% end %>
    #       <%= render(Primer::AutoComplete::Item.new(value: "orange")) do |c| %>
    #         Orange
    #       <% end %>
    #     <% end %>
    #   <% end %>
    #
    # @example With Icon
    #   <%= render(Primer::AutoComplete.new(src: "/auto_complete", id: "fruits-popup-4", position: :relative)) do |c| %>
    #     <% c.label(for: "example-input-3").with_content("Fruits") %>
    #     <% c.input(id: "example-input-3", name: "input", ) %>
    #     <% c.icon(icon: :search) %>
    #   <% end %>
    #
    # @param src [String] The route to query.
    # @param id [String] Id of the list element.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(src:, id:, **system_arguments)
      @list_id = id
      @aria_label = system_arguments[:"aria-label"] || system_arguments.dig(:aria, :label)

      system_arguments.delete(:"aria-label") && system_arguments[:aria]&.delete(:label)

      @system_arguments = system_arguments
      @system_arguments[:tag] = "auto-complete"
      @system_arguments[:src] = src
      @system_arguments[:for] = id
    end

    # add `results` without needing to explicitly call it in the view
    def before_render
      raise ArgumentError, "Accessible label is required." if label.blank? && @input_aria_label.blank?
      # If aria label is not set:
      # raise ArgumentError, "Input id does not match label for id" if @input_id != @label_for_id

      raise ArgumentError, "Missing `input` slot" if input.blank?

      results(classes: "") unless results
    end
  end
end
