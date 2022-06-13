# frozen_string_literal: true

module Alpha
  # @label Overlay
  class OverlayPreview < ViewComponent::Preview
    # @label Playground
    #
    # @param title [String] text
    # @param description [String] text
    # @param overlay_id [String] text
    # @param show_header_divider [Boolean] toggle
    # @param show_footer_divider [Boolean] toggle
    # @param show_close_button [Boolean] toggle
    # @param footer_content_align select [start, center, end]
    # @param header_variant select [medium, large]
    # @param body_padding_variant select [normal, condensed, none]
    # @param motion select [scale_fade, none]
    # @param width select [auto, small, medium, large, xlarge, xxlarge]
    # @param height select [auto, xsmall, small, medium, large, xlarge]
    # @param variant_narrow select [center, anchor, side, full]
    # @param variant_regular select [center, anchor, side, full]
    # @param placement_narrow [Symbol] select [[Left, left], [Right, right], [Top, top], [Bottom, bottom], [Unset, unset]]
    # @param placement_regular [Symbol] select [[Left, left], [Right, right], [Top, top], [Bottom, bottom], [Unset, unset]]
    # @param open toggle
    def playground(title: "Overlay title", description: "This is the description of the dialog", overlay_id: "dialog-without-buttons", show_header_divider: false, show_footer_divider: false, show_close_button: true, footer_content_align: :end, header_variant: :medium, body_padding_variant: :normal, motion: :scale_fade, variant_narrow: :full, variant_regular: :center, placement_narrow: :unset, placement_regular: :unset, open: true, width: :medium, height: :auto)
      render(Primer::Alpha::Overlay.new(open: open, title: title, description: description, overlay_id: overlay_id, show_header_divider: show_header_divider, show_footer_divider: show_footer_divider, show_close_button: show_close_button, footer_content_align: footer_content_align, header_variant: header_variant, body_padding_variant: body_padding_variant, motion: motion, width: width, height: height, variant: { narrow: variant_narrow, regular: variant_regular }, placement: { narrow: placement_narrow == :unset ? nil : placement_narrow, regular: placement_regular == :unset ? nil : placement_regular })) do |c|
        c.renderTrigger { "Show dialog!" }
        c.body do
          "The body of the dialog"
        end
        c.footer_button { "Dismiss" }
      end
    end

    # @label Multi layered
    #
    # @param title [String] text
    # @param description [String] text
    # @param overlay_id [String] text
    # @param show_header_divider [Boolean] toggle
    # @param show_footer_divider [Boolean] toggle
    # @param show_close_button [Boolean] toggle
    # @param footer_content_align select [start, center, end]
    # @param header_variant select [medium, large]
    # @param body_padding_variant select [normal, condensed, none]
    # @param motion select [scale_fade, none]
    # @param width select [auto, small, medium, large, xlarge, xxlarge]
    # @param height select [auto, xsmall, small, medium, large, xlarge]
    # @param variant_narrow select [center, anchor, side, full]
    # @param variant_regular select [center, anchor, side, full]
    # @param placement_narrow [Symbol] select [[Left, left], [Right, right], [Top, top], [Bottom, bottom], [Unset, unset]]
    # @param placement_regular [Symbol] select [[Left, left], [Right, right], [Top, top], [Bottom, bottom], [Unset, unset]]
    # @param open toggle
    def multi_layered(
      title: "Overlay title",
      description: "This is the description of the dialog",
      overlay_id: "dialog-without-buttons",
      show_header_divider: false,
      show_footer_divider: false,
      show_close_button: true,
      footer_content_align: :end,
      header_variant: :medium,
      body_padding_variant: :normal,
      motion: :scale_fade,
      width: :medium,
      height: :auto,
      open: true
    )
      render_with_template(locals: {
                             open: open,
                             title: title,
                             description: description,
                             overlay_id: overlay_id,
                             show_header_divider: show_header_divider,
                             show_footer_divider: show_footer_divider,
                             show_close_button: show_close_button,
                             footer_content_align: footer_content_align,
                             header_variant: header_variant,
                             body_padding_variant: body_padding_variant,
                             motion: motion,
                             width: width,
                             height: height
                           })
    end

    # @label Anchored overlay
    #
    # @param title [String] text
    # @param description [String] text
    # @param overlay_id [String] text
    # @param show_header_divider [Boolean] toggle
    # @param show_footer_divider [Boolean] toggle
    # @param show_close_button [Boolean] toggle
    # @param footer_content_align select [start, center, end]
    # @param header_variant select [medium, large]
    # @param body_padding_variant select [normal, condensed, none]
    # @param motion select [scale_fade, none]
    # @param width select [auto, small, medium, large, xlarge, xxlarge]
    # @param height select [auto, xsmall, small, medium, large, xlarge]
    # @param variant_narrow select [center, anchor, side, full]
    # @param variant_regular select [center, anchor, side, full]
    # @param placement_narrow [Symbol] select [[Left, left], [Right, right], [Top, top], [Bottom, bottom], [Unset, unset]]
    # @param placement_regular [Symbol] select [[Left, left], [Right, right], [Top, top], [Bottom, bottom], [Unset, unset]]
    # @param open toggle
    def anchored_overlay(
      title: "Overlay title",
      description: "",
      overlay_id: "anchored-overlay",
      show_header_divider: false,
      show_footer_divider: false,
      show_close_button: true,
      footer_content_align: :end,
      header_variant: :medium,
      body_padding_variant: :normal,
      motion: :scale_fade,
      width: :auto,
      height: :auto,
      variant_narrow: :anchor,
      variant_regular: :anchor,
      placement_narrow: :bottom,
      placement_regular: :bottom
    )
      render(Primer::Alpha::Overlay.new(title: title, description: description, overlay_id: overlay_id, show_header_divider: show_header_divider, show_footer_divider: show_footer_divider, show_close_button: show_close_button, footer_content_align: footer_content_align, header_variant: header_variant, body_padding_variant: body_padding_variant, motion: motion, width: width, height: height, variant: { narrow: variant_narrow, regular: variant_regular }, placement: { narrow: placement_narrow == :unset ? nil : placement_narrow, regular: placement_regular == :unset ? nil : placement_regular })) do |c|
        c.renderTrigger { "Show dialog!" }
        c.body do
          "The body of the dialog"
        end
        c.footer_button { "Dismiss" }
      end
    end
  end
end
