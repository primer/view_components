# frozen_string_literal: true

# TODO: use generic ActionList item for Autocomplete
module Primer
  module Beta
    class AutoComplete
      # Use `AutoCompleteItem` to list results of an auto-completed search.
      class Item < Primer::Component
        status :beta

        # The leading visual rendered before the link.
        #
        # @param kwargs [Hash] The arguments accepted by <%= link_to_component(Primer::Beta::Avatar) %> or <%= link_to_component(Primer::OcticonComponent) %>
        renders_one :leading_visual, types: {
          icon: Primer::OcticonComponent,
          avatar: lambda { |**kwargs|
            Primer::Beta::Avatar.new(**{ **kwargs, size: 16 })
          },
          svg: lambda { |**system_arguments|
            Primer::BaseComponent.new(tag: :svg, **system_arguments)
          }
        }

        # The trailing visual rendered after the link.
        #
        # @param kwargs [Hash] The arguments accepted by <%= link_to_component(Primer::OcticonComponent) %>, <%= link_to_component(Primer::LabelComponent) %>, or <%= link_to_component(Primer::CounterComponent) %>
        renders_one :trailing_visual, types: {
          icon: Primer::OcticonComponent,
          label: Primer::LabelComponent,
          counter: Primer::CounterComponent
        }

        # @example Default
        #   <%= render(Primer::Beta::AutoComplete::Item.new(selected: true, value: "value")) do |c| %>
        #     Selected
        #   <% end %>
        #   <%= render(Primer::Beta::AutoComplete::Item.new(value: "value")) do |c| %>
        #     Not selected
        #   <% end %>
        #
        # @param value [String] Value of the item.
        # @param selected [Boolean] Whether the item is selected.
        # @param disabled [Boolean] Whether the item is disabled.
        # @param description [String] Display description text below label
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(value:, selected: false, disabled: false, description: nil, **system_arguments)
          @system_arguments = deny_tag_argument(**system_arguments)
          @system_arguments[:tag] = :li
          @system_arguments[:role] = :option
          @system_arguments[:"data-autocomplete-value"] = value
          @description = description

          @system_arguments[:"aria-selected"] = true if selected
          @system_arguments[:"aria-disabled"] = true if disabled

          @system_arguments[:classes] = class_names(
            "ActionList-item",
            system_arguments[:classes]
          )
        end
      end
    end
  end
end
