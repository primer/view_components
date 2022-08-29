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
          :inline => "ActionList-item-descriptionWrap--inline",
          DEFAULT_DESCRIPTION_SCHEME => "ActionList-item-descriptionWrap--block"
        }.freeze
        DESCRIPTION_SCHEME_OPTIONS = DESCRIPTION_SCHEME_MAPPINGS.keys.freeze

        DEFAULT_SCHEME = :default
        SCHEME_MAPPINGS = {
          DEFAULT_SCHEME => nil,
          :danger => "ActionList-item--danger"
        }.freeze
        SCHEME_OPTIONS = SCHEME_MAPPINGS.keys.freeze

        DEFAULT_SELECT_MODE = :none
        SELECT_MODE_OPTIONS = [DEFAULT_SELECT_MODE, :single, :multiple].freeze

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
            # Primer::BaseComponent.new(tag: :svg, **system_arguments)
          }
        }

        renders_one :trailing_action, lambda { |**system_arguments|
          Primer::IconButton.new(scheme: :default, classes: ["ActionList-item-button", "hey" => @trailing_action_on_hover], **system_arguments)
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
          role: :listitem,
          size: DEFAULT_SIZE,
          scheme: DEFAULT_SCHEME,
          disabled: false,
          description_scheme: DEFAULT_DESCRIPTION_SCHEME,
          select_mode: DEFAULT_SELECT_MODE,
          checked: false,
          active: false,
          on_click: nil,
          expanded: false,
          trailing_action_on_hover: false,
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
          @trailing_action_on_hover = trailing_action_on_hover
          @system_arguments = system_arguments

          @size = fetch_or_fallback(SIZE_OPTIONS, size, DEFAULT_SIZE)
          @scheme = fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)
          @select_mode = fetch_or_fallback(SELECT_MODE_OPTIONS, select_mode, DEFAULT_SELECT_MODE)
          @description_scheme = fetch_or_fallback(
            DESCRIPTION_SCHEME_OPTIONS, description_scheme, DEFAULT_DESCRIPTION_SCHEME
          )

          @system_arguments[:classes] = class_names(
            @system_arguments[:classes],
            SCHEME_MAPPINGS[@scheme],
            "ActionList-item",
            "ActionList-item--navActive" => @active,
            "ActionList-item--subItem" => sub_item?,
            "ActionList-item--trailingActionHover" => @trailing_action_on_hover,
          )

          @system_arguments[:role] = role

          @system_arguments[:aria] ||= {}
          @system_arguments[:aria][:disabled] = "true" if @disabled

          case @select_mode
          when :single
            # @system_arguments[:aria][:selected] = "true" if @checked
          when :multiple
            # @system_arguments[:aria][:checked] = "true" if @checked
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
            @content_arguments[:"data-action"] = "click:#{@list.custom_element_name}#handleItemWithSubItemClick"
            # Apply click handler to .ActionList-item li element, enables highlight behavior

            @system_arguments[:"data-action"] = "click:#{@list.custom_element_name}#handleItemClick"

            @system_arguments[:classes] = class_names(
              @system_arguments[:classes],
              "ActionList-item--hasSubItem"
            )
          end

          return unless leading_visual

          @content_arguments[:classes] = class_names(
            @content_arguments[:classes],
            "ActionList-content--visual16" => leading_visual && items.present?,
            "ActionList-content--blockDescription" => description && @description_scheme == :block
          )
        end
      end
    end
  end
end
