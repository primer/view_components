# frozen_string_literal: true

# TODO: use generic ActionList item for Autocomplete
module Primer
  module Beta
    class AutoComplete
      # Use `AutoCompleteItem` to list results of an auto-completed search.
      class Item < Primer::Component
        status :beta

        DEFAULT_DESCRIPTION_VARIANT = :block
        DESCRIPTION_VARIANT_MAPPINGS = {
          :inline => "ActionListItem-descriptionWrap--inline",
          DEFAULT_DESCRIPTION_VARIANT => "ActionListItem-descriptionWrap"
        }.freeze
        DESCRIPTION_VARIANT_OPTIONS = DESCRIPTION_VARIANT_MAPPINGS.keys.freeze

        # The leading visual rendered before the link.
        #
        # @param kwargs [Hash] The arguments accepted by <%= link_to_component(Primer::Beta::Avatar) %> or <%= link_to_component(Primer::Beta::Octicon) %>
        renders_one :leading_visual, types: {
          icon: Primer::Beta::Octicon,
          avatar: lambda { |**kwargs|
            Primer::Beta::Avatar.new(**{ **kwargs, size: 16 })
          }
        }

        # The trailing visual rendered after the link.
        #
        # @param kwargs [Hash] The arguments accepted by <%= link_to_component(Primer::Beta::Octicon) %>, <%= link_to_component(Primer::Beta::Label) %>, or <%= link_to_component(Primer::Beta::Counter) %>
        renders_one :trailing_visual, types: {
          icon: Primer::Beta::Octicon,
          label: Primer::Beta::Label,
          counter: Primer::Beta::Counter
        }

        # Optional description
        #
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        renders_one :description

        # @param value [String] Value of the item.
        # @param selected [Boolean] Whether the item is selected.
        # @param disabled [Boolean] Whether the item is disabled.
        # @param description_variant [Hash] Changes the description style. Allowed values are :inline, :block
        # @param description [String] Display description text below label
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(value:, selected: false, disabled: false, description_variant: DEFAULT_DESCRIPTION_VARIANT, **system_arguments)
          @description_variant = fetch_or_fallback(
            DESCRIPTION_VARIANT_OPTIONS, description_variant, DEFAULT_DESCRIPTION_VARIANT
          )

          @system_arguments = deny_tag_argument(**system_arguments)
          @system_arguments[:tag] = :li
          @system_arguments[:role] = :option
          @system_arguments[:"data-autocomplete-value"] = value

          @system_arguments[:"aria-selected"] = true if selected
          @system_arguments[:"aria-disabled"] = true if disabled

          @system_arguments[:classes] = class_names(
            "ActionListItem",
            system_arguments[:classes]
          )

          @description_wrapper_arguments = {
            classes: class_names(
              "ActionListItem-descriptionWrap",
              DESCRIPTION_VARIANT_MAPPINGS[@description_variant]
            )
          }
        end
      end
    end
  end
end
