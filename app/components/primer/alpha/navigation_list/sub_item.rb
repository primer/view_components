# frozen_string_literal: true

module Primer
  module Alpha
    class NavigationList
      # Like items, subitems are rendered as styled links. They can optionally include a trailing visual
      # such as an icon, label, or counter. Also like items, subitems are selected based on their item_id,
      # which is a required parameter. If a subitem is selected, it's parent item will also present as
      # selected.
      class SubItem < Primer::Component
        include ViewComponent::PolymorphicSlots

        # The trailing visual rendered after the link.
        #
        # @param kwargs [Hash] The arguments accepted by <%= link_to_component(Primer::OcticonComponent) %>, <%= link_to_component(Primer::LabelComponent) %>, or <%= link_to_component(Primer::CounterComponent) %>
        renders_one :trailing_visual, types: {
          icon: Primer::OcticonComponent,
          label: Primer::LabelComponent,
          counter: Primer::CounterComponent
        }

        # @param selected_by_ids [String, Array] The unique identifier or identifiers used to determine if the subitem is selected.
        # @param href [String] The URL to link to.
        # @param selected_item_id [String] The id of the currently selected item in the whole list. Can refer to an item or subitem.
        # @param content_classes [String] Additional classes to add to the subitem's content, either an <a> or <span> tag.
        # @param disabled [Boolean] Whether or not the item is disabled. Disabled items are rendered as <span> tags instead of links.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(selected_by_ids: [], href: nil, selected_item_id: false, content_classes: "", disabled: false, **system_arguments)
          @selected_by_ids = Array(selected_by_ids)
          @selected_item_id = selected_item_id

          @system_arguments = system_arguments
          @system_arguments[:"data-item-id"] = @selected_by_ids.join(" ")
          @system_arguments[:classes] = class_names(
            "ActionList-item",
            "ActionList-item--subItem",
            @system_arguments[:classes]
          )

          @content_arguments = {
            tag: !href || disabled ? :span : :a,
            href: href,
            classes: class_names(
              "ActionList-content",
              "ActionList-content--visual16",
              content_classes
            ),
            tabindex: 0
          }
        end

        # Whether or not the item is selected.
        #
        # @return [Boolean]
        def selected?
          @selected_by_ids.include?(@selected_item_id)
        end

        def before_render
          @system_arguments[:classes] = class_names(
            selected? ? "ActionList-item--navActive" : "",
            @system_arguments[:classes]
          )

          @content_arguments[:"aria-current"] = "page" if selected?
        end
      end
    end
  end
end
