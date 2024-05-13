# frozen_string_literal: true

module Primer
  module Alpha
    # @label Dialog
    class DialogPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param title [String] text
      # @param subtitle [String] text
      # @param size [Symbol] select [small, medium, medium_portrait, large, xlarge]
      # @param position [Symbol] select [center, left, right]
      # @param position_narrow [Symbol] select [inherit, bottom, fullscreen, left, right]
      # @param visually_hide_title [Boolean] toggle
      # @param disable_button [Boolean] toggle
      # @param button_text [String] text
      # @param body_text [String] text
      # @param icon [Symbol] octicon
      def playground(title: "Test Dialog", subtitle: nil, size: :medium, button_text: "Show Dialog", body_text: "Content", position: :center, position_narrow: :fullscreen, visually_hide_title: false, icon: nil, disable_button: false)
        render(Primer::Alpha::Dialog.new(title: title, subtitle: subtitle, size: size, position: position, position_narrow: position_narrow, visually_hide_title: visually_hide_title)) do |d|
          if icon.present? && (icon != :none)
            d.with_show_button(icon: icon, "aria-label": icon.to_s, disabled: disable_button)
          else
            d.with_show_button(disabled: disable_button) { button_text }
          end
          d.with_body { body_text }
        end
      end

      # @label Default options
      #
      # @param title [String] text
      # @param subtitle [String] text
      # @param size [Symbol] select [small, medium, medium_portrait, large, xlarge]
      # @param position [Symbol] select [center, left, right]
      # @param position_narrow [Symbol] select [inherit, bottom, fullscreen, left, right]
      # @param visually_hide_title [Boolean] toggle
      # @param button_text [String] text
      # @param body_text [String] text
      # @snapshot interactive
      def default(title: "Test Dialog", subtitle: nil, size: :medium, button_text: "Show Dialog", body_text: "Content", position: :center, position_narrow: :fullscreen, visually_hide_title: false)
        render(Primer::Alpha::Dialog.new(title: title, subtitle: subtitle, size: size, position: position, position_narrow: position_narrow, visually_hide_title: visually_hide_title)) do |d|
          d.with_show_button { button_text }
          d.with_body { body_text }
        end
      end

      # @label Long text
      #
      # @param title [String] text
      # @param subtitle [String] text
      # @param button_text [String] text
      # @param size [Symbol] select [small, medium, medium_portrait, large, xlarge]
      # @param position [Symbol] select [center, left, right]
      # @param position_narrow [Symbol] select [inherit, bottom, fullscreen, left, right]
      def long_text(title: "Test Dialog", subtitle: nil, size: :medium, button_text: "Show Dialog", position: :center, position_narrow: :fullscreen)
        render(Primer::Alpha::Dialog.new(title: title, subtitle: subtitle, size: size, position: position, position_narrow: position_narrow)) do |d|
          d.with_show_button { button_text }
          d.with_body { "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?" }
        end
      end

      # @label With Header
      #
      # @param title [String] text
      # @param subtitle [String] text
      # @param header_variant [Symbol] select [medium, large]
      # @param button_text [String] text
      # @param show_divider [Boolean] toggle
      def with_header(title: "Test Dialog", subtitle: nil, header_variant: :medium, button_text: "Show Dialog", show_divider: true)
        render_with_template(locals: {
                               title: title,
                               subtitle: subtitle,
                               header_variant: header_variant,
                               button_text: button_text,
                               show_divider: show_divider
                             })
      end

      # @label With Footer
      #
      # @param title [String] text
      # @param subtitle [String] text
      # @param button_text [String] text
      # @param show_divider [Boolean] toggle
      def with_footer(title: "Test Dialog", subtitle: nil, button_text: "Show Dialog", show_divider: true)
        render_with_template(locals: {
                               title: title,
                               subtitle: subtitle,
                               button_text: button_text,
                               show_divider: show_divider
                             })
      end

      # @label With a Form
      #
      # @param title [String] text
      # @param subtitle [String] text
      # @param button_text [String] text
      # @param show_divider [Boolean] toggle
      def with_form(title: "Test Dialog", subtitle: nil, button_text: "Show Dialog", show_divider: true)
        render_with_template(locals: {
                               title: title,
                               subtitle: subtitle,
                               button_text: button_text,
                               show_divider: show_divider
                             })
      end

      # @label Custom Header
      #
      # @param title [String] text
      # @param subtitle [String] text
      # @param button_text [String] text
      # @param show_divider [Boolean] toggle
      def custom_header(title: "Test Dialog", subtitle: nil, button_text: "Show Dialog", show_divider: true)
        render_with_template(locals: {
                               title: title,
                               subtitle: subtitle,
                               button_text: button_text,
                               show_divider: show_divider
                             })
      end

      # @label Nested dialog
      #
      # @param title [String] text
      # @param subtitle [String] text
      # @param button_text [String] text
      # @param show_divider [Boolean] toggle
      # @param position [Symbol] select [center, left, right]
      def nested_dialog(title: "Test Dialog", subtitle: nil, position: :center, button_text: "Show Dialog", show_divider: true)
        render_with_template(locals: {
                               title: title,
                               subtitle: subtitle,
                               position: position,
                               button_text: button_text,
                               show_divider: show_divider
                             })
      end

      # @label Dialog with text input
      #
      # @param title [String] text
      # @param subtitle [String] text
      # @param button_text [String] text
      # @param show_divider [Boolean] toggle
      def with_text_input(title: "Test Dialog", subtitle: nil, button_text: "Show Dialog", show_divider: true)
        render_with_template(locals: {
                               title: title,
                               subtitle: subtitle,
                               button_text: button_text,
                               show_divider: show_divider
                             })
      end

      # @label Dialog with AutoComplete text input
      #
      # @param title [String] text
      # @param subtitle [String] text
      # @param button_text [String] text
      # @param show_divider [Boolean] toggle
      # @snapshot interactive
      def with_auto_complete(title: "Test Dialog", subtitle: nil, button_text: "Show Dialog", show_divider: true)
        render_with_template(locals: {
                               title: title,
                               subtitle: subtitle,
                               button_text: button_text,
                               show_divider: show_divider,
                               url: UrlHelpers.autocomplete_index_path
                             })
      end

      # @label Page with scrollbar and dialog
      #
      # @param title [String] text
      # @param subtitle [String] text
      # @param button_text [String] text
      # @param show_divider [Boolean] toggle
      def body_has_scrollbar_overflow(title: "Test Dialog", subtitle: nil, button_text: "Show Dialog", show_divider: true)
        render_with_template(locals: {
                               title: title,
                               subtitle: subtitle,
                               button_text: button_text,
                               show_divider: show_divider
                             })
      end

      # @label Autofocus element with autofocus attribute
      def autofocus_element
        render_with_template(locals: {})
      end

      # @label Left Side
      #
      # @param title [String] text
      # @param subtitle [String] text
      # @param size [Symbol] select [small, medium, medium_portrait, large, xlarge]
      # @param position_narrow [Symbol] select [inherit, bottom, fullscreen, left, right]
      # @param visually_hide_title [Boolean] toggle
      # @param button_text [String] text
      # @param body_text [String] text
      # @snapshot interactive
      def left_side(title: "Test Dialog", subtitle: nil, size: :medium, button_text: "Show Dialog", body_text: "Content", position: :center, position_narrow: :fullscreen, visually_hide_title: false)
        render(Primer::Alpha::Dialog.new(title: title, subtitle: subtitle, size: size, position: :left, position_narrow: position_narrow, visually_hide_title: visually_hide_title)) do |d|
          d.with_show_button { button_text }
          d.with_body { body_text }
        end
      end

      # @label Right Side
      #
      # @param title [String] text
      # @param subtitle [String] text
      # @param size [Symbol] select [small, medium, medium_portrait, large, xlarge]
      # @param position_narrow [Symbol] select [inherit, bottom, fullscreen, left, right]
      # @param visually_hide_title [Boolean] toggle
      # @param button_text [String] text
      # @param body_text [String] text
      # @snapshot interactive
      def right_side(title: "Test Dialog", subtitle: nil, size: :medium, button_text: "Show Dialog", body_text: "Content", position: :center, position_narrow: :fullscreen, visually_hide_title: false)
        render(Primer::Alpha::Dialog.new(title: title, subtitle: subtitle, size: size, position: :right, position_narrow: position_narrow, visually_hide_title: visually_hide_title)) do |d|
          d.with_show_button { button_text }
          d.with_body { body_text }
        end
      end

      # @label Scroll container
      #
      # @param title [String] text
      # @param subtitle [String] text
      # @param size [Symbol] select [small, medium, medium_portrait, large, xlarge]
      # @param position [Symbol] select [center, right, left]
      # @param position_narrow [Symbol] select [inherit, bottom, fullscreen, left, right]
      # @param visually_hide_title [Boolean] toggle
      # @param button_text [String] text
      # @param body_text [String] text
      # @snapshot interactive
      def scroll_container(title: "Test Dialog", subtitle: nil, position: :center, size: :medium, button_text: "Show Dialog", body_text: "Content", position_narrow: :fullscreen, visually_hide_title: false)
        render_with_template(locals: {
                               title: title,
                               subtitle: subtitle,
                               position: position,
                               size: size,
                               button_text: button_text,
                               body_text: body_text,
                               position_narrow: position_narrow,
                               visually_hide_title: visually_hide_title
                             })
      end

      # @label Dialog inside Overlay
      #
      # @param title [String] text
      # @param subtitle [String] text
      # @param size [Symbol] select [small, medium, medium_portrait, large, xlarge]
      # @param position [Symbol] select [center, right, left]
      # @param position_narrow [Symbol] select [inherit, bottom, fullscreen, left, right]
      # @param visually_hide_title [Boolean] toggle
      # @param button_text [String] text
      # @param body_text [String] text
      # @snapshot interactive
      def dialog_inside_overlay(title: "Test Dialog", subtitle: nil, position: :center, size: :medium, button_text: "Show Dialog", body_text: "Content", position_narrow: :fullscreen, visually_hide_title: false)
        render_with_template(locals: {
                               title: title,
                               subtitle: subtitle,
                               position: position,
                               size: size,
                               button_text: button_text,
                               body_text: body_text,
                               position_narrow: position_narrow,
                               visually_hide_title: visually_hide_title
                             })
      end

      # @label Initially Open
      #
      # @param title [String] text
      # @param subtitle [String] text
      # @param size [Symbol] select [small, medium, medium_portrait, large, xlarge]
      # @param position [Symbol] select [center, left, right]
      # @param position_narrow [Symbol] select [inherit, bottom, fullscreen, left, right]
      # @param visually_hide_title [Boolean] toggle
      # @param disable_button [Boolean] toggle
      # @param button_text [String] text
      # @param body_text [String] text
      # @param icon [Symbol] octicon
      # @snapshot interactive
      def initally_open(title: "Test Dialog", subtitle: nil, size: :medium, button_text: "Show Dialog", body_text: "Content", position: :center, position_narrow: :fullscreen, visually_hide_title: false, icon: nil, disable_button: false)
        render(Primer::Alpha::Dialog.new(open: true, title: title, subtitle: subtitle, size: size, position: position, position_narrow: position_narrow, visually_hide_title: visually_hide_title)) do |d|
          if icon.present? && (icon != :none)
            d.with_show_button(icon: icon, "aria-label": icon.to_s, disabled: disable_button)
          else
            d.with_show_button(disabled: disable_button) { button_text }
          end
          d.with_body { body_text }
        end
      end

      def with_header_filter
        render_with_template(locals: {})
      end
    end
  end
end
