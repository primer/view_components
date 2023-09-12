# frozen_string_literal: true

module Primer
  module Alpha
    # @label CheckBoxGroup
    class CheckBoxGroupPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param name text
      # @param label text
      # @param caption text
      # @param validation_message text
      # @param disabled toggle
      def playground(
        name: "my-check-group",
        label: "I would go into battle with:",
        caption: "Qa'pla!",
        validation_message: nil,
        disabled: false
      )
        system_arguments = {
          name: name,
          label: label,
          caption: caption,
          validation_message: validation_message,
          disabled: disabled
        }

        render(Primer::Alpha::CheckBoxGroup.new(**system_arguments)) do |component|
          component.check_box(label: "Jean-Luc Picard", value: "picard")
          component.check_box(label: "Hikaru Sulu", value: "sulu")
          component.check_box(label: "Kathryn Janeway", value: "janeway")
          component.check_box(label: "Benjamin Sisko", value: "sisko")
        end
      end

      # @label Default
      def default
        render(Primer::Alpha::CheckBoxGroup.new(name: "my-check-group", label: "I would go into battle with:")) do |component|
          component.check_box(label: "Jean-Luc Picard", value: "picard")
          component.check_box(label: "Hikaru Sulu", value: "sulu")
          component.check_box(label: "Kathryn Janeway", value: "janeway")
          component.check_box(label: "Benjamin Sisko", value: "sisko")
        end
      end

      # @label Invalid
      def invalid
        render(Primer::Alpha::CheckBoxGroup.new(validation_message: "Please choose at least one", name: "my-check-group", label: "I would go into battle with:")) do |component|
          component.check_box(label: "Jean-Luc Picard", value: "picard4")
          component.check_box(label: "Hikaru Sulu", value: "sulu4")
          component.check_box(label: "Kathryn Janeway", value: "janeway4")
          component.check_box(label: "Benjamin Sisko", value: "sisko4")
        end
      end

      # @!group Options
      # @snapshot
      #
      # @label With caption
      def with_caption
        render(Primer::Alpha::CheckBoxGroup.new(caption: "With a caption", name: "my-check-group", label: "I would go into battle with:")) do |component|
          component.check_box(label: "Jean-Luc Picard", value: "picard1")
          component.check_box(label: "Hikaru Sulu", value: "sulu1")
          component.check_box(label: "Kathryn Janeway", value: "janeway1")
          component.check_box(label: "Benjamin Sisko", value: "sisko1")
        end
      end

      # @label Visually hidden label
      def visually_hide_label
        render(Primer::Alpha::CheckBoxGroup.new(visually_hide_label: true, name: "my-check-group", label: "I would go into battle with:")) do |component|
          component.check_box(label: "Jean-Luc Picard", value: "picard2")
          component.check_box(label: "Hikaru Sulu", value: "sulu2")
          component.check_box(label: "Kathryn Janeway", value: "janeway2")
          component.check_box(label: "Benjamin Sisko", value: "sisko2")
        end
      end

      # @label Full width
      def full_width
        render(Primer::Alpha::CheckBoxGroup.new(full_width: true, name: "my-check-group", label: "I would go into battle with:")) do |component|
          component.check_box(label: "Jean-Luc Picard", value: "picard3")
          component.check_box(label: "Hikaru Sulu", value: "sulu3")
          component.check_box(label: "Kathryn Janeway", value: "janeway3")
          component.check_box(label: "Benjamin Sisko", value: "sisko3")
        end
      end

      # @label Disabled
      def disabled
        render(Primer::Alpha::CheckBoxGroup.new(disabled: true, name: "my-check-group", label: "I would go into battle with:")) do |component|
          component.check_box(label: "Jean-Luc Picard", value: "picard4")
          component.check_box(label: "Hikaru Sulu", value: "sulu4")
          component.check_box(label: "Kathryn Janeway", value: "janeway4")
          component.check_box(label: "Benjamin Sisko", value: "sisko4")
        end
      end
      #
      # @!endgroup
    end
  end
end
