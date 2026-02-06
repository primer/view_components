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
      # @param full_width toggle
      # @param disabled toggle
      # @param invalid toggle
      # @param validation_message text
      # @param character_limit number
      def playground(
        name: "my-text-area",
        id: "my-text-area",
        label: "Tell me about yourself",
        caption: "You can trust me, I'm a website",
        required: false,
        visually_hide_label: false,
        full_width: true,
        disabled: false,
        invalid: false,
        validation_message: nil,
        character_limit: nil
      )
        system_arguments = {
          name: name,
          id: id,
          label: label,
          caption: caption,
          required: required,
          visually_hide_label: visually_hide_label,
          full_width: full_width,
          disabled: disabled,
          invalid: invalid,
          validation_message: validation_message,
          character_limit: character_limit
        }

        render(Primer::Alpha::TextArea.new(**system_arguments))
      end

      # @label Default
      # @snapshot
      def default
        render(Primer::Alpha::TextArea.new(id: "my-text-area-default", name: "my-text-area-default", label: "Tell me about yourself"))
      end

      # @!group Options
      #
      # @label With caption
      # @snapshot
      def with_caption
        render(Primer::Alpha::TextArea.new(id: "my-text-area-with-caption", name: "my-text-area-with-caption", caption: "With a caption", label: "Tell me about yourself"))
      end

      # @label Visually hidden label
      # @snapshot
      def visually_hide_label
        render(Primer::Alpha::TextArea.new(id: "my-text-area-visually-hide-label", name: "my-text-area-visually-hide-label", visually_hide_label: true, label: "Tell me about yourself"))
      end

      # @label Full width
      # @snapshot
      def full_width
        render(Primer::Alpha::TextArea.new(id: "my-text-area-full-width", name: "my-text-area-full-width", full_width: true, label: "Tell me about yourself"))
      end

      # @label Not full width
      # @snapshot
      def not_full_width
        render(Primer::Alpha::TextArea.new(id: "my-text-area-not-full-width", name: "my-text-area-not-full-width", full_width: false, label: "Tell me about yourself"))
      end

      # @label Disabled
      # @snapshot
      def disabled
        render(Primer::Alpha::TextArea.new(id: "my-text-area-disabled", name: "my-text-area-disabled", disabled: true, label: "Tell me about yourself"))
      end

      # @label Invalid
      # @snapshot
      def invalid
        render(Primer::Alpha::TextArea.new(id: "my-text-area-invalid", name: "my-text-area-invalid", invalid: true, label: "Tell me about yourself"))
      end

      # @label With validation message
      # @snapshot
      def with_validation_message
        render(Primer::Alpha::TextArea.new(id: "my-text-area-with-validation-message", name: "my-text-area-with-validation-message", validation_message: "An error occurred!", label: "Tell me about yourself"))
      end

      # @label With character limit
      # @snapshot interactive
      def with_character_limit
        render(Primer::Alpha::TextArea.new(id: "my-text-area-with-character-limit", name: "my-text-area-with-character-limit", character_limit: 10, label: "Tell me about yourself"))
      end

      # @label With character limit, over limit
      # @snapshot interactive
      def with_character_limit_over_limit
        render(Primer::Alpha::TextArea.new(id: "my-text-area-with-character-limit-over-limit", name: "my-text-area-with-character-limit-over-limit", character_limit: 10, label: "Tell me about yourself", value: "This text is definitely over the limit."))
      end

      # @label With character limit and caption
      # @snapshot
      def with_character_limit_and_caption
        render(Primer::Alpha::TextArea.new(id: "my-text-area-with-character-limit-and-caption", name: "my-text-area-with-character-limit-and-caption", character_limit: 100, caption: "With a caption.", label: "Tell me about yourself"))
      end
      #
      # @!endgroup
    end
  end
end
