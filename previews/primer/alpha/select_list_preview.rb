# frozen_string_literal: true

module Primer
  module Alpha
    # @label SelectList
    class SelectListPreview < ViewComponent::Preview
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
        name: "my-select-list",
        id: "my-select-list",
        label: "Favorite place to visit",
        caption: "They're all good",
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

        render(Primer::Alpha::SelectList.new(**system_arguments)) do |c|
          c.option(label: "Lopez Island", value: "lopez")
          c.option(label: "Shaw Island", value: "shaw")
          c.option(label: "Orcas Island", value: "orcas")
          c.option(label: "San Juan Island", value: "san_juan")
        end
      end
    end
  end
end
