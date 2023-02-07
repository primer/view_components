# frozen_string_literal: true

module Primer
  module Alpha
    # @label RadioButton
    class RadioButtonPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param name text
      # @param id text
      # @param value text
      # @param label text
      # @param caption text
      # @param visually_hide_label toggle
      # @param full_width toggle
      # @param disabled toggle
      def playground(
        name: "my-radio-button",
        id: nil,
        value: "bsg",
        label: "Battlestar Galactica",
        caption: "A pretty good show",
        visually_hide_label: false,
        full_width: false,
        disabled: false
      )
        system_arguments = {
          name: name,
          value: value,
          label: label,
          caption: caption,
          visually_hide_label: visually_hide_label,
          full_width: full_width,
          disabled: disabled
        }

        render(Primer::Alpha::RadioButton.new(**system_arguments))
      end

      # @label Default
      def default
        render(Primer::Alpha::RadioButton.new(name: "my-radio-button", label: "Battlestar Galactica", value: "bsg"))
      end

      # @!group Options
      #
      # @label With caption
      def with_caption
        render(Primer::Alpha::RadioButton.new(caption: "With a caption", name: "my-radio-button", label: "Battlestar Galactica", value: "bsg1"))
      end

      # @label Visually hidden label
      def visually_hide_label
        render(Primer::Alpha::RadioButton.new(visually_hide_label: true, name: "my-radio-button", label: "Battlestar Galactica", value: "bsg2"))
      end

      # @label Full width
      def full_width
        render(Primer::Alpha::RadioButton.new(full_width: true, name: "my-radio-button", label: "Battlestar Galactica", value: "bsg3"))
      end

      # @label Disabled
      def disabled
        render(Primer::Alpha::RadioButton.new(disabled: true, name: "my-radio-button", label: "Battlestar Galactica", value: "bsg4"))
      end
      #
      # @!endgroup
    end
  end
end
