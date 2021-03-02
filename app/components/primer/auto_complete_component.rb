# frozen_string_literal: true

module Primer
  # Use AutoComplete to populate input values from server search results.
  class AutoCompleteComponent < Primer::Component
    include ViewComponent::SlotableV2

    DEFAULT_INPUT_TYPE = :text
    INPUT_TYPE_OPTIONS = [DEFAULT_INPUT_TYPE, :search].freeze

    # Required input used to search for results
    #
    # @param type [Symbol] <%= one_of(Primer::AutoCompleteComponent::INPUT_TYPE_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :input, ->(type: DEFAULT_INPUT_TYPE, **system_arguments) do
      system_arguments[:tag] = :input
      system_arguments[:type] = fetch_or_fallback(INPUT_TYPE_OPTIONS, type, DEFAULT_INPUT_TYPE)
      Primer::BaseComponent.new(**system_arguments)
    end

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

    # @example 100|Default
    #   <%= render(Primer::AutoCompleteComponent.new(src: "/users/search", for: "user-popup")) do |c| %>
    #     <% c.input(type: :text, name: "username") %>
    #   <% end %>
    #
    # @example 100|With custom classes for the results
    #   <%= render(Primer::AutoCompleteComponent.new(src: "/users/search", for: "user-popup")) do |c| %>
    #     <% c.input(type: :text, name: "username") %>
    #     <% c.results(classes: "my-custom-class") %>
    #   <% end %>
    #
    # @example 100|With Icon
    #   <%= render(Primer::AutoCompleteComponent.new(src: "/users/search", for: "user-popup")) do |c| %>
    #     <% c.input(type: :text, name: "username") %>
    #     <% c.icon(icon: :search) %>
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
      raise ArgumentError, "Missing `input` slot" unless input.present?
      results(classes: "") unless results
    end
  end
end
