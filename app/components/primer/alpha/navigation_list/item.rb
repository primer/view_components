# frozen_string_literal: true

module Primer
  module Alpha
    class NavigationList
      # Items are rendered as styled links. They can optionally include leading and/or trailing visuals,
      # such as icons, avatars, and counters. Items are selected based on their item_id, which is a
      # required parameter. Items can also contain lists of subitems, which are rendered hidden but can
      # be expanded on click.
      class Item < Primer::Component
        include ViewComponent::PolymorphicSlots

        # The leading visual rendered before the link.
        #
        # @param kwargs [Hash] The arguments accepted by <%= link_to_component(Primer::Beta::Avatar) %> or <%= link_to_component(Primer::OcticonComponent) %>
        renders_one :leading_visual, types: {
          icon: Primer::OcticonComponent,
          avatar: lambda { |**kwargs|
            Primer::Beta::Avatar.new(**{ **kwargs, size: 16 })
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

        # Sub-items are also links. They are indented slightly and rendered underneath the item.
        #
        # @param component_klass [Class] A custom component class to use instead of the default SubItem class.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        renders_many :subitems, lambda { |component_klass: SubItem, **system_arguments|
          component_klass.new(selected_item_id: @selected_item_id, **system_arguments)
        }

        # @param selected_by_ids [String, Array] The unique identifier or identifiers used to determine if the item is selected.
        # @param href [String] The URL to link to.
        # @param selected_item_id [String] The id of the currently selected item in the whole list. Can refer to an item or subitem.
        # @param content_classes [String] Additional classes to add to the item's content, either an <a> or <span> tag.
        # @param submenu_classes [String] Additional classes to add to each of the item's subitems, i.e. each <li> tag.
        # @param disabled [Boolean] Whether or not the item is disabled. Disabled items are rendered as <span> tags instead of links.
        # @param expanded [Boolean] Whether or not the list of subitems is expanded or collapsed.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(selected_by_ids: [], href: nil, selected_item_id: nil, content_classes: "", submenu_classes: "", disabled: false, expanded: false, **system_arguments)
          @selected_by_ids = Array(selected_by_ids)
          @selected_item_id = selected_item_id
          @expanded = expanded
          @href = href

          @system_arguments = system_arguments
          @system_arguments[:"data-item-id"] = @selected_by_ids.join(" ")
          @system_arguments[:classes] = class_names(
            "ActionList-item",
            @system_arguments[:classes]
          )

          @content_arguments = {
            tag: !@href || disabled ? :span : :a,
            href: @href,
            classes: class_names(
              "ActionList-content",
              "ActionList-content--visual16",
              content_classes
            )
          }

          @submenu_arguments = {
            classes: class_names(
              "ActionList",
              "ActionList--subGroup",
              submenu_classes
            )
          }
        end

        # Whether or not the item is selected. Call only after defining subitems.
        #
        # @return [Boolean]
        def selected?
          if @selected_by_ids.present?
            @selected_by_ids.include?(@selected_item_id) && subitems.empty?
          else
            helpers.current_page?(@href)
          end
        end

        # Whether or not the item is expanded. Call only after defining subitems.
        #
        # @return [Boolean]
        def expanded?
          @expanded || subitems.any?(&:selected?)
        end

        def before_render
          raise "Cannot render a trailing visual for an item with subitems" if subitems.present? && trailing_visual.present?

          @system_arguments[:"aria-expanded"] = expanded?.to_s if subitems.present?
          @system_arguments[:"aria-haspopup"] = "true" if subitems.present?
          @system_arguments[:classes] = class_names(
            { "ActionList-item--navActive"  => selected?,
              "ActionList-item--hasSubItem"  => subitems.present? }
            .merge(@system_arguments[:classes])
          )

          if subitems.present?
            @system_arguments[:tabindex] = 0
          else
            @content_arguments[:tabindex] = 0
          end

          @content_arguments[:tag] = :span if subitems.present?
          @content_arguments[:"aria-current"] = "page" if selected?
        end
      end
    end
  end
end
