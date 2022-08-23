# frozen_string_literal: true

module Primer
  module Beta
    # @label BorderBox
    class BorderBoxPreview < ViewComponent::Preview
      # @label Default options
      #
      # @param padding [Symbol] select [default, condensed]
      def default(padding: :default)
        render(Primer::Beta::BorderBox.new(padding: padding)) do |component|
          component.header { "Header" }
          component.body { "Body" }
          component.row { "Row one" }
          component.row { "Row two" }
          component.row { "Row three" }
          component.footer { "Footer" }
        end
      end

      # @label Row schemes
      #
      # @param padding [Symbol] select [default, condensed]
      # @param scheme [Symbol] select [default, neutral, info, warning]
      def row_schemes(padding: :default, scheme: :default)
        render(Primer::Beta::BorderBox.new(padding: padding)) do |component|
          component.row(scheme: scheme) { "#{scheme.to_s.capitalize} scheme" }
        end
      end
    end
  end
end
