# frozen_string_literal: true

module Primer
  # Use `AutoComplete` to populate input values from server search results.
  class AutoComplete < Primer::Component
    status :beta

    DEFAULT_INPUT_TYPE = :text
    INPUT_TYPE_OPTIONS = [DEFAULT_INPUT_TYPE, :search].freeze

    # Required input used to search for results
    #
    # @param type [Symbol] <%= one_of(Primer::AutoComplete::INPUT_TYPE_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :input, lambda { |type: DEFAULT_INPUT_TYPE, classes: "form-control", **system_arguments|
      system_arguments[:tag] = :input
      system_arguments[:type] = fetch_or_fallback(INPUT_TYPE_OPTIONS, type, DEFAULT_INPUT_TYPE)
      system_arguments[:classes] = classes
      Primer::BaseComponent.new(**system_arguments)
    }

    # Optional icon to be rendered before the input. Has the same arguments as <%= link_to_component(Primer::OcticonComponent) %>.
    renders_one :icon, Primer::OcticonComponent

    # Customizable results list.
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :results, lambda { |**system_arguments|
      system_arguments[:tag] = :ul
      system_arguments[:id] = @id
      system_arguments[:classes] = class_names(
        "autocomplete-results",
        system_arguments[:classes]
      )

      Primer::BaseComponent.new(**system_arguments)
    }

    # @example Default
    #   <%= render(Primer::AutoComplete.new(src: "/users/search", id: "user-popup", position: :relative)) do |c| %>
    #     <% c.input(type: :text, name: "input") %>
    #     <% c.results do %>
    #       <%= render(Primer::AutoComplete::Item.new(selected: true, value: "value")) do |c| %>
    #         Selected
    #       <% end %>
    #       <%= render(Primer::AutoComplete::Item.new(value: "value")) do |c| %>
    #         Not selected
    #       <% end %>
    #     <% end %>
    #   <% end %>
    #
    # @example With custom classes for the results
    #   <%= render(Primer::AutoComplete.new(src: "/users/search", id: "user-popup", position: :relative)) do |c| %>
    #     <% c.input(type: :text, name: "input") %>
    #     <% c.results(classes: "my-custom-class") do %>
    #       <%= render(Primer::AutoComplete::Item.new(selected: true, value: "value")) do |c| %>
    #         Selected
    #       <% end %>
    #       <%= render(Primer::AutoComplete::Item.new(value: "value")) do |c| %>
    #         Not selected
    #       <% end %>
    #     <% end %>
    #   <% end %>
    #
    # @example With Icon
    #   <%= render(Primer::AutoComplete.new(src: "/users/search", id: "user-popup", position: :relative)) do |c| %>
    #     <% c.input(type: :text, name: "input") %>
    #     <% c.icon(icon: :search) %>
    #     <% c.results do %>
    #       <%= render(Primer::AutoComplete::Item.new(selected: true, value: "value")) do |c| %>
    #         Selected
    #       <% end %>
    #       <%= render(Primer::AutoComplete::Item.new(value: "value")) do |c| %>
    #         Not selected
    #       <% end %>
    #     <% end %>
    #   <% end %>
    #
    # @param src [String] The route to query.
    # @param id [String] Id of the list element.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(src:, id:, **system_arguments)
      @id = id

      @system_arguments = system_arguments
      @system_arguments[:tag] = "auto-complete"
      @system_arguments[:src] = src
      @system_arguments[:for] = id
    end

    # add `results` without needing to explicitly call it in the view
    def before_render
      raise ArgumentError, "Missing `input` slot" if input.blank?

      results(classes: "") unless results
    end
  end
end
