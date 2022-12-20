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
          component.with_header { "Header" }
          component.with_body { "Body" }
          component.with_row(scheme: scheme) { "#{scheme.to_s.capitalize} row one" }
          component.with_row(scheme: scheme) { "#{scheme.to_s.capitalize} row two" }
          component.with_row(scheme: scheme) { "#{scheme.to_s.capitalize} row three" }
          component.with_footer { "Footer" }
        end
      end

      # @label Default
      def default
        render(Primer::Beta::BorderBox.new) do |component|
          component.with_header { "Header" }
          component.with_body { "Body" }
          component.with_row { "Row one" }
          component.with_row { "Row two" }
          component.with_row { "Row three" }
          component.with_footer { "Footer" }
        end
      end

      # @label Header with title
      def header_with_title
        render(Primer::Beta::BorderBox.new) do |component|
          component.with_with_header do |h|
            h.title(tag: :h2) do
              "Header with title"
            end
          end
          component.with_body { "Body" }
          component.with_footer { "Footer" }
        end
      end

      # @label Row colors
      def row_colors
        render(Primer::Beta::BorderBox.new) do |component|
          component.with_row(scheme: :default) { "Default" }
          component.with_row(scheme: :neutral) { "Neutral" }
          component.with_row(scheme: :info) { "Info" }
          component.with_row(scheme: :warning) { "Warning" }
        end
      end

      # @!group Padding
      #
      # @label Default
      def padding_default
        render(Primer::Beta::BorderBox.new) do |component|
          component.with_header { "Header" }
          component.with_body { "Body" }
          component.with_row { "Row one" }
          component.with_row { "Row two" }
          component.with_row { "Row three" }
          component.with_footer { "Footer" }
        end
      end

      # @label Condensed
      def padding_condensed
        render(Primer::Beta::BorderBox.new(padding: :condensed)) do |component|
          component.with_header { "Header" }
          component.with_body { "Body" }
          component.with_row { "Row one" }
          component.with_row { "Row two" }
          component.with_row { "Row three" }
          component.with_footer { "Footer" }
        end
      end

      # @label Spacious
      def padding_spacious
        render(Primer::Beta::BorderBox.new(padding: :spacious)) do |component|
          component.with_header { "Header" }
          component.with_body { "Body" }
          component.with_row { "Row one" }
          component.with_row { "Row two" }
          component.with_row { "Row three" }
          component.with_footer { "Footer" }
        end
      end
      #
      # @!endgroup
    end
  end
end
