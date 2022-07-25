# frozen_string_literal: true

module Beta
  # @label AutoCompleteItem
  class AutoCompleteItemPreview < ViewComponent::Preview
    # @label WithDescription
    # @param selected toggle
    # @param disabled toggle
    # @param value text
    def with_description(value: "", selected: false, disabled: false)
      render_with_template(locals: {
                             selected: selected,
                             disabled: disabled,
                             value: value
                           })
    end
  end
end
