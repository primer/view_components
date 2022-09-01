# frozen_string_literal: true

module Primer
  module Responsive
    # @label HtmlAttributesHelper
    class HtmlAttributesHelperPreview < ViewComponent::Preview
      extend Primer::Responsive::HtmlAttributesHelper

      MAIN_TEMPLATE = "primer/responsive/responsive_preview_output"
      ERROR_STYLE = "color: darkred"

      # @label Sanitization
      def sanitization
        attributes = {
          "data-status": "open",
          onclick: "javascript: jsCallback()",
          slot: "custom-title",
          custom_attr: "some random value",
          class: "custom-style-class another-style-class this-style-class",
          id: "unique-item-01",
          for: "unique-input-2"
        }
        additional_allowed_attributes = [:for]

        sanitized = self.class.sanitize_html_attributes(attributes, additional_allowed_attributes: additional_allowed_attributes)

        panels = [
          {
            title: "additional allowed attributes",
            output: additional_allowed_attributes.pretty_inspect
          }, {
            title: "raw attributes",
            output: attributes.pretty_inspect
          }, {
            title: "sanitized",
            output: sanitized.pretty_inspect
          }
        ]

        render_with_template(
          locals: { panels: panels },
          template: MAIN_TEMPLATE
        )
      end

      # @label Validation
      def validation
        attributes = {
          "data-status": "open",
          onclick: "javascript: jsCallback()",
          slot: "custom-title",
          custom_attr: "some random value",
          class: "custom-style-class another-style-class this-style-class",
          id: "unique-item-01",
          for: "unique-input-2"
        }
        additional_allowed_attributes = [:for]

        begin
          self.class.validate_html_attributes(attributes, additional_allowed_attributes: additional_allowed_attributes)
        rescue Primer::Responsive::HtmlAttributesHelper::InvalidHtmlAttributeError => e
          error_message = e.message
        end

        panels = [
          {
            title: "raw attributes",
            output: attributes.pretty_inspect
          }, {
            title: "error",
            style: ERROR_STYLE,
            output: error_message
          }
        ]

        render_with_template(
          locals: { panels: panels },
          template: MAIN_TEMPLATE
        )
      end
    end
  end
end
