# frozen_string_literal: true

module Primer
  module Beta
    # Use `Button` for actions (e.g. in forms). Use links for destinations, or moving from one page to another.
    # @accessibility
    #   Additional markup is required if setting the `tag` argument to either `:a` or `:summary`.
    #
    #   * `:a` requires you to pass in an `href` attribute
    #   * `:summary` requires you to wrap the component in a `<details>` element
    class Button < Primer::Component
      status :beta

      DEFAULT_SCHEME = :default
      SCHEME_MAPPINGS = {
        DEFAULT_SCHEME => "",
        :primary => "Button--primary",
        :secondary => "Button--secondary",
        :default => "Button--secondary",
        :danger => "Button--danger",
        :invisible => "Button--invisible",
        :link => "Button--link"
      }.freeze
      SCHEME_OPTIONS = SCHEME_MAPPINGS.keys

      DEFAULT_SIZE = :medium
      SIZE_MAPPINGS = {
        :small => "Button--small",
        :medium => "Button--medium",
        :large => "Button--large",
        DEFAULT_SIZE => "Button--medium"
      }.freeze
      SIZE_OPTIONS = SIZE_MAPPINGS.keys

      DEFAULT_ALIGN_CONTENT = :center
      ALIGN_CONTENT_MAPPINGS = {
        :start => "Button-content--alignStart",
        :center => "",
        DEFAULT_ALIGN_CONTENT => ""
      }.freeze
      ALIGN_CONTENT_OPTIONS = ALIGN_CONTENT_MAPPINGS.keys

      # Leading visuals appear to the left of the button text.
      #
      # Use:
      #
      # - `leading_visual_icon` for a <%= link_to_component(Primer::Beta::Octicon) %>.
      #
      # - `leading_visual_svg` to render a SVG.
      #
      # @param system_arguments [Hash] Same arguments as <%= link_to_component(Primer::Beta::Octicon) %>.
      renders_one :leading_visual, types: {
        icon: lambda { |**system_arguments|
          Primer::Beta::Octicon.new(**system_arguments)
        },
        svg: lambda { |**system_arguments|
          Primer::BaseComponent.new(tag: :svg, width: "16", height: "16", **system_arguments)
        }
      }

      # Trailing visuals appear to the right of the button text.
      #
      # Use:
      #
      # - `trailing_visual_counter` for a <%= link_to_component(Primer::Beta::Counter) %>.
      #
      # @param system_arguments [Hash] Same arguments as <%= link_to_component(Primer::Beta::Counter) %>.
      renders_one :trailing_visual, types: {
        icon: Primer::Beta::Octicon,
        label: Primer::Beta::Label,
        counter: lambda { |**system_arguments|
          @trailing_visual_counter = true
          Primer::Beta::Counter.new(**system_arguments)
        }
      }

      # Trailing action appears to the right of the trailing visual.
      #
      # Use:
      #
      # - `trailing_action_icon` for a <%= link_to_component(Primer::Beta::Octicon) %>.
      #
      # @param system_arguments [Hash] Same arguments as <%= link_to_component(Primer::Beta::Octicon) %>.
      renders_one :trailing_action, types: {
        icon: Primer::Beta::Octicon
      }

      # `Tooltip` that appears on mouse hover or keyboard focus over the button. Use tooltips sparingly and as a last resort.
      # **Important:** This tooltip defaults to `type: :description`. In a few scenarios, `type: :label` may be more appropriate.
      # Consult the <%= link_to_component(Primer::Alpha::Tooltip) %> documentation for more information.
      #
      # @param type [Symbol] (:description) <%= one_of(Primer::Alpha::Tooltip::TYPE_OPTIONS) %>
      # @param system_arguments [Hash] Same arguments as <%= link_to_component(Primer::Alpha::Tooltip) %>.
      renders_one :tooltip, lambda { |**system_arguments|
        raise ArgumentError, "Buttons with a tooltip must have a unique `id` set on the `Button`." if @id.blank? && !Rails.env.production?

        ::Primer::ViewComponents.deprecation.warn("Buttons with visible text should not use a `label` tooltip. Consider using Primer::Beta::IconButton instead.") if system_arguments[:type] == :label
        system_arguments[:for_id] = @id
        system_arguments[:type] = :description

        Primer::Alpha::Tooltip.new(**system_arguments)
      }

      # @param base_button_class [Class] The button class to render.
      # @param scheme [Symbol] <%= one_of(Primer::Beta::Button::SCHEME_OPTIONS) %>
      # @param size [Symbol] <%= one_of(Primer::Beta::Button::SIZE_OPTIONS) %>
      # @param block [Boolean] Whether button is full-width with `display: block`.
      # @param align_content [Symbol] <%= one_of(Primer::Beta::Button::ALIGN_CONTENT_OPTIONS) %>
      # @param tag [Symbol] (Primer::Beta::BaseButton::DEFAULT_TAG) <%= one_of(Primer::Beta::BaseButton::TAG_OPTIONS) %>
      # @param type [Symbol] (Primer::Beta::BaseButton::DEFAULT_TYPE) <%= one_of(Primer::Beta::BaseButton::TYPE_OPTIONS) %>
      # @param inactive [Boolean] Whether the button looks visually disabled, but can still accept all the same interactions as an enabled button.
      # @param disabled [Boolean] Whether or not the button is disabled. If true, this option forces `tag:` to `:button`.
      # @param label_wrap [Boolean] Whether or not the button label text wraps and the button height expands.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        base_button_class: Primer::Beta::BaseButton,
        scheme: DEFAULT_SCHEME,
        size: DEFAULT_SIZE,
        block: false,
        align_content: DEFAULT_ALIGN_CONTENT,
        disabled: false,
        label_wrap: false,
        **system_arguments
      )
        @base_button_class = base_button_class
        @scheme = scheme
        @block = block
        @label_wrap = label_wrap

        @system_arguments = system_arguments
        @system_arguments[:disabled] = disabled

        @id = @system_arguments[:id]

        raise ArgumentError, "The `variant:` argument is no longer supported on Primer::Beta::Button. Consider `scheme:` or `size:`." if !Rails.env.production? && @system_arguments[:variant].present?
        raise ArgumentError, "The `dropdown:` argument is no longer supported on Primer::Beta::Button. Use the `trailing_action` slot instead." if !Rails.env.production? && @system_arguments[:dropdown].present?

        @align_content_classes = class_names(
          "Button-content",
          ALIGN_CONTENT_MAPPINGS[fetch_or_fallback(ALIGN_CONTENT_OPTIONS, align_content, DEFAULT_ALIGN_CONTENT)]
        )

        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)],
          SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, DEFAULT_SIZE)],
          "Button",
          "Button--fullWidth" => @block,
          "Button--labelWrap" => @label_wrap
        )
      end

      private

      def before_render
        return unless @scheme == :invisible && !trailing_visual && !leading_visual && !trailing_action

        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "Button--invisible-noVisuals"
        )
      end
    end
  end
end
