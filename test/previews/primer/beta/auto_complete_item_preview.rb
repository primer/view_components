# frozen_string_literal: true

module Primer
  module Beta
    # @label AutoCompleteItem
    class AutoCompleteItemPreview < ViewComponent::Preview
      # @label WithDescription
      # @param description_variant select [block, inline]
      # @param selected toggle
      # @param disabled toggle
      # @param value text
      def with_description(description_variant: "block", value: "", selected: false, disabled: false)
        description_variant = description_variant.to_sym

        render_with_template(
          locals: {
            description_variant: description_variant,
            selected: selected,
            disabled: disabled,
            value: value
          }
        )
      end
    end
  end
end
