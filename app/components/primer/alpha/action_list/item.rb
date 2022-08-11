# frozen_string_literal: true

module Primer
  module Alpha
    class ActionList
      # :nodoc:
      class Item < Primer::Component
        DEFAULT_SIZE = :small
        SIZE_MAPPINGS = {
          DEFAULT_SIZE => nil,
          :medium => "ActionList-content--sizeMedium",
          :large => "ActionList-content--sizeLarge"
        }.freeze
        SIZE_OPTIONS = SIZE_MAPPINGS.keys.freeze

        DEFAULT_DESCRIPTION_VARIANT = :block
        DESCRIPTION_VARIANT_MAPPINGS = {
          :inline => "ActionList-item-descriptionWrap--inline",
          DEFAULT_DESCRIPTION_VARIANT => "ActionList-item-descriptionWrap--block"
        }.freeze
        DESCRIPTION_VARIANT_OPTIONS = DESCRIPTION_VARIANT_MAPPINGS.keys.freeze

        DEFAULT_VARIANT = :default
        VARIANT_MAPPINGS = {
          DEFAULT_VARIANT => nil,
          :danger => "ActionList-item--danger"
        }.freeze
        VARIANT_OPTIONS = VARIANT_MAPPINGS.keys.freeze

        DEFAULT_SELECT_MODE = :none
        SELECT_MODE_OPTIONS = [DEFAULT_SELECT_MODE, :single, :multiple].freeze

        renders_one :description

        renders_one :leading_action, types: {
          icon: Primer::OcticonComponent,
          avatar: lambda { |**kwargs|
            Primer::Beta::Avatar.new(**{ **kwargs, size: 16 })
          },
          svg: lambda { |**system_arguments|
            Primer::BaseComponent.new(tag: :svg, **system_arguments)
          }
        }

        renders_one :leading_action_button, types: {
          button: lambda { |**system_arguments|
            Primer::IconButton.new(scheme: :default, classes: "ActionList-item-button", **system_arguments)
          }
        }

        renders_one :trailing_action, types: {
          icon: Primer::OcticonComponent,
          label: Primer::LabelComponent,
          counter: Primer::CounterComponent,
          text: ->(text) { text }
        }

        renders_one :trailing_action_button, types: {
          button: lambda { |**system_arguments|
            Primer::IconButton.new(scheme: :default, classes: "ActionList-item-button", **system_arguments)
          }
        }

        renders_many :items, lambda { |**system_arguments|
          @list.build_item(**system_arguments, root: @root || self).tap do |item|
            @list.will_add_item(item)

            if item.active? && !@root
              @content_arguments[:classes] = class_names(
                @content_arguments[:classes],
                "ActionList-content--hasActiveSubItem"
              )
            end
          end
        }

        attr_reader :root, :active, :disabled, :checked, :expanded

        alias active? active
        alias disabled? disabled
        alias checked? checked
        alias expanded? expanded

        def initialize(
          list:,
          root:,
          label:,
          truncate_label: false,
          href: nil,
          role: "menuitem",
          size: DEFAULT_SIZE,
          variant: DEFAULT_VARIANT,
          disabled: false,
          description_variant: DEFAULT_DESCRIPTION_VARIANT,
          select_mode: DEFAULT_SELECT_MODE,
          checked: false,
          active: false,
          on_click: nil,
          expanded: false,
          **system_arguments
        )
          @list = list
          @root = root
          @label = label
          @href = href
          @truncate_label = truncate_label
          @disabled = disabled
          @checked = checked
          @active = active
          @expanded = expanded
          @system_arguments = system_arguments

          @size = fetch_or_fallback(SIZE_OPTIONS, size, DEFAULT_SIZE)
          @variant = fetch_or_fallback(VARIANT_OPTIONS, variant, DEFAULT_VARIANT)
          @select_mode = fetch_or_fallback(SELECT_MODE_OPTIONS, select_mode, DEFAULT_SELECT_MODE)
          @description_variant = fetch_or_fallback(
            DESCRIPTION_VARIANT_OPTIONS, description_variant, DEFAULT_DESCRIPTION_VARIANT
          )

          @system_arguments[:classes] = class_names(
            @system_arguments[:classes],
            VARIANT_MAPPINGS[@variant],
            "ActionList-item",
            "ActionList-item--navActive" => @active,
            "ActionList-item--subItem" => sub_item?
          )

          @system_arguments[:role] = role

          @system_arguments[:aria] ||= {}
          @system_arguments[:aria][:disabled] = "true" if @disabled

          case @select_mode
          when :single
            @system_arguments[:aria][:selected] = "true" if @active
          when :multiple
            @system_arguments[:aria][:checked] = "true" if @checked
          end

          @label_arguments = {
            classes: class_names(
              "ActionList-item-label",
              "ActionList-item-label--truncate" => @truncate_label
            )
          }

          @content_arguments = {
            classes: class_names(
              "ActionList-content",
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
              "ActionList-item-descriptionWrap",
              DESCRIPTION_VARIANT_MAPPINGS[@description_variant]
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

        def expand!
          @expanded = true
        end

        private

        def before_render
          raise "Cannot render a trailing visual for an item with subitems" if items.present? && trailing_visual.present?

          if items.present?
            @content_arguments[:tag] = :button
            @content_arguments[:"aria-expanded"] = expanded?.to_s
            # Apply click handler to .ActionList-content button element, enables toggle behavior
            @content_arguments[:"data-action"] = "click:action-list#handleItemWithSubItemClick"
            # Apply click handler to .ActionList-item li element, enables highlight behavior

            @system_arguments[:"data-action"] = "click:action-list#handleItemClick"

            @system_arguments[:classes] = class_names(
              @system_arguments[:classes],
              "ActionList-item--hasSubItem"
            )
          end

          if leading_visual
            @content_arguments[:classes] = class_names(
              @content_arguments[:classes],
              "ActionList-content--visual16" => leading_visual && items.present?,
              "ActionList-content--blockDescription" => description && @description_variant == :block
            )
          end
        end
      end
    end
  end
end
