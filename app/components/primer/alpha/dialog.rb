# frozen_string_literal: true

require "securerandom"

module Primer
  module Alpha
    # A `Dialog` is a window overlaid on either the primary window or another dialog window.
    # Dialogs are used to display information and to request action confirmation, like delete a discussion or transfer an issue to another repository.
    #
    # @accessibility
    #   - **Dialog Accessible Name**: A dialog should have an accessible name, so screen readers are aware of the purpose of the dialog when it opens.
    #   Give an accessible name setting `:title`. The accessible name will be used as the main heading inside the dialog.
    #   - **Dialog unique id**: A dialog should be unique. Give a unique id setting `:dialog_id`. If no `:dialog_id` is given, a default randomize hex id is generated.
    #
    #   The combination of both `:title` and `:dialog_id` establishes an `aria-labelledby` relationship between the title and the unique id of the dialog.
    class Dialog < Primer::Component
      DEFAULT_POSITION = :center
      POSITION_MAPPINGS = {
        :none => "",
        DEFAULT_POSITION => "Overlay-backdrop--positionCenter",
        :bottom => "Overlay-backdrop--positionBottom"
      }.freeze
      POSITION_OPTIONS = POSITION_MAPPINGS.keys

      DEFAULT_POSITION_NARROW = :inherit
      POSITION_NARROW_MAPPINGS = {
        DEFAULT_POSITION_NARROW => "",
        :fullscreen => "Overlay-backdrop-positionWhenNarrow-fullScreen",
        :bottom => "Overlay-backdrop-positionWhenNarrow-bottomSheet"
      }.freeze
      POSITION_NARROW_OPTIONS = POSITION_NARROW_MAPPINGS.keys

      DEFAULT_FOOTER_CONTENT_ALIGN = :end
      FOOTER_CONTENT_ALIGN_MAPPINGS = {
        :start => "Overlay-footer--alignStart",
        :center => "Overlay-footer--alignCenter",
        :medium => "Overlay--height-medium",
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

      # Optional list of buttons to be rendered.
      #
      # @param system_arguments [Hash] The same arguments as <%= link_to_component(Primer::ButtonComponent) %>.
      renders_many :buttons, lambda { |**system_arguments|
        Primer::ButtonComponent.new(**system_arguments)
      }

      # Optional button to open the dialog.
      #
      # @param system_arguments [Hash] The same arguments as <%= link_to_component(Primer::ButtonComponent) %>.
      renders_one :show_button, lambda { |**system_arguments|
        system_arguments[:classes] = class_names(
          system_arguments[:classes]
        )
        system_arguments[:id] = "dialog-show-#{@system_arguments[:id]}"
        system_arguments["data-show-dialog-id"] = @system_arguments[:id]
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

      # @example Dialog without buttons
      #   @description
      #     If the tooltip content provides supplementary description, set `type: :description` to establish an `aria-describedby` relationship.
      #     The trigger element should also have a _concise_ accessible label via `aria-label`.
      #   @code
      #     <%= render(Primer::Alpha::Dialog.new(
      #       title: "This is the tile of the dialog",
      #       description: "This is the description of the dialog",
      #       dialog_id: "dialog-without-buttons"
      #     )) do |c| %>
      #       <% c.show_button { "Show dialog" } %>
      #       <% c.body do %>
      #         <p>The body of the dialog</p>
      #       <% end %>
      #     <% end %>
      #
      # @example Dialog with buttons
      #   @description
      #     If the tooltip content provides supplementary description, set `type: :description` to establish an `aria-describedby` relationship.
      #     The trigger element should also have a _concise_ accessible label via `aria-label`.
      #   @code
      #     <%= render(Primer::Alpha::Dialog.new(
      #       title: "Title",
      #       description: "Description",
      #       dialog_id: "dialog-with-buttons"
      #     )) do |c| %>
      #       <% c.show_button { "Show dialog" } %>
      #       <% c.button { "Button 1" } %>
      #       <% c.button { "Button 1" } %>
      #       <% c.button { "Button 2" } %>
      #       <% c.body do %>
      #         <p>The body of the dialog</p>
      #       <% end %>
      #     <% end %>
      #
      # @param title [String] The title of the dialog.
      # @param description [String] The optional description of the dialog.
      # @param dialog_id [String] The optional ID of the dialog, defaults to random string.
      # @param form_url [String] The optional URL to submit the form to, form rendered when set.
      # @param form_method [Symbol] The optional form method, defaults to :post.
      # @param form_classes [String] The optional form classes, defaults to nil, format with space: "class-a class-b".
      # @param form_id [String] The optional form id, defaults to nil.
      # @param show_header_divider [Boolean] Whether to show the header divider.
      # @param show_footer_divider [Boolean] Whether to show the footer divider.
      # @param width [Symbol] The width of the dialog. <%= one_of(Primer::Alpha::Dialog::WIDTH_OPTIONS) %>
      # @param height: [Symbol] The height of the dialog. <%= one_of(Primer::Alpha::Dialog::HEIGHT_OPTIONS) %>
      # @param position [Symbol] The position of the dialog. <%= one_of(Primer::Alpha::Dialog::POSITION_OPTIONS) %>
      # @param position_narrow [Symbol] The position of the dialog when narrow. <%= one_of(Primer::Alpha::Dialog::POSITION_NARROW_OPTIONS) %>
      # @param footer_content_align [Symbol] The alignment of the footer content. <%= one_of(Primer::Alpha::Dialog::FOOTER_CONTENT_ALIGN_OPTIONS) %>
      # @param header_variant [Symbol] The variant of the header. <%= one_of(Primer::Alpha::Dialog::HEADER_VARIANT_OPTIONS) %>
      # @param body_padding_variant [Symbol] The padding variant of the dialog body. <%= one_of(Primer::Alpha::Dialog::BODY_PADDING_VARIANT_OPTIONS) %>
      # @param motion [Symbol] The motion of the dialog. <%= one_of(Primer::Alpha::Dialog::MOTION_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        title:, description: nil,
        dialog_id: "dialog-#{SecureRandom.hex(4)}",
        form_url: nil,
        form_method: :post,
        form_classes: nil,
        form_id: nil,
        show_header_divider: true,
        show_footer_divider: true,
        width: DEFAULT_WIDTH,
        height: DEFAULT_HEIGHT,
        position: DEFAULT_POSITION,
        position_narrow: DEFAULT_POSITION_NARROW,
        footer_content_align: DEFAULT_FOOTER_CONTENT_ALIGN,
        header_variant: DEFAULT_HEADER_VARIANT,
        body_padding_variant: DEFAULT_BODY_PADDING_VARIANT,
        motion: DEFAULT_MOTION,
        **system_arguments
      )
        @system_arguments = deny_tag_argument(**system_arguments)

        @system_arguments[:tag] = "modal-dialog"
        @system_arguments[:role] = :dialog

        @show_header_divider = show_header_divider
        @show_footer_divider = show_footer_divider
        @width = width
        @height = height
        @position = position
        @position_narrow = position_narrow
        @footer_content_align = footer_content_align
        @header_variant = header_variant
        @body_padding_variant = body_padding_variant
        @motion = motion

        @form_url = form_url
        @form_method = form_method
        @form_classes = form_classes
        @form_id = form_id

        @title = title
        @description = description
        @system_arguments[:id] = dialog_id.to_s

        @header_id = "#{dialog_id}-header"

        @backdrop_classes = class_names(
          POSITION_MAPPINGS[fetch_or_fallback(POSITION_OPTIONS, position, DEFAULT_POSITION)],
          POSITION_NARROW_MAPPINGS[fetch_or_fallback(POSITION_NARROW_MAPPINGS, position_narrow, DEFAULT_POSITION_NARROW)]
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
          WIDTH_MAPPINGS[fetch_or_fallback(WIDTH_OPTIONS, width, DEFAULT_WIDTH)],
          HEIGHT_MAPPINGS[fetch_or_fallback(HEIGHT_OPTIONS, height, DEFAULT_HEIGHT)],
          MOTION_MAPPINGS[fetch_or_fallback(MOTION_OPTIONS, motion, DEFAULT_MOTION)],
          system_arguments[:classes]
        )

        if @description.present?
          @description_id = "#{dialog_id}-description"
          @system_arguments[:aria] = { modal: true, labelledby: @header_id, describedby: @description_id }
        else
          @system_arguments[:aria] = { modal: true, labelledby: @header_id }
        end
      end

      def render_form
        if @form_url.present?
          form_tag @form_url, method: @form_method, class: "#{@form_classes}", id: @form_id do
            yield
          end
        else
          yield
        end
      end
    end
  end
end
