# typed: true
# frozen_string_literal: true

module Primer
  module Alpha
    class ActionMenu
      # This component is part of <%= link_to_component(Primer::Alpha::ActionMenu) %> and should not be
      # used as a standalone component.
      #
      # One of the following is required to apply functionality to the menu item: <%= one_of(Primer::Alpha::ActionMenu::Item::ACTION_OPTIONS) %>
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

        # Description content that complements the item's label. See `ActionList`'s `description_scheme` argument
        # for layout options.
        renders_one :description

        attr_reader :disabled, :href
        alias disabled? disabled

        TAG_OPTIONS = [:a, :button, :"clipboard-copy", :span].freeze
        ACTION_OPTIONS = [:classes, :onclick, :href, :value].freeze

        # Leading visuals appear to the left of the item text.
        #
        # Use:
        #
        # - `leading_visual_icon` for a <%= link_to_component(Primer::Beta::Octicon) %>.
        #
        # @param system_arguments [Hash] Same arguments as <%= link_to_component(Primer::Beta::Octicon) %>.
        renders_one :leading_visual, types: {
          icon: lambda { |**system_arguments|
            Primer::Beta::Octicon.new(classes: "ActionList-item-visual ActionList-item-visual--leading", **system_arguments)
          },
          avatar: ->(**kwargs) { Primer::Beta::Avatar.new(**{ **kwargs, size: 16 }) },
          svg: lambda { |**system_arguments|
            Primer::BaseComponent.new(tag: :svg, width: "16", height: "16", **system_arguments)
          },
          content: lambda { |**system_arguments|
            Primer::BaseComponent.new(tag: :span, **system_arguments)
          }
        }

        # An icon, label, counter, or text to render to the right of the label.
        #
        # To render an icon, call the `with_leading_visual_icon` method, which accepts the arguments accepted by <%= link_to_component(Primer::Beta::Octicon) %>.
        #
        # To render a label, call the `with_leading_visual_label` method, which accepts the arguments accepted by <%= link_to_component(Primer::Beta::Label) %>.
        #
        # To render a counter, call the `with_leading_visual_counter` method, which accepts the arguments accepted by <%= link_to_component(Primer::Beta::Counter) %>.
        #
        # To render text, call the `with_leading_visual_text` method and pass a block that returns a string. Eg:
        # ```ruby
        # with_leading_visual_text { "Text here" }`
        # ```
        renders_one :trailing_visual, types: {
          icon: Primer::Beta::Octicon,
          label: Primer::Beta::Label,
          counter: Primer::Beta::Counter,
          text: ->(text) { text }
        }

        # `Tooltip` that appears on mouse hover or keyboard focus over the trailing action button. Use tooltips sparingly and as
        # a last resort. **Important:** This tooltip defaults to `type: :description`. In a few scenarios, `type: :label` may be
        # more appropriate. Consult the <%= link_to_component(Primer::Alpha::Tooltip) %> documentation for more information.
        #
        # @param type [Symbol] (:description) <%= one_of(Primer::Alpha::Tooltip::TYPE_OPTIONS) %>
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::Tooltip) %>.
        renders_one :tooltip, lambda { |**system_arguments|
          raise ArgumentError, "Buttons with a tooltip must have a unique `id` set on the `Button`." if @id.blank? && !Rails.env.production?

          system_arguments[:for_id] = @id
          system_arguments[:type] ||= :description

          Primer::Alpha::Tooltip.new(**system_arguments)
        }

        # @example Default
        #  <%= render Primer::Alpha::ActionMenu::Item.new(classes: "do-something-js") do %>
        #   Quote
        #  <% end %>
        #
        # @example Link
        #  <%= render Primer::Alpha::ActionMenu::Item.new(tag: :a, href: "https://primer.style/") do %>
        #   primer.style
        #  <% end %>
        #
        # @example Button
        #  <%= render Primer::Alpha::ActionMenu::Item.new(tag: :button, type: "button", onclick: "() => {}") do %>
        #   This does something
        #  <% end %>
        #
        # @example Clipboard copy
        #  <%= render Primer::Alpha::ActionMenu::Item.new(tag: :"clipboard-copy", value: "Text to be copied") do %>
        #   Copy text
        #  <% end %>
        # @param tag [Symbol] Optional. The tag to use for the item. <%= one_of(Primer::Alpha::ActionMenu::Item::TAG_OPTIONS) %>
        # @param is_divider [Boolean] Whether to render a divider.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        # @param content_arguments [Hash] <%= link_to_system_arguments_docs %> used to construct the item's anchor or button tag.
        def initialize(
          label: nil,
          label_classes: nil,
          content_arguments: {},
          truncate_label: false,
          href: nil,
          size: DEFAULT_SIZE,
          scheme: DEFAULT_SCHEME,
          description_scheme: DEFAULT_DESCRIPTION_SCHEME,
          is_divider: false,
          disabled: false,
          select_variant: Primer::Alpha::ActionMenu::DEFAULT_SELECT_VARIANT,
          **system_arguments
        )
          @is_divider = is_divider
          @disabled = disabled
          @label = label
          @href = href
          @select_variant = select_variant
          @truncate_label = truncate_label
          @system_arguments = system_arguments
          @content_arguments = content_arguments

          @size = fetch_or_fallback(SIZE_OPTIONS, size, DEFAULT_SIZE)
          @scheme = fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)
          @description_scheme = fetch_or_fallback(
            DESCRIPTION_SCHEME_OPTIONS, description_scheme, DEFAULT_DESCRIPTION_SCHEME
          )

          @system_arguments[:classes] = class_names(
            @system_arguments[:classes],
            SCHEME_MAPPINGS[@scheme],
            "ActionListItem"
          )

          @label_arguments = {
            classes: class_names(
              label_classes,
              "ActionListItem-label",
              "ActionListItem-label--truncate" => @truncate_label
            )
          }

          @content_arguments[:id] = @id
          @content_arguments[:classes] = class_names(
            @content_arguments[:classes],
            "ActionListContent",
            SIZE_MAPPINGS[@size]
          )

          return if @is_divider

          # check if system_arguments contains an action
          raise ArgumentError, "One of the following are required to apply functionality: #{ACTION_OPTIONS}" unless @system_arguments.keys.any? { |key| ACTION_OPTIONS.include?(key) }

          @list_arguments = list_arguments
          @system_arguments[:classes] = class_names(
            system_arguments[:classes]
          )

          if @href && !@disabled
            @content_arguments[:tag] = :a
            @content_arguments[:href] = @href
            # @system_arguments[:role] = "none"
          else
            @content_arguments[:tag] = :span
          end

          @description_wrapper_arguments = {
            classes: class_names(
              "ActionListItem-descriptionWrap",
              DESCRIPTION_SCHEME_MAPPINGS[@description_scheme]
            )
          }

          case @select_variant
          when :single
            @system_arguments[:role] = "menuitemradio"
            @system_arguments[:"aria-checked"] ||= false
          when :multiple
            @system_arguments[:role] = "menuitemcheckbox"
            @system_arguments[:"aria-checked"] ||= false
          else
            @system_arguments[:role] = "menuitem"
          end

          @system_arguments[:tabindex] = -1
          if disabled?
            @system_arguments[:"aria-disabled"] = true
            @system_arguments[:disabled] = "" if tag == :button
          end
        end

        def list_arguments
          args = {}
          args[:role] = "none"
          args[:tag] = :li
          args[:"aria-disabled"] = true if disabled?

          args[:classes] = if @is_dangerous
                             "ActionListItem ActionListItem--danger"
                           else
                             "ActionListItem"
          end

          args
        end

        private

        def before_render
          @system_arguments[:classes] = class_names(
            @system_arguments[:classes]
          )
          return unless leading_visual

          @content_arguments[:classes] = class_names(
            @content_arguments[:classes],
            "ActionListContent--visual16" => leading_visual,
            "ActionListContent--blockDescription" => description && @description_scheme == :block
          )
        end
      end
    end
  end
end
