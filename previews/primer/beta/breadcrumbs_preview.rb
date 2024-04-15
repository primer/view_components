# frozen_string_literal: true

module Primer
  module Beta
    # @label Breadcrumbs
    class BreadcrumbsPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param number_of_links [Integer] number
      def playground(number_of_links: 2)
        render(Primer::Beta::Breadcrumbs.new) do |component|
          Array.new(number_of_links&.to_i || 3) do |i|
            component.with_item(href: "##{i}") { "Breadcrumb Item #{i + 1}" }
          end
        end
      end

      # @label Default options
      #
      # @param number_of_links [Integer] number
      # @snapshot
      def default(number_of_links: 2)
        render(Primer::Beta::Breadcrumbs.new) do |component|
          Array.new(number_of_links&.to_i || 3) do |i|
            component.with_item(href: "##{i}") { "Breadcrumb Item #{i + 1}" }
          end
        end
      end
    end
  end
end
