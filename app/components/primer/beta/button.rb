# frozen_string_literal: true

module Primer
  module Beta
    # Use `Button` for actions (e.g. in forms). Use links for destinations, or moving from one page to another.
    class Button < Primer::Component
      status :beta

      DEFAULT_SCHEME = :default
      LINK_SCHEME = :link
      SCHEME_MAPPINGS = {
        DEFAULT_SCHEME => "",
        :primary => "Button--primary",
        :secondary => "Button--secondary",
        :default => "Button--secondary",
        :danger => "Button--danger",
        :outline => "btn-outline",
        :invisible => "Button--invisible",
        LINK_SCHEME => "btn-link"
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
      # - `leading_visual_icon` for a <%= link_to_component(Primer::OcticonComponent) %>.
      #
      # @param system_arguments [Hash] Same arguments as <%= link_to_component(Primer::OcticonComponent) %>.
      renders_one :leading_visual, types: {
        icon: lambda { |**system_arguments|
          Primer::OcticonComponent.new(**system_arguments)
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
        icon: Primer::OcticonComponent,
        label: Primer::LabelComponent,
        counter: Primer::CounterComponent
      }

      # Trailing action appears to the right of the trailing visual.
      #
      # Use:
      #
      # - `trailing_action_icon` for a <%= link_to_component(Primer::OcticonComponent) %>.
      #
      # @param system_arguments [Hash] Same arguments as <%= link_to_component(Primer::OcticonComponent) %>.
      renders_one :trailing_action, types: {
        icon: Primer::OcticonComponent
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

      # @example Schemes
      #   <%= render(Primer::Beta::Button.new) { "Default" } %>
      #   <%= render(Primer::Beta::Button.new(scheme: :primary)) { "Primary" } %>
      #   <%= render(Primer::Beta::Button.new(scheme: :danger)) { "Danger" } %>
      #   <%= render(Primer::Beta::Button.new(scheme: :outline)) { "Outline" } %>
      #   <%= render(Primer::Beta::Button.new(scheme: :invisible)) { "Invisible" } %>
      #   <%= render(Primer::Beta::Button.new(scheme: :link)) { "Link" } %>
      #
      # @example Sizes
      #   <%= render(Primer::Beta::Button.new(size: :small)) { "Small" } %>
      #   <%= render(Primer::Beta::Button.new(size: :medium)) { "Medium" } %>
      #
      # @example Block
      #   <%= render(Primer::Beta::Button.new(block: :true)) { "Block" } %>
      #   <%= render(Primer::Beta::Button.new(block: :true, scheme: :primary)) { "Primary block" } %>
      #
      # @example With leading visual
      #   <%= render(Primer::Beta::Button.new) do |c| %>
      #     <% c.with_leading_visual_icon(icon: :star) %>
      #     Button
      #   <% end %>
      #
      # @example With trailing visual
      #   <%= render(Primer::Beta::Button.new) do |c| %>
      #     <% c.with_trailing_visual_counter(count: 15) %>
      #     Button
      #   <% end %>
      #
      # @example With leading and trailing visuals
      #   <%= render(Primer::Beta::Button.new) do |c| %>
      #     <% c.with_leading_visual_icon(icon: :star) %>
      #     <% c.with_trailing_visual_counter(count: 15) %>
      #     Button
      #   <% end %>
      #
      # @example With tooltip
      #   @description
      #     Use tooltips sparingly and as a last resort. Consult the <%= link_to_component(Primer::Alpha::Tooltip) %> documentation for more information.
      #   @code
      #     <%= render(Primer::Beta::Button.new(id: "button-with-tooltip")) do |c| %>
      #       <% c.with_tooltip(text: "Tooltip text") %>
      #       Button
      #     <% end %>
      #
      # @param scheme [Symbol] <%= one_of(Primer::Beta::Button::SCHEME_OPTIONS) %>
      # @param size [Symbol] <%= one_of(Primer::Beta::Button::SIZE_OPTIONS) %>
      # @param full_width [Boolean] Whether button is full-width with `display: block`.
      # @param align_content [Symbol] <%= one_of(Primer::Beta::Button::ALIGN_CONTENT_OPTIONS) %>
      # @param tag [Symbol] (Primer::Beta::BaseButton::DEFAULT_TAG) <%= one_of(Primer::Beta::BaseButton::TAG_OPTIONS) %>
      # @param type [Symbol] (Primer::Beta::BaseButton::DEFAULT_TYPE) <%= one_of(Primer::Beta::BaseButton::TYPE_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        scheme: DEFAULT_SCHEME,
        size: DEFAULT_SIZE,
        full_width: false,
        align_content: DEFAULT_ALIGN_CONTENT,
        **system_arguments
      )
        @scheme = scheme

        @system_arguments = system_arguments

        @id = @system_arguments[:id]

        @align_content_classes = class_names(
          "Button-content",
          system_arguments[:classes],
          ALIGN_CONTENT_MAPPINGS[fetch_or_fallback(ALIGN_CONTENT_OPTIONS, align_content, DEFAULT_ALIGN_CONTENT)]
        )

        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)],
          SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, DEFAULT_SIZE)],
          "Button" => !link?,
          "Button--fullWidth" => full_width
        )
      end

      private

      def link?
        @scheme == LINK_SCHEME
      end

      def trimmed_content
        return if content.blank?

        trimmed_content = content.strip

        return trimmed_content unless content.html_safe?

        # strip unsets `html_safe`, so we have to set it back again to guarantee that HTML blocks won't break
        trimmed_content.html_safe # rubocop:disable Rails/OutputSafety
      end
    end
  end
end
