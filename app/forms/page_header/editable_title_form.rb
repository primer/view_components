# frozen_string_literal: true

module PageHeader
  # A helper form to be used for editable PageHeaders inside PageHeader::Title
  # It should not be used standalone
  class EditableTitleForm < ApplicationForm
    form do |query_form|
      query_form.group(layout: :horizontal) do |group|
        group.text_field(
          name: @input_name,
          placeholder: @placeholder,
          label: @label,
          visually_hide_label: true,
          required: true,
          autofocus: true
        )

        group.submit(name: :submit, label: I18n.t("button_save"), scheme: :primary)

        group.button(
          name: :cancel,
          scheme: :secondary,
          label: I18n.t(:button_cancel),
          tag: :a,
          data: { "turbo-stream": true },
          href: @cancel_url
        )
      end
    end

    def initialize(cancel_url:, input_name: :title, label: I18n.t(:label_title), placeholder: I18n.t(:label_title))
      super()
      @cancel_url = cancel_url
      @input_name = input_name
      @label = label
      @placeholder = placeholder
    end
  end

end
