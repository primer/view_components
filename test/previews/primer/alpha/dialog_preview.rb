# frozen_string_literal: true

module Primer
  module Alpha
    # @label Dialog
    class DialogPreview < ViewComponent::Preview
      # @label Default options
      #
      # @param title [String] text
      # @param subtitle [String] text
      # @param button_text [String] text
      # @param width [Symbol] select [small, medium, large, xlarge, xxlarge]
      # @param height [Symbol] select [small, auto, large, xlarge]
      def default(title: "Test Dialog", subtitle: nil, width: :medium, height: :auto, button_text: "Show Dialog")
        render(Primer::Alpha::Dialog.new(title: title, width: width, height: height, subtitle: subtitle)) do |d|
            d.show_button { button_text }
            d.body { "Content" }
        end
      end

     # @label With Footer
     #
     # @param title [String] text
     # @param subtitle [String] text
     # @param button_text [String] text
     # @param width [Symbol] select [small, medium, large, xlarge, xxlarge]
     # @param height [Symbol] select [small, auto, large, xlarge]
     def with_footer(title: "Test Dialog", subtitle: nil, width: :medium, height: :auto, button_text: "Show Dialog")
       render_with_template(locals: {
         title: title,
         subtitle: subtitle,
         width: width,
         height: height,
         button_text: button_text
       })
     end

      # @label With a Form
      #
      # @param title [String] text
      # @param subtitle [String] text
      # @param button_text [String] text
      # @param width [Symbol] select [small, medium, large, xlarge, xxlarge]
      # @param height [Symbol] select [small, auto, large, xlarge]
      def with_form(title: "Test Dialog", subtitle: nil, width: :medium, height: :auto, button_text: "Show Dialog")
       render_with_template(locals: {
         title: title,
         subtitle: subtitle,
         width: width,
         height: height,
         button_text: button_text
       })
      end
    end
  end
end

