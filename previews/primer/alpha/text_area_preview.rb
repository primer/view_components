# frozen_string_literal: true

module Primer
  module Alpha
    # @label TextArea
    class TextAreaPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param name text
      # @param id text
      # @param label text
      # @param caption text
      # @param required toggle
      # @param visually_hide_label toggle
      # @param size [Symbol] select [small, medium, large]
      # @param full_width toggle
      # @param disabled toggle
      # @param invalid toggle
      # @param validation_message text
      def playground(
        name: "my-text-area",
        id: "my-text-area",
        label: "Tell me about yourself",
        caption: "You can trust me, I'm a website",
        required: false,
        visually_hide_label: false,
        size: Primer::Forms::Dsl::Input::DEFAULT_SIZE.to_s,
        full_width: false,
        disabled: false,
        invalid: false,
        validation_message: nil
      )
        system_arguments = {
          name: name,
          id: id,
          label: label,
          caption: caption,
          required: required,
          visually_hide_label: visually_hide_label,
          size: size,
          full_width: full_width,
          disabled: disabled,
          invalid: invalid,
          validation_message: validation_message
        }

        render(Primer::Alpha::TextArea.new(**system_arguments))
      end

      # @label Default
      def default
        render(Primer::Alpha::TextArea.new(name: "my-text-area", label: "Tell me about yourself"))
      end

      # @!group Options
      #
      # @label With caption
      def with_caption
        render(Primer::Alpha::TextArea.new(caption: "With a caption", name: "my-text-area", label: "Tell me about yourself"))
      end

      # @label Visually hidden label
      def visually_hide_label
        render(Primer::Alpha::TextArea.new(visually_hide_label: true, name: "my-text-area", label: "Tell me about yourself"))
      end

      # @label Full width
      def full_width
        render(Primer::Alpha::TextArea.new(full_width: true, name: "my-text-area", label: "Tell me about yourself"))
      end

      # @label Disabled
      def disabled
        render(Primer::Alpha::TextArea.new(disabled: true, name: "my-text-area", label: "Tell me about yourself"))
      end

      # @label Invalid
      def invalid
        render(Primer::Alpha::TextArea.new(invalid: true, name: "my-text-area", label: "Tell me about yourself"))
      end

      # @label With validation message
      def with_validation_message
        render(Primer::Alpha::TextArea.new(validation_message: "An error occurred!", name: "my-text-area", label: "Tell me about yourself"))
      end
      #
      # @!endgroup
    end
  end
end
