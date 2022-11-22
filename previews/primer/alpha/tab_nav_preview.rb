# frozen_string_literal: true

module Primer
  module Alpha
    # @label TabNav
    class TabNavPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param number_of_tabs [Integer] number
      # @param with_icons [Boolean] toggle
      # @param with_counters [Boolean] toggle
      def playground(number_of_tabs: 3, with_icons: false, with_counters: false)
        render(Primer::Alpha::TabNav.new(label: "label")) do |c|
          Array.new(number_of_tabs || 3) do |i|
            c.with_tab(selected: i.zero?, href: "##{i + 1}") do |t|
              t.icon(icon: :star) if with_icons
              t.text { "Tab #{i + 1}" }
              t.counter(count: 10) if with_counters
            end
          end
        end
      end

      # @label Default
      def default
        render(Primer::Alpha::TabNav.new(label: "Default")) do |c|
          c.with_tab(selected: true, href: "#") { "Tab 1" }
          c.with_tab(href: "#") { "Tab 2" }
          c.with_tab(href: "#") { "Tab 3" }
        end
      end

      # @label With icons and counters
      def with_icons_and_counters
        render(Primer::Alpha::TabNav.new(label: "With icons and counters")) do |c|
          c.with_tab(href: "#1", selected: true) do |t|
            t.icon(icon: :star)
            t.text { "Stars" }
            t.counter(count: 10)
          end
          c.with_tab(href: "#2") do |t|
            t.icon(icon: :heart)
            t.text { "Sponsors" }
            t.counter(count: 14)
          end
          c.with_tab(href: "#3") do |t|
            t.icon(icon: :bookmark)
            t.text { "Bookmarks" }
            t.counter(count: 7)
          end
        end
      end
    end
  end
end
