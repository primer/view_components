# frozen_string_literal: true

module Primer
  module Alpha
    # @label RadioButton
    class RadioButtonPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param name text
      # @param value text
      # @param label text
      # @param caption text
      # @param visually_hide_label toggle
      # @param disabled toggle
      def playground(
        name: "my-radio-button",
        value: "bsg",
        label: "Battlestar Galactica",
        caption: "A pretty good show",
        visually_hide_label: false,
        disabled: false
      )
        system_arguments = {
          name: name,
          value: value,
          label: label,
          caption: caption,
          visually_hide_label: visually_hide_label,
          disabled: disabled
        }

        render(Primer::Alpha::RadioButton.new(**system_arguments))
      end

      # @label Default
      # @snapshot
      def default
        render(Primer::Alpha::RadioButton.new(name: "my-radio-button", label: "Battlestar Galactica", value: "bsg"))
      end

      # @!group Options
      #
      # @label With caption
      # @snapshot
      def with_caption
        render(Primer::Alpha::RadioButton.new(caption: "With a caption", name: "my-radio-button", label: "Battlestar Galactica", value: "bsg1"))
      end

      # @label Checked
      # @snapshot
      def checked
        render(Primer::Alpha::RadioButton.new(name: "my-radio-button", label: "Battlestar Galactica", value: "bsg2", checked: true))
      end

      # @label Visually hidden label
      # @snapshot
      def visually_hide_label
        render(Primer::Alpha::RadioButton.new(visually_hide_label: true, name: "my-radio-button", label: "Battlestar Galactica", value: "bsg2"))
      end

      # @label Disabled
      # @snapshot
      def disabled
        render(Primer::Alpha::RadioButton.new(disabled: true, name: "my-radio-button", label: "Battlestar Galactica", value: "bsg4"))
      end
      #
      # @!endgroup
    end
  end
end
