# frozen_string_literal: true

module Primer
  module Alpha
    class ActionList
      # :nodoc:
      class Item < Primer::Component
        DEFAULT_SIZE = :medium
        SIZE_MAPPINGS = {
          DEFAULT_SIZE => nil,
          :large => "ActionListContent--sizeLarge",
          :xlarge => "ActionListContent--sizeXLarge"
        }.freeze
        SIZE_OPTIONS = SIZE_MAPPINGS.keys.freeze

        DEFAULT_DESCRIPTION_SCHEME = :block
        DESCRIPTION_SCHEME_MAPPINGS = {
          :inline => "ActionListItem-descriptionWrap--inline",
          DEFAULT_DESCRIPTION_SCHEME => "ActionListItem-descriptionWrap"
        }.freeze
        DESCRIPTION_SCHEME_OPTIONS = DESCRIPTION_SCHEME_MAPPINGS.keys.freeze

        DEFAULT_SCHEME = :default
        SCHEME_MAPPINGS = {
          DEFAULT_SCHEME => nil,
          :danger => "ActionListItem--danger"
        }.freeze
        SCHEME_OPTIONS = SCHEME_MAPPINGS.keys.freeze

        renders_one :description

        renders_one :leading_visual, types: {
          icon: Primer::OcticonComponent,
          avatar: lambda { |**kwargs|
            # Primer::Beta::Avatar.new(**{ **kwargs, size: 16 })
          },
          svg: lambda { |**system_arguments|
            # Primer::BaseComponent.new(tag: :svg, **system_arguments)
          }
        }

        renders_one :private_leading_action, types: {
          icon: Primer::OcticonComponent,
          svg: lambda { |**system_arguments|
            # Primer::BaseComponent.new(tag: :svg, **system_arguments)
          }
        }

        renders_one :trailing_visual, types: {
          icon: Primer::OcticonComponent,
          label: Primer::LabelComponent,
          counter: Primer::CounterComponent
          # text: ->(text) { text }
        }

        renders_one :private_trailing_action, types: {
          icon: Primer::OcticonComponent,
          svg: lambda { |**system_arguments|
            Primer::BaseComponent.new(tag: :svg, **system_arguments)
          }
        }

        renders_one :trailing_action, lambda { |show_on_hover: false, **system_arguments|
          @trailing_action_on_hover = true

          Primer::Beta::IconButton.new(scheme: :invisible, classes: ["ActionListItem-trailingAction"], **system_arguments)
        }

        renders_many :items, lambda { |**system_arguments|
          @list.build_item(**system_arguments, root: @root || self).tap do |item|
            @list.will_add_item(item)

            # if item.active? && !@root
            #   @content_arguments[:classes] = class_names(
            #     @content_arguments[:classes],
            #     "ActionListContent--hasActiveSubItem"
            #   )
            # end
          end
        }

        # `Tooltip` that appears on mouse hover or keyboard focus over the button. Use tooltips sparingly and as a last resort.
        # **Important:** This tooltip defaults to `type: :description`. In a few scenarios, `type: :label` may be more appropriate.
        # Consult the <%= link_to_component(Primer::Alpha::Tooltip) %> documentation for more information.
        #
        # @param type [Symbol] (:description) <%= one_of(Primer::Alpha::Tooltip::TYPE_OPTIONS) %>
        # @param system_arguments [Hash] Same arguments as <%= link_to_component(Primer::Alpha::Tooltip) %>.
        renders_one :tooltip, lambda { |**system_arguments|
          raise ArgumentError, "Buttons with a tooltip must have a unique `id` set on the `Button`." if @id.blank? && !Rails.env.production?

          system_arguments[:for_id] = @id
          system_arguments[:type] ||= :description

          Primer::Alpha::Tooltip.new(**system_arguments)
        }

        attr_reader :root, :active, :disabled

        alias active? active
        alias disabled? disabled

        def initialize(
          list:,
          root:,
          label:,
          truncate_label: false,
          href: nil,
          role: :listitem,
          size: DEFAULT_SIZE,
          scheme: DEFAULT_SCHEME,
          disabled: false,
          description_scheme: DEFAULT_DESCRIPTION_SCHEME,
          active: false,
          on_click: nil,
          expanded: false,
          id: SecureRandom.hex,
          **system_arguments
        )
          @list = list
          @root = root
          @label = label
          @href = href
          @truncate_label = truncate_label
          @disabled = disabled
          @active = active
          @expanded = expanded
          @trailing_action_on_hover = false
          @id = id
          @system_arguments = system_arguments

          @size = fetch_or_fallback(SIZE_OPTIONS, size, DEFAULT_SIZE)
          @scheme = fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)
          @description_scheme = fetch_or_fallback(
            DESCRIPTION_SCHEME_OPTIONS, description_scheme, DEFAULT_DESCRIPTION_SCHEME
          )

          @system_arguments[:classes] = class_names(
            @system_arguments[:classes],
            SCHEME_MAPPINGS[@scheme],
            "ActionListItem",
            "ActionListItem--navActive" => @active,
            "ActionListItem--subItem" => sub_item?
          )

          @system_arguments[:role] = role

          @system_arguments[:aria] ||= {}
          @system_arguments[:aria][:disabled] = "true" if @disabled

          @label_arguments = {
            classes: class_names(
              "ActionListItem-label",
              "ActionListItem-label--truncate" => @truncate_label
            )
          }

          @content_arguments = {
            id: @id,
            classes: class_names(
              "ActionListContent",
              SIZE_MAPPINGS[@size]
            )
          }

          if @href && !@disabled
            @content_arguments[:tag] = :a
            @content_arguments[:href] = @href
          else
            @content_arguments[:tag] = :span
            @content_arguments[:onclick] = on_click if on_click
          end

          @description_wrapper_arguments = {
            classes: class_names(
              "ActionListItem-descriptionWrap",
              DESCRIPTION_SCHEME_MAPPINGS[@description_scheme]
            )
          }

          @sub_group_arguments = {
            classes: class_names(
              "ActionList",
              "ActionList--subGroup"
            )
          }
        end

        def sub_item?
          @root.present?
        end

        private

        def before_render
          raise "Cannot render a trailing visual for an item with subitems" if items.present? && trailing_visual.present?

          @system_arguments[:classes] = class_names(
            @system_arguments[:classes],
            "ActionListItem--withActions" => trailing_action.present?,
            "ActionListItem--trailingActionHover" => @trailing_action_on_hover
          )

          if items.present?
            @content_arguments[:tag] = :button
            @content_arguments[:"aria-expanded"] = @expanded.to_s
            @content_arguments[:"data-action"] = "click:#{@list.custom_element_name}#handleItemWithSubItemClick"
            @system_arguments[:"data-action"] = "click:#{@list.custom_element_name}#handleItemClick"

            @system_arguments[:classes] = class_names(
              @system_arguments[:classes],
              "ActionListItem--hasSubItem"
            )
          end

          return unless leading_visual

          @content_arguments[:classes] = class_names(
            @content_arguments[:classes],
            "ActionListContent--visual16" => leading_visual && items.present?,
            "ActionListContent--blockDescription" => description && @description_scheme == :block
          )
        end
      end
    end
  end
end
