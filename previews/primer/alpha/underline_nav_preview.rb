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
      def default(label: "Default with nav element", tag: :nav, align: :left, number_of_panels: 3)
        render_with_template(locals: {
                               label: label,
                               tag: tag,
                               align: align,
                               number_of_panels: number_of_panels
                             })
      end

      # @label With icons and counters
      #
      # @param label [String] text
      # @param tag [Symbol] select [div, nav]
      # @param align [Symbol] select [left, right]
      # @param number_of_panels [Integer] number
      def with_icons_and_counters(label: "With icons and counters", number_of_panels: 3, align: :left, tag: :nav)
        render(Primer::Alpha::UnderlineNav.new(label: label, tag: tag, align: align)) do |component|
          Array.new(number_of_panels || 3) do |i|
            component.with_tab(href: "#", selected: i.zero?) do |t|
              t.icon(icon: :star)
              t.text { "Item #{i + 1}" }
              t.counter(count: rand(1..10))
            end
          end
        end
      end
    end
  end
end
