# frozen_string_literal: true

module Primer
  module Alpha
    # @label CheckBox
    class CheckBoxPreview < ViewComponent::Preview
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
        name: "my-check-box",
        id: nil,
        value: "picard",
        label: "Jean-Luc Picard",
        caption: "Make it so",
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

        render(Primer::Alpha::CheckBox.new(**system_arguments))
      end

      # @label Default
      def default
        render(Primer::Alpha::CheckBox.new(name: "my-check-box", label: "Jean-Luc Picard"))
      end

      # @!group Options
      #
      # @label With caption
      def with_caption
        render(Primer::Alpha::CheckBox.new(caption: "With a caption", name: "my-check-box1", label: "Jean-Luc Picard"))
      end

      # @label Visually hidden label
      def visually_hide_label
        render(Primer::Alpha::CheckBox.new(visually_hide_label: true, name: "my-check-box2", label: "Jean-Luc Picard"))
      end

      # @label Full width
      def full_width
        render(Primer::Alpha::CheckBox.new(full_width: true, name: "my-check-box3", label: "Jean-Luc Picard"))
      end

      # @label Disabled
      def disabled
        render(Primer::Alpha::CheckBox.new(disabled: true, name: "my-check-box4", label: "Jean-Luc Picard"))
      end
      #
      # @!endgroup
    end
  end
end
