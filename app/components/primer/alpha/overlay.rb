# frozen_string_literal: true

require "securerandom"

module Primer
  module Alpha
    # An overlay is a flexible floating surface, used to display transient content such as menus, selection options, dialogs, and more.
    class Overlay < Primer::Component
      status :alpha

      DEFAULT_VARIANT_REGULAR = "Overlay-backdrop--center"
      VARIANT_REGULAR_MAPPINGS = {
        DEFAULT_VARIANT_REGULAR => "Overlay-backdrop--center",
        :center => "Overlay-backdrop--center",
        :anchor => "Overlay-backdrop--anchor",
        :side => "Overlay-backdrop--side",
        :full => "Overlay-backdrop--full",
        nil => ""
      }.freeze
      VARIANT_REGULAR_OPTIONS = VARIANT_REGULAR_MAPPINGS.keys

      DEFAULT_VARIANT_NARROW = "Overlay-backdrop--center-whenNarrow"
      VARIANT_NARROW_MAPPINGS = {
        DEFAULT_VARIANT_NARROW => "Overlay-backdrop--center-whenNarrow",
        :center => "Overlay-backdrop--center-whenNarrow",
        :anchor => "Overlay-backdrop--anchor-whenNarrow",
        :side => "Overlay-backdrop--side-whenNarrow",
        :full => "Overlay-backdrop--full-whenNarrow",
        nil => ""
      }.freeze
      VARIANT_NARROW_OPTIONS = VARIANT_NARROW_MAPPINGS.keys

      DEFAULT_PLACEMENT_REGULAR = nil
      PLACEMENT_REGULAR_MAPPINGS = {
        DEFAULT_PLACEMENT_REGULAR => nil,
        :left => "Overlay-backdrop--placement-left",
        :right => "Overlay-backdrop--placement-right",
        :top => "Overlay-backdrop--placement-top",
        :bottom => "Overlay-backdrop--placement-bottom"
      }.freeze
      PLACEMENT_REGULAR_OPTIONS = PLACEMENT_REGULAR_MAPPINGS.keys

      DEFAULT_PLACEMENT_NARROW = nil
      PLACEMENT_NARROW_MAPPINGS = {
        DEFAULT_PLACEMENT_NARROW => nil,
        :left => "Overlay-backdrop--placement-left-whenNarrow",
        :right => "Overlay-backdrop--placement-right-whenNarrow",
        :top => "Overlay-backdrop--placement-top-whenNarrow",
        :bottom => "Overlay-backdrop--placement-bottom-whenNarrow"
      }.freeze
      PLACEMENT_NARROW_OPTIONS = PLACEMENT_NARROW_MAPPINGS.keys

      DEFAULT_FOOTER_CONTENT_ALIGN = :end
      FOOTER_CONTENT_ALIGN_MAPPINGS = {
        :start => "Overlay-footer--alignStart",
        :center => "Overlay-footer--alignCenter",
        :end => "Overlay-footer--alignEnd",
        DEFAULT_FOOTER_CONTENT_ALIGN => "Overlay-footer--alignEnd"
      }.freeze
      FOOTER_CONTENT_ALIGN_OPTIONS = FOOTER_CONTENT_ALIGN_MAPPINGS.keys

      DEFAULT_HEADER_VARIANT = :medium
      HEADER_VARIANT_MAPPINGS = {
        DEFAULT_HEADER_VARIANT => "",
        :large => "Overlay-header--large"
      }.freeze
      HEADER_VARIANT_OPTIONS = HEADER_VARIANT_MAPPINGS.keys

      DEFAULT_BODY_PADDING_VARIANT = :normal
      BODY_PADDING_VARIANT_MAPPINGS = {
        DEFAULT_BODY_PADDING_VARIANT => "",
        :condensed => "Overlay-body--paddingCondensed",
        :none => "Overlay-body--paddingNone"
      }.freeze
      BODY_PADDING_VARIANT_OPTIONS = BODY_PADDING_VARIANT_MAPPINGS.keys

      DEFAULT_HEIGHT = :auto
      HEIGHT_MAPPINGS = {
        DEFAULT_HEIGHT => "Overlay--height-auto",
        :xsmall => "Overlay--height-xsmall",
        :small => "Overlay--height-small",
        :medium => "Overlay--height-medium",
        :large => "Overlay--height-large",
        :xlarge => "Overlay--height-xlarge"
      }.freeze
      HEIGHT_OPTIONS = HEIGHT_MAPPINGS.keys

      DEFAULT_WIDTH = :medium
      WIDTH_MAPPINGS = {
        :auto => "Overlay--width-auto",
        :small => "Overlay--width-small",
        DEFAULT_WIDTH => "Overlay--width-medium",
        :large => "Overlay--width-large",
        :xlarge => "Overlay--width-xlarge",
        :xxlarge => "Overlay--width-xxlarge"
      }.freeze
      WIDTH_OPTIONS = WIDTH_MAPPINGS.keys

      DEFAULT_MOTION = :scale_fade
      MOTION_MAPPINGS = {
        DEFAULT_MOTION => "Overlay--motion-scaleFade",
        :none => ""
      }.freeze
      MOTION_OPTIONS = MOTION_MAPPINGS.keys

      # Optional list of buttons to be rendered in the footer.
      #
      # @param system_arguments [Hash] The same arguments as <%= link_to_component(Primer::ButtonComponent) %>.
      renders_many :footer_buttons, lambda { |**system_arguments|
        Primer::ButtonComponent.new(**system_arguments)
      }

      # Optional button to open the overlay.
      #
      # @param system_arguments [Hash] The same arguments as <%= link_to_component(Primer::ButtonComponent) %>.
      renders_one :show_trigger_button, lambda { |**system_arguments|
        system_arguments[:classes] = class_names(
          system_arguments[:classes]
        )
        system_arguments[:id] = "overlay-show-#{@system_arguments[:id]}"
        system_arguments["data-show-overlay-id"] = @system_arguments[:id]
        Primer::ButtonComponent.new(**system_arguments)
      }

      # Required body content.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :body, lambda { |**system_arguments|
        deny_tag_argument(**system_arguments)
        system_arguments[:tag] = :div

        system_arguments[:classes] = class_names(
          system_arguments[:classes]
        )
        Primer::BaseComponent.new(**system_arguments)
      }

      # @example Overlay without footer content
      #
      #   @description
      #     If the tooltip content provides supplementary description, set `type: :description` to establish an `aria-describedby` relationship.
      #     The trigger element should also have a _concise_ accessible label via `aria-label`.
      #
      #   @code
      #     <%= render(Primer::Alpha::Overlay.new(
      #       title: "This is the tile of the overla",
      #       description: "This is the description of the overlay",
      #       overlay_id: "overlay-without-footer",
      #       variant: { narrow: :full, regular: :center },
      #     )) do |c| %>
      #       <% c.show_trigger_button { "Open overlay" } %>
      #       <% c.body do %>
      #         <p>The body of the overlay</p>
      #       <% end %>
      #     <% end %>
      #
      # @param title [String] The title of the overlay.
      # @param description [String] The optional description of the overlay.
      # @param overlay_id [String] The optional ID of the overlay, defaults to random string.
      # @param show_header_divider [Boolean] Whether to show the header divider.
      # @param show_footer_divider [Boolean] Whether to show the footer divider.
      # @param show_close_button [Boolean] Whether to show the close button.
      # @param footer_content_align [Symbol] The alignment of the footer content.
      # @param header_variant [Symbol] Header content sizing.
      # @param body_padding_variant [Symbol] Body content padding.
      # @param motion [Symbol] Animation options.
      # @param variant [Symbol] Set position for narrow and regular screens.
      # @param placement [Symbol] Optional: set placement for narrow and regular screens.
      def initialize(
        title: nil, description: nil,
        overlay_id: "overlay-#{SecureRandom.hex(4)}",
        show_header_divider: true,
        show_footer_divider: true,
        show_close_button: false,
        overlay_hidden: false,
        width: DEFAULT_WIDTH,
        height: DEFAULT_HEIGHT,
        placement_regular: DEFAULT_PLACEMENT_REGULAR,
        placement_narrow: DEFAULT_PLACEMENT_NARROW,
        footer_content_align: DEFAULT_FOOTER_CONTENT_ALIGN,
        header_variant: DEFAULT_HEADER_VARIANT,
        body_padding_variant: DEFAULT_BODY_PADDING_VARIANT,
        motion: DEFAULT_MOTION,
        variant: { narrow: DEFAULT_VARIANT_NARROW, regular: DEFAULT_VARIANT_REGULAR },
        placement: { narrow: DEFAULT_PLACEMENT_NARROW, regular: DEFAULT_PLACEMENT_REGULAR },
        **system_arguments
      )
        @system_arguments = deny_tag_argument(**system_arguments)

        @system_arguments[:tag] = "div"
        # make this generic
        @system_arguments[:role] = :dialog

        @show_header_divider = show_header_divider
        @show_footer_divider = show_footer_divider
        @show_close_button = show_close_button
        @overlay_hidden = overlay_hidden
        @width = width
        @height = height
        @placement_regular = placement_regular
        @placement_narrow = placement_narrow
        @footer_content_align = footer_content_align
        @header_variant = header_variant
        @body_padding_variant = body_padding_variant
        @motion = motion
        @variant = variant
        @placement = placement

        @title = title
        @description = description
        @system_arguments[:id] = overlay_id.to_s

        @header_id = "#{overlay_id}-header"

        @backdrop_classes = class_names(
          VARIANT_REGULAR_MAPPINGS[fetch_or_fallback(VARIANT_REGULAR_OPTIONS, variant[:regular], DEFAULT_VARIANT_REGULAR)],
          VARIANT_NARROW_MAPPINGS[fetch_or_fallback(VARIANT_NARROW_OPTIONS, variant[:narrow], DEFAULT_VARIANT_NARROW)],
          PLACEMENT_REGULAR_MAPPINGS[fetch_or_fallback(PLACEMENT_REGULAR_OPTIONS, placement[:regular], DEFAULT_PLACEMENT_REGULAR)],
          PLACEMENT_NARROW_MAPPINGS[fetch_or_fallback(PLACEMENT_NARROW_OPTIONS, placement[:narrow], DEFAULT_PLACEMENT_NARROW)],
          "Overlay-visibilityHidden": overlay_hidden
        )

        @header_classes = class_names(
          HEADER_VARIANT_MAPPINGS[fetch_or_fallback(HEADER_VARIANT_OPTIONS, header_variant, DEFAULT_HEADER_VARIANT)],
          "Overlay-header--divided": show_header_divider
        )

        @body_classes = class_names(
          BODY_PADDING_VARIANT_MAPPINGS[fetch_or_fallback(BODY_PADDING_VARIANT_OPTIONS, body_padding_variant, DEFAULT_BODY_PADDING_VARIANT)]
        )

        @footer_classes = class_names(
          FOOTER_CONTENT_ALIGN_MAPPINGS[fetch_or_fallback(FOOTER_CONTENT_ALIGN_OPTIONS, footer_content_align, DEFAULT_FOOTER_CONTENT_ALIGN)],
          "Overlay-footer--divided": show_footer_divider
        )

        @system_arguments[:classes] = class_names(
          "Overlay",
          "Overlay-whenNarrow",
          WIDTH_MAPPINGS[fetch_or_fallback(WIDTH_OPTIONS, width, DEFAULT_WIDTH)],
          HEIGHT_MAPPINGS[fetch_or_fallback(HEIGHT_OPTIONS, height, DEFAULT_HEIGHT)],
          MOTION_MAPPINGS[fetch_or_fallback(MOTION_OPTIONS, motion, DEFAULT_MOTION)],
          system_arguments[:classes]
        )

        if @description.present?
          @description_id = "#{overlay_id}-description"
          @system_arguments[:aria] = { modal: true, labelledby: @header_id, describedby: @description_id }
        else
          @system_arguments[:aria] = { modal: true, labelledby: @header_id }
        end
      end

      def find_narrow_variant
        narrow_variant = variant[:narrow] || :center

        case narrow_variant
        when :center
          %w[Overlay-backdrop--center-whenNarrow]
        when :anchor
          %w[Overlay-backdrop--anchor-whenNarrow]
        when :side
          %w[Overlay-backdrop--side-whenNarrow]
        when :full
          %w[Overlay-backdrop--full-whenNarrow]

        else
          raise ArgumentError, "invalid narrow variant"
        end
      end

      def find_regular_variant
        regular_variant = @variant[:regular] || nil

        case regular_variant
        when :center
          %w[Overlay-backdrop--center-whenNarrow]
        when :anchor
          %w[Overlay-backdrop--anchor-whenNarrow]
        when :side
          %w[Overlay-backdrop--side-whenNarrow]
        when :full
          %w[Overlay-backdrop--full-whenNarrow]

        else
          raise ArgumentError, "invalid regular variant"
        end
      end

      def find_narrow_position
        narrow_position = @position[:narrow] || nil

        case narrow_position
        when :left
          %w[Overlay-backdrop--placement-left-whenNarrow]
        when :right
          %w[Overlay-backdrop--placement-right-whenNarrow]
        when :top
          %w[Overlay-backdrop--placement-top-whenNarrow]
        when :bottom
          %w[Overlay-backdrop--placement-bottom-whenNarrow]

        else
          raise ArgumentError, "invalid narrow position"
        end
      end

      def find_regular_position
        regular_position = @position[:regular] || nil

        case regular_position
        when :left
          %w[Overlay-backdrop--placement-left]
        when :right
          %w[Overlay-backdrop--placement-right]
        when :top
          %w[Overlay-backdrop--placement-top]
        when :bottom
          %w[Overlay-backdrop--placement-bottom]

        else
          raise ArgumentError, "invalid regular position"
        end
      end
    end
  end
end
