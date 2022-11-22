# frozen_string_literal: true

module Primer
  module Beta
    # @label BorderBox
    class BorderBoxPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param padding [Symbol] select [default, condensed, spacious]
      # @param scheme [Symbol] select [default, neutral, info, warning]
      def playground(padding: :default, scheme: :default)
        render(Primer::Beta::BorderBox.new(padding: padding)) do |component|
          component.header { "Header" }
          component.body { "Body" }
          component.row(scheme: scheme) { "#{scheme.to_s.capitalize} row one" }
          component.row(scheme: scheme) { "#{scheme.to_s.capitalize} row two" }
          component.row(scheme: scheme) { "#{scheme.to_s.capitalize} row three" }
          component.footer { "Footer" }
        end
      end

      # @label Default
      def default
        render(Primer::Beta::BorderBox.new) do |component|
          component.header { "Header" }
          component.body { "Body" }
          component.row { "Row one" }
          component.row { "Row two" }
          component.row { "Row three" }
          component.footer { "Footer" }
        end
      end

      # @label Header with title
      def header_with_title
        render(Primer::Beta::BorderBox.new) do |component|
          component.with_header do |h|
            h.title(tag: :h2) do
              "Header with title"
            end
          end
          component.body { "Body" }
          component.footer { "Footer" }
        end
      end

      # @label Row colors
      def row_colors
        render(Primer::Beta::BorderBox.new) do |component|
          component.row(scheme: :default) { "Default" }
          component.row(scheme: :neutral) { "Neutral" }
          component.row(scheme: :info) { "Info" }
          component.row(scheme: :warning) { "Warning" }
        end
      end

      # @!group Padding
      #
      # @label Default
      def padding_default
        render(Primer::Beta::BorderBox.new) do |component|
          component.header { "Header" }
          component.body { "Body" }
          component.row { "Row one" }
          component.row { "Row two" }
          component.row { "Row three" }
          component.footer { "Footer" }
        end
      end

      # @label Condensed
      def padding_condensed
        render(Primer::Beta::BorderBox.new(padding: :condensed)) do |component|
          component.header { "Header" }
          component.body { "Body" }
          component.row { "Row one" }
          component.row { "Row two" }
          component.row { "Row three" }
          component.footer { "Footer" }
        end
      end

      # @label Spacious
      def padding_spacious
        render(Primer::Beta::BorderBox.new(padding: :spacious)) do |component|
          component.header { "Header" }
          component.body { "Body" }
          component.row { "Row one" }
          component.row { "Row two" }
          component.row { "Row three" }
          component.footer { "Footer" }
        end
      end
      #
      # @!endgroup
    end
  end
end
