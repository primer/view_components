# frozen_string_literal: true

module Primer
  module Alpha
    class ActionListItem < Primer::Component
      status :alpha

      DEFAULT_SIZE = :small
      SIZE_MAPPINGS = {
        DEFAULT_SIZE => nil,
        :medium => "ActionList-content--sizeMedium",
        :large => "ActionList-content--sizeLarge"
      }.freeze
      SIZE_OPTIONS = SIZE_MAPPINGS.keys.freeze

      DEFAULT_DESCRIPTION_DISPLAY = :inline
      DESCRIPTION_DISPLAY_MAPPINGS = {
        DEFAULT_DESCRIPTION_DISPLAY => "ActionList-item-descriptionWrap--inline",
        :block => "ActionList-item-descriptionWrap--block"
      }.freeze
      DESCRIPTION_DISPLAY_OPTIONS = DESCRIPTION_DISPLAY_MAPPINGS.keys.freeze

      DEFAULT_VARIANT = :default
      VARIANT_MAPPINGS = {
        DEFAULT_VARIANT => nil,
        :danger => "ActionList-item--danger"
      }.freeze
      VARIANT_OPTIONS = VARIANT_MAPPINGS.keys.freeze

      DEFAULT_SELECT_MODE = :none
      SELECT_MODE_ICON_MAPPINGS = {
        DEFAULT_SELECT_MODE => nil,
        :single => "ActionList-item--singleSelectCheckmark",
        :multiple => "ActionList-item-multiSelectIcon"
      }.freeze
      SELECT_MODE_OPTIONS = SELECT_MODE_ICON_MAPPINGS.keys.freeze

      renders_one :description

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
        text: lambda { |text| text }
      }

      def initialize(
        label:,
        truncate_label: false,
        size: DEFAULT_SIZE,
        variant: DEFAULT_VARIANT,
        disabled: false,
        description_display: DEFAULT_DESCRIPTION_DISPLAY,
        select_mode: DEFAULT_SELECT_MODE,
        checked: false,
        **system_arguments
      )
        @label = label
        @truncate_label = truncate_label
        @disabled = disabled
        @checked = checked
        @system_arguments = system_arguments

        @size = fetch_or_fallback(SIZE_OPTIONS, size, DEFAULT_SIZE)
        @variant = fetch_or_fallback(VARIANT_OPTIONS, variant, DEFAULT_VARIANT)
        @select_mode = fetch_or_fallback(SELECT_MODE_OPTIONS, select_mode, DEFAULT_SELECT_MODE)
        @description_display = fetch_or_fallback(
          DESCRIPTION_DISPLAY_OPTIONS, description_display, DEFAULT_DESCRIPTION_DISPLAY
        )

        if @select_mode.nil? && @checked
          raise ArgumentError, "checked may only be true if select_mode is specified, i.e. not nil."
        end

        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "ActionList-item",
          VARIANT_MAPPINGS[@variant]
        )

        @system_arguments[:aria] ||= {}
        @system_arguments[:aria][:disabled] = "true" if @disabled
        @system_arguments[:aria][:checked] = @checked.to_s unless @select_mode.nil?

        @label_arguments = {
          classes: class_names(
            "ActionList-item-label",
            "ActionList-item-label--truncate" => @truncate_label
          )
        }

        @content_arguments = {
          classes: class_names(
            "ActionList-content",
            SIZE_MAPPINGS[@size],
          )
        }

        @description_wrapper_arguments = {
          classes: class_names(
            "ActionList-item-descriptionWrap",
            DESCRIPTION_DISPLAY_MAPPINGS[@description_display]
          )
        }
      end

      private

      def before_render
        return unless description && @description_display == :block

        @content_arguments[:classes] = class_names(
          @content_arguments[:classes],
          "ActionList-content--blockDescription"
        )
      end
    end
  end
end
