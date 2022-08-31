# frozen_string_literal: true

module Primer
  module Alpha
    # @label Dialog
    class DialogPreview < ViewComponent::Preview
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
    end
  end
end
