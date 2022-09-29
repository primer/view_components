# frozen_string_literal: true

module Primer
  module Alpha
    class ActionList
      # An individual `ActionList` item. Items can optionally include leading and/or trailing visuals,
      # such as icons, avatars, and counters.
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

        # An icon, avatar, SVG, or custom content that will render to the left of the label.
        #
        # To render an icon, call the `with_leading_visual_icon` method, which accepts the arguments accepted by <%= link_to_component(Primer::OcticonComponent) %>.
        #
        # To render an avatar, call the `with_leading_visual_avatar` method, which accepts the arguments accepted by <%= link_to_component(Primer::Beta::Avatar) %>.
        #
        # To render an SVG, call the `with_leading_visual_svg` method.
        #
        # To render custom content, call the `with_leading_visual_content` method and pass a block that returns a string.
        renders_one :leading_visual, types: {
          icon: Primer::OcticonComponent,
          avatar: ->(**kwargs) { Primer::Beta::Avatar.new(**{ **kwargs, size: 16 }) },
          svg: lambda { |**system_arguments|
            Primer::BaseComponent.new(tag: :svg, width: "16", height: "16", **system_arguments)
          },
          content: lambda { |**system_arguments|
            Primer::BaseComponent.new(tag: :span, **system_arguments)
          }
        }

        # Used internally.
        #
        # @private
        renders_one :private_leading_action_icon, Primer::OcticonComponent

        # An icon, label, counter, or text to render to the right of the label.
        #
        # To render an icon, call the `with_leading_visual_icon` method, which accepts the arguments accepted by <%= link_to_component(Primer::OcticonComponent) %>.
        #
        # To render a label, call the `with_leading_visual_label` method, which accepts the arguments accepted by <%= link_to_component(Primer::LabelComponent) %>.
        #
        # To render a counter, call the `with_leading_visual_counter` method, which accepts the arguments accepted by <%= link_to_component(Primer::CounterComponent) %>.
        #
        # To render text, call the `with_leading_visual_text` method and pass a block that returns a string. Eg:
        # ```ruby
        # with_leading_visual_text { "Text here" }`
        # ```
        renders_one :trailing_visual, types: {
          icon: Primer::OcticonComponent,
          label: Primer::LabelComponent,
          counter: Primer::CounterComponent,
          text: ->(text) { text }
        }

        # Used internally.
        #
        # @private
        renders_one :private_trailing_action_icon, Primer::OcticonComponent

        # A button rendered after the trailing icon that can be used to show a menu, activate
        # a dialog, etc.
        #
        # @param show_on_hover [Boolean] Whether or not to show the button when the list item is hovered. If `true`, the button will be invisible until hovered. If `false`, the button will always be visible. Defaults to `false`.
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Beta::IconButton) %>.
        renders_one :trailing_action, lambda { |show_on_hover: false, **system_arguments|
          @trailing_action_on_hover = show_on_hover

          Primer::Beta::IconButton.new(scheme: :invisible, classes: ["ActionListItem-trailingAction"], **system_arguments)
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

        # Used internally.
        #
        # @private
        renders_one :private_content

        attr_reader :list, :active, :disabled, :parent

        # Whether or not this item is active.
        #
        # @return [Boolean]
        alias active? active

        # Whether or not this item is disabled.
        #
        # @return [Boolean]
        alias disabled? disabled

        # @param list [Primer::Alpha::ActionList] The list that contains this item. Used internally.
        # @param parent [Primer::Alpha::ActionList::Item] This item's parent item. `nil` if this item is at the root. Used internally.
        # @param label [String] Item label.
        # @param label_classes [String] CSS classes that will be added to the label.
        # @param truncate_label [Boolean] Truncate label with ellipsis.
        # @param href [String] Link URL.
        # @param role [String] ARIA role describing the function of the item.
        # @param size [Symbol] Controls block sizing of the item.
        # @param scheme [Symbol] Controls color/style based on behavior.
        # @param disabled [Boolean] Disabled items are not clickable and visually dim.
        # @param description_scheme [Symbol] Display description inline with label, or block on the next line.
        # @param active [Boolean] Sets an active state on navigational items.
        # @param on_click [String] JavaScript to execute when the item is clicked.
        # @param id [String] Used internally.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(
          list:,
          label:,
          label_classes: nil,
          parent: nil,
          truncate_label: false,
          href: nil,
          role: :listitem,
          size: DEFAULT_SIZE,
          scheme: DEFAULT_SCHEME,
          disabled: false,
          description_scheme: DEFAULT_DESCRIPTION_SCHEME,
          active: false,
          on_click: nil,
          id: SecureRandom.hex,
          **system_arguments
        )
          @list = list
          @parent = parent
          @label = label
          @href = href
          @truncate_label = truncate_label
          @disabled = disabled
          @active = active
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
            "ActionListItem--navActive" => @active
          )

          @system_arguments[:role] = role

          @system_arguments[:aria] ||= {}
          @system_arguments[:aria][:disabled] = "true" if @disabled

          @label_arguments = {
            classes: class_names(
              label_classes,
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
        end

        private

        def before_render
          @system_arguments[:classes] = class_names(
            @system_arguments[:classes],
            "ActionListItem--withActions" => trailing_action.present?,
            "ActionListItem--trailingActionHover" => @trailing_action_on_hover
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
