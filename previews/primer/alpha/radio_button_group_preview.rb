# frozen_string_literal: true

module Primer
  module Alpha
    # @label RadioButtonGroup
    class RadioButtonGroupPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param name text
      # @param label text
      # @param caption text
      # @param disabled toggle
      def playground(
        name: "my-radio-group",
        label: "Question: what kind of bear is best?",
        caption: "There are basically two schools of thought",
        disabled: false
      )
        system_arguments = {
          name: name,
          label: label,
          caption: caption,
          disabled: disabled
        }

        render(Primer::Alpha::RadioButtonGroup.new(**system_arguments)) do |component|
          component.radio_button(label: "Bears", value: "bears")
          component.radio_button(label: "Beets", value: "beets")
          component.radio_button(label: "Battlestar Galactica", value: "bsg")
        end
      end

      # @label Default
      # @snapshot
      def default
        render(Primer::Alpha::RadioButtonGroup.new(name: "my-radio-group", label: "Question: what kind of bear is best?")) do |component|
          component.radio_button(label: "Bears", value: "bears")
          component.radio_button(label: "Beets", value: "beets")
          component.radio_button(label: "Battlestar Galactica", value: "bsg")
        end
      end

      # @!group Options
      #
      # @label With caption
      # @snapshot
      def with_caption
        render(Primer::Alpha::RadioButtonGroup.new(caption: "With a caption", name: "my-radio-group", label: "Question: what kind of bear is best?")) do |component|
          component.radio_button(label: "Bears", value: "bears1")
          component.radio_button(label: "Beets", value: "beets1")
          component.radio_button(label: "Battlestar Galactica", value: "bsg1")
        end
      end

      # @label Visually hidden label
      def visually_hide_label
        render(Primer::Alpha::RadioButtonGroup.new(visually_hide_label: true, name: "my-radio-group", label: "Question: what kind of bear is best?")) do |component|
          component.radio_button(label: "Bears", value: "bears2")
          component.radio_button(label: "Beets", value: "beets2")
          component.radio_button(label: "Battlestar Galactica", value: "bsg2")
        end
      end

      # @label Full width
      def full_width
        render(Primer::Alpha::RadioButtonGroup.new(full_width: true, name: "my-radio-group", label: "Question: what kind of bear is best?")) do |component|
          component.radio_button(label: "Bears", value: "bears3")
          component.radio_button(label: "Beets", value: "beets3")
          component.radio_button(label: "Battlestar Galactica", value: "bsg3")
        end
      end

      # @label Disabled
      def disabled
        render(Primer::Alpha::RadioButtonGroup.new(disabled: true, name: "my-radio-group", label: "Question: what kind of bear is best?")) do |component|
          component.radio_button(label: "Bears", value: "bears4")
          component.radio_button(label: "Beets", value: "beets4")
          component.radio_button(label: "Battlestar Galactica", value: "bsg4")
        end
      end
      #
      # @!endgroup
    end
  end
end
