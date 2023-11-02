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
        # To render an icon, call the `with_leading_visual_icon` method, which accepts the arguments accepted by <%= link_to_component(Primer::Beta::Octicon) %>.
        #
        # To render an SVG, call the `with_leading_visual_svg` method.
        #
        # To render custom content, call the `with_leading_visual_content` method and pass a block that returns a string.
        renders_one :leading_visual, types: {
          icon: lambda { |**system_arguments, &block|
            deny_aria_key(
              :label,
              "Avoid using `aria-label` on leading visual icons, as they are purely decorative.",
              **system_arguments
            )

            Primer::Beta::Octicon.new(**system_arguments, &block)
          },
          avatar: lambda { |*|
            return unless should_raise_error?

            raise "Leading visual avatars are no longer supported. Please use the #with_avatar_item slot instead."
          },
          svg: lambda { |**system_arguments|
            Primer::BaseComponent.new(tag: :svg, width: "16", height: "16", **system_arguments)
          },
          content: lambda { |**system_arguments|
            Primer::BaseComponent.new(tag: :span, **system_arguments)
          },
          raw_content: nil
        }

        # Used internally.
        #
        # @private
        renders_one :private_leading_action_icon, Primer::Beta::Octicon

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
        # with_leading_visual_text { "Text here" }
        # ```
        renders_one :trailing_visual, types: {
          icon: Primer::Beta::Octicon,
          label: Primer::Beta::Label,
          counter: Primer::Beta::Counter,
          text: ->(text) { text }
        }

        # Used internally.
        #
        # @private
        renders_one :private_trailing_action_icon, Primer::Beta::Octicon

        # A button rendered after the trailing icon that can be used to show a menu, activate
        # a dialog, etc.
        #
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Beta::IconButton) %>.
        renders_one :trailing_action, lambda { |**system_arguments|
          Primer::Beta::IconButton.new(
            scheme: :invisible,
            classes: class_names(
              system_arguments[:classes],
              "ActionListItem-trailingAction"
            ),

            **system_arguments
          )
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

        attr_reader :id, :list, :href, :active, :disabled, :parent

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
        # @param label [String] Item label. If no label is provided, content is used.
        # @param label_classes [String] CSS classes that will be added to the label.
        # @param label_arguments [Hash] <%= link_to_system_arguments_docs %> used to construct the label.
        # @param content_arguments [Hash] <%= link_to_system_arguments_docs %> used to construct the item's anchor or button tag.
        # @param form_arguments [Hash] Allows the item to submit a form on click. The URL passed in the `href:` option will be used as the form action. Pass the `method:` option to this hash to control what kind of request is made, <%= one_of(Primer::Alpha::ActionList::FormWrapper::HTTP_METHOD_OPTIONS) %> The `name:` option is required and specifies the desired name of the field that will be included in the params sent to the server on form submission. Specify the `value:` option to send a custom value to the server; otherwise the value of `name:` is sent.
        # @param truncate_label [Boolean] Truncate label with ellipsis.
        # @param href [String] Link URL.
        # @param role [String] ARIA role describing the function of the item.
        # @param size [Symbol] Controls block sizing of the item.
        # @param scheme [Symbol] Controls color/style based on behavior.
        # @param disabled [Boolean] Disabled items are not clickable and visually dim.
        # @param description_scheme [Symbol] Display description inline with label, or block on the next line. <%= one_of(Primer::Alpha::ActionList::Item::DESCRIPTION_SCHEME_OPTIONS) %>
        # @param active [Boolean] If the parent list's `select_variant` is set to `:single` or `:multiple`, causes this item to render checked.
        # @param on_click [String] JavaScript to execute when the item is clicked.
        # @param id [String] Used internally.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(
          list:,
          label: nil,
          label_classes: nil,
          label_arguments: {},
          content_arguments: {},
          form_arguments: {},
          parent: nil,
          truncate_label: false,
          href: nil,
          role: nil,
          size: DEFAULT_SIZE,
          scheme: DEFAULT_SCHEME,
          disabled: false,
          description_scheme: DEFAULT_DESCRIPTION_SCHEME,
          active: false,
          on_click: nil,
          id: self.class.generate_id,
          **system_arguments
        )
          @list = list
          @parent = parent
          @label = label
          @href = href || content_arguments[:href]
          @truncate_label = truncate_label
          @disabled = disabled
          @active = active
          @id = id
          @system_arguments = system_arguments
          @content_arguments = content_arguments
          @form_wrapper = FormWrapper.new(list: @list, action: @href, **form_arguments)

          @size = fetch_or_fallback(SIZE_OPTIONS, size, DEFAULT_SIZE)
          @scheme = fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)
          @description_scheme = fetch_or_fallback(
            DESCRIPTION_SCHEME_OPTIONS, description_scheme, DEFAULT_DESCRIPTION_SCHEME
          )

          @system_arguments[:classes] = class_names(
            @system_arguments[:classes],
            SCHEME_MAPPINGS[@scheme],
            "ActionListItem",
            "ActionListItem--disabled" => @disabled
          )

          @system_arguments[:data] ||= {}
          @system_arguments[:data][:targets] = "#{list_class.custom_element_name}.items"

          @label_arguments = {
            **label_arguments,
            classes: class_names(
              label_classes,
              label_arguments[:classes],
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

          unless @content_arguments[:tag]
            if @href && @form_wrapper.get? && !@disabled
              @content_arguments[:tag] = :a
              @content_arguments[:href] = @href
            else
              @content_arguments[:tag] = :button
              @content_arguments[:type] = @form_wrapper.form_required? ? :submit : :button
              @content_arguments[:onclick] = on_click if on_click
            end
          end

          if @content_arguments[:tag] != :button && @form_wrapper.form_required?
            raise ArgumentError, "items that submit forms must use a \"button\" tag instead of \"#{@content_arguments[:tag]}\""
          end

          if @content_arguments[:tag] != :button && @list.acts_as_form_input?
            raise ArgumentError, "items within lists/menus that act as form inputs must use \"button\" tags instead of \"#{@content_arguments[:tag]}\""
          end

          if @disabled
            @content_arguments[:aria] ||= merge_aria(
              @content_arguments,
              { aria: { disabled: "true" } }
            )
          end

          @content_arguments[:role] = role ||
                                      if @list.allows_selection?
                                        ActionList::SELECT_VARIANT_ROLE_MAP[@list.select_variant]
                                      elsif @list.acts_as_menu?
                                        ActionList::DEFAULT_MENU_ITEM_ROLE
                                      end

          @system_arguments[:role] = @list.acts_as_menu? ? :none : nil

          @description_wrapper_arguments = {
            classes: class_names(
              "ActionListItem-descriptionWrap",
              DESCRIPTION_SCHEME_MAPPINGS[@description_scheme]
            )
          }
        end

        private

        def before_render
          if @list.allows_selection?
            @content_arguments[:aria] = merge_aria(
              @content_arguments,
              { aria: { checked: active? } }
            )
          end

          @system_arguments[:classes] = class_names(
            @system_arguments[:classes],
            "ActionListItem--withActions" => trailing_action.present?
          )

          return unless leading_visual

          @content_arguments[:classes] = class_names(
            @content_arguments[:classes],
            "ActionListContent--visual16" => leading_visual,
            "ActionListContent--blockDescription" => description && @description_scheme == :block
          )
        end

        def list_class
          Primer::Alpha::ActionList
        end
      end
    end
  end
end
