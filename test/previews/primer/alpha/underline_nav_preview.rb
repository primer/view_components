# frozen_string_literal: true

module Primer
  module Alpha
    # @label UnderlineNav
    class UnderlineNavPreview < ViewComponent::Preview
      # @label Default options
      #
      # @param label [String] text
      # @param tag [Symbol] select [div, nav]
      # @param align [Symbol] select [left, right]
      # @param number_of_panels [Integer] number
      def default(label: "Default with nav element", tag: :div, align: :left, number_of_panels: 3)
        render_with_template(locals: {
                               label: label,
                               tag: tag,
                               align: align,
                               number_of_panels: number_of_panels
                             })
      end
    end
  end
end
