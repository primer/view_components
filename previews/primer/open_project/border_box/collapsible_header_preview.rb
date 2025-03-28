# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module OpenProject
    module BorderBox
      # @label BorderBox::CollapsibleHeader
      class CollapsibleHeaderPreview < ViewComponent::Preview
        # @label Playground
        # @param string_example text
        # @param boolean_example toggle
        # @param email_example email
        # @param number_example number
        # @param url_example url
        # @param tel_example tel
        # @param textarea_example textarea
        # @param select_example select [one, two, three]
        # @param select_custom_labels select [[One label, one], [Two label, two], [Three label, three]]
        # With empty option (`~` in YAML)
        # @param select_empty_option select [~, one, two, three]
        # def playground(string_example: "Some value", boolean_example: false, select_example: :one)
        #   render(Primer::OpenProject::BorderBox::CollapsibleHeader.new(string_example: string_example, boolean_example: boolean_example, select_example: select_example))
        # end

        # @label Default
        def default
          render_with_template
        end

        # @label with count
        # def playground(string_example: "Some value", boolean_example: false, select_example: :one)
        #
        # end
        #
        # @label with description
        # def playground(string_example: "Some value", boolean_example: false, select_example: :one)
        #
        # end
        #
        # @label with collapsed
        # def playground(string_example: "Some value", boolean_example: false, select_example: :one)
        #
        # end
      end
    end
  end
end
