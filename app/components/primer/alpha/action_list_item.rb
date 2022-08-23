# frozen_string_literal: true

module Primer
  module Alpha
    # :nodoc:
    class ActionListItem < Primer::Component
      status :alpha

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
      SELECT_MODE_OPTIONS = [DEFAULT_SELECT_MODE, :multiple, :single].freeze

      renders_one :description

      renders_one :leading_action_visual, types: {
        icon: Primer::OcticonComponent,
        svg: lambda { |**system_arguments|
          Primer::BaseComponent.new(tag: :svg, **system_arguments)
        }
      }

      renders_one :leading_action_button, types: {
        button: lambda { |**system_arguments|
          Primer::IconButton.new(scheme: :default, classes: "ActionList-item-button", **system_arguments)
        }
      }

      renders_one :trailing_action_visual, types: {
        icon: Primer::OcticonComponent,
        svg: lambda { |**system_arguments|
          Primer::BaseComponent.new(tag: :svg, **system_arguments)
        }
      }

      renders_one :trailing_action_button, lambda { |**system_arguments|
        Primer::IconButton.new(scheme: :default, classes: "ActionList-item-button", **system_arguments)
      }

      renders_one :leading_visual, types: {
        icon: Primer::OcticonComponent,
        avatar: lambda { |**kwargs|
          Primer::Beta::Avatar.new(**{ **kwargs, size: 16 })
        },
        svg: lambda { |**system_arguments|
          Primer::BaseComponent.new(tag: :svg, **system_arguments)
        }
      }

      renders_one :trailing_visual, types: {
        icon: Primer::OcticonComponent,
        label: Primer::LabelComponent,
        counter: Primer::CounterComponent,
        text: ->(text) { text }
      }

      def initialize(
        label:,
        truncate_label: false,
        href: nil,
        role: "listitem",
        size: DEFAULT_SIZE,
        variant: DEFAULT_VARIANT,
        disabled: false,
        description_variant: DEFAULT_DESCRIPTION_VARIANT,
        select_mode: DEFAULT_SELECT_MODE,
        checked: false,
        active: false,
        on_click: nil,
        has_sub_item: false,
        sub_item: false,
        show_on_hover: false,
        leading_action_button: false,
        trailing_action_button: false,
        **system_arguments
      )
        @label = label
        @href = href
        @truncate_label = truncate_label
        @disabled = disabled
        @checked = checked
        @active = active
        @has_sub_item = has_sub_item
        @sub_item = sub_item
        @show_on_hover = show_on_hover
        @leading_action_button = leading_action_button
        @trailing_action_button = trailing_action_button
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
          "ActionList-item--withActions" => @leading_action_button || @trailing_action_button,
          "ActionList-item--navActive" => @active,
          "ActionList-item--hasSubItem" => @has_sub_item,
          "ActionList-item--subItem" => @sub_item
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

        @action_button_arguments = {
          classes: class_names(
            "ActionList-item-button",
            "ActionList-item-button--trailing",
            "ActionList-item-button--onHover" => @show_on_hover
          )
        }

        @label_arguments = {
          classes: class_names(
            "ActionList-item-label",
            "ActionList-item-label--truncate" => @truncate_label
          )
        }

        @content_arguments = {
          tag: !@href || @disabled ? :span : :a,
          **(on_click && !@href ? { onclick: on_click } : {}),
          classes: class_names(
            "ActionList-content",
            SIZE_MAPPINGS[@size]
          )
        }

        @description_wrapper_arguments = {
          classes: class_names(
            "ActionList-item-descriptionWrap",
            DESCRIPTION_VARIANT_MAPPINGS[@description_variant]
          )
        }
      end

      private

      def before_render
        return unless description && @description_variant == :block

        @content_arguments[:classes] = class_names(
          @content_arguments[:classes],
          "ActionList-content--blockDescription"
        )
      end
    end
  end
end
