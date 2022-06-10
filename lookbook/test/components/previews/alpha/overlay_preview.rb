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
    # @param variant_narrow select [center, anchor, side, full]
    # @param variant_regular select [center, anchor, side, full]
    # @param placement_narrow [Symbol] select [[Left, left], [Right, right], [Top, top], [Bottom, bottom], [Unset, unset]]
    # @param placement_regular [Symbol] select [[Left, left], [Right, right], [Top, top], [Bottom, bottom], [Unset, unset]]
    # @param open toggle
    def playground(title: "Overlay title", description: "This is the description of the dialog", overlay_id: "dialog-without-buttons", show_header_divider: false, show_footer_divider: false, show_close_button: true, footer_content_align: :end, header_variant: :medium, body_padding_variant: :normal, motion: :scale_fade, variant_narrow: :full, variant_regular: :center, placement_narrow: :unset, placement_regular: :unset, open: true)
      render(Primer::Alpha::Overlay.new(open: open, title: title, description: description, overlay_id: overlay_id, show_header_divider: show_header_divider, show_footer_divider: show_footer_divider, show_close_button: show_close_button, footer_content_align: footer_content_align, header_variant: header_variant, body_padding_variant: body_padding_variant, motion: motion, variant: { narrow: variant_narrow, regular: variant_regular }, placement: { narrow: placement_narrow == :unset ? nil : placement_narrow, regular: placement_regular == :unset ? nil : placement_regular })) do |c|
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
                             motion: motion
                           })
    end
  end
end
