# frozen_string_literal: true

module Primer
  module Beta
    # @component Primer::Beta::AutoComplete::Item
    # @label AutoCompleteItem
    class AutoCompleteItemPreview < ViewComponent::Preview
      # @label Playground
      # @param selected toggle
      # @param disabled toggle
      # @param value text
      def playground(value: "", selected: false, disabled: false)
        render_with_template(
          locals: {
            selected: selected,
            disabled: disabled,
            value: value
          }
        )
      end

      # @label Default
      # @param selected toggle
      # @param disabled toggle
      # @param value text
      # @snapshot
      def default(value: "", selected: false, disabled: false)
        render_with_template(
          locals: {
            selected: selected,
            disabled: disabled,
            value: value
          }
        )
      end

      # @label WithDescription
      # @param description_variant select [block, inline]
      # @param selected toggle
      # @param disabled toggle
      # @param value text
      # @snapshot
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
