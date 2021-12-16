# frozen_string_literal: true

require "securerandom"

module Primer
  module Alpha
    class NavigationList
      # Sections contain any number of `Item`s and render an optional `heading`.
      class Section < Primer::Component
        attr_reader :id

        # Section heading.
        #
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        renders_one :heading, lambda { |**system_arguments|
          Heading.new(section_id: id, **system_arguments)
        }

        # Nav items.
        #
        # @param item_id [String]
        # @param selected [Boolean]
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        renders_many :items, lambda { |component_klass: Item, **system_arguments|
          system_arguments[:classes] = class_names(
            @item_classes,
            system_arguments[:classes]
          )

          component_klass.new(selected_item_id: @selected_item_id, **system_arguments)
        }

        # @param selected_item_id [Symbol] The id of the selected item. Should correspond to one of the item ids in the list.
        # @param item_classes [Array<String>] Additional classes to add to the list's items.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(selected_item_id: nil, item_classes: "", **system_arguments)
          @id = "nav-list-section-#{SecureRandom.uuid}" || system_arguments[:id]

          @system_arguments = system_arguments
          @system_arguments[:classes] = class_names(
            "ActionList",
            "ActionList--subGroup",
            @system_arguments[:classes]
          )

          @selected_item_id = selected_item_id
          @item_classes = item_classes

          validate_aria_label
        end

        def before_render
          @system_arguments[:"aria-labelledby"] = id if heading.present?
        end
      end
    end
  end
end
