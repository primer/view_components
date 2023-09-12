# frozen_string_literal: true

module Primer
  # :nocov:
  # :nodoc:
  module FormHelper
    def primer_form_with(**kwargs, &block)
      form_with(**kwargs, skip_default_ids: false, builder: Primer::Forms::Builder, &block)
    end

    def primer_fields_for(record_name, record_object = nil, options = {}, &block)
      fields_for(
        record_name,
        record_object,
        options.merge(
          skip_default_ids: false,
          builder: Primer::Forms::Builder
        ),
        &block
      )
    end

    def inline_form(*args, &block)
      Primer::Forms.inline_form(*args, &block)
    end

    def render_inline_form(*args, &block)
      render(inline_form(*args, &block))
    end
  end
end
