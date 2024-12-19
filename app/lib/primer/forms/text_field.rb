module Primer
  module Forms
    class TextField < BaseComponent
      delegate :builder, :form, to: :@input

      INPUT_WRAP_SIZE = {
        small: "FormControl-input-wrap--small",
        large: "FormControl-input-wrap--large"
      }.freeze

      def initialize(input:)
        @input = input

        @input.add_input_classes(
          "FormControl-input",
          Primer::Forms::Dsl::Input::SIZE_MAPPINGS[@input.size]
        )

        @field_wrap_arguments = {
          class: class_names(
            "FormControl-input-wrap",
            INPUT_WRAP_SIZE[input.size],
            "FormControl-input-wrap--trailingAction": @input.show_clear_button?,
            "FormControl-input-wrap--trailingVisual": @input.trailing_visual?,
            "FormControl-input-wrap--leadingVisual": @input.leading_visual?
          ),
          hidden: @input.hidden?
        }
      end

      def auto_check_authenticity_token
        return @auto_check_authenticity_token if defined?(@auto_check_authenticity_token)

        @auto_check_authenticity_token =
          if @input.auto_check_src
            @view_context.form_authenticity_token(
              form_options: { method: :post, action: @input.auto_check_src }
            )
          end
      end

      def trailing_visual_render
        visual = @input.trailing_visual
        return unless visual

        content = ActiveSupport::SafeBuffer.new # Use SafeBuffer for safe HTML concatenation

        # Render icon if specified
        content << render(Primer::Beta::Octicon.new(icon: visual[:icon], classes: "FormControl-input-trailingVisualIcon")) if visual[:icon]

        # Render label if specified
        content << render(Primer::Beta::Label.new(classes: "FormControl-input-trailingVisualLabel")) { visual[:label] } if visual[:label]

        # Render counter if specified
        content << render(Primer::Beta::Counter.new(count: visual[:counter], classes: "FormControl-input-trailingVisualCounter")) if visual[:counter]

        # Render text if specified
        content << content_tag(:span, visual[:text], class: "FormControl-input-trailingVisualText") if visual[:text]

        # Wrap in the trailing visual container
        content_tag(:span, content, class: "FormControl-input-trailingVisualWrap")
      end


    end
  end
end
