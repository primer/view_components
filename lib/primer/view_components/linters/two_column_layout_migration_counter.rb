# frozen_string_literal: true

require_relative "base_linter"
require_relative "tag_tree_helpers"

module ERBLint
  module Linters
    # Counts the number of times a two column layout using col-* CSS classes is used instead of the layout component.
    class TwoColumnLayoutMigrationCounter < BaseLinter
      include LinterRegistry
      include TagTreeHelpers

      WIDTH_RANGE = (8..10).freeze
      SIDEBAR_WIDTH_RANGE = (2..4).freeze

      CONTAINER_CLASSES = %w[container-xl container-lg container-md container-sm].freeze
      MESSAGE = "We are migrating two-column layouts to use "\
        "[Primer::Alpha::Layout](https://primer.style/view-components/components/layout), "\
        "please use that instead of raw HTML."

      # :nodoc:
      class Breakpoints
        LABELS = %i[all sm md lg xl].freeze

        def initialize
          @map = {}
        end

        def set(breakpoint, value)
          @map[breakpoint] = value
        end

        def min
          LABELS.find { |label| @map[label] } || :all
        end

        def min_value
          @map[min]
        end
      end

      # :nodoc:
      class Column
        attr_reader :widths, :tag_tree

        def initialize(widths, tag_tree)
          @widths = widths
          @tag_tree = tag_tree
        end
      end

      # :nodoc:
      class Container
        attr_reader :columns

        def initialize(columns)
          @columns = columns
        end

        def sidebar
          sorted_columns.first
        end

        def main
          sorted_columns.last
        end

        private

        def sorted_columns
          @sorted_columns ||= columns.sort_by do |col|
            col.widths.min_value || 0
          end
        end
      end

      def run(processed_source)
        @total_offenses = 0
        @offenses_not_corrected = 0

        tags, tag_tree = build_tag_tree(processed_source)

        tags.each do |tag|
          next if tag.closing?
          next unless tag.name == "div"

          classes = classes_from(tag)
          next if (CONTAINER_CLASSES & classes).empty?

          next unless metadata_from(tag_tree[tag])

          @total_offenses += 1
          @offenses_not_corrected += 1

          generate_offense(self.class, processed_source, tag, MESSAGE)
        end

        counter_correct?(processed_source)
      end

      private

      def metadata_from(tag_tree)
        tags = tag_tree[:children].select { |c| c.is_a?(Hash) }

        if d_flex?(tags)
          container_from(tags.first)
        else
          container_from(tag_tree)
        end
      end

      def d_flex?(tags)
        tags.size == 1 && classes_from(tags.first[:tag]).include?("d-flex")
      end

      def container_from(columns_tag_tree)
        columns = columns_from(columns_tag_tree)
        return unless columns.size == 2

        container = Container.new(columns)

        main_min = container.main.widths.min_value
        sidebar_min = container.sidebar.widths.min_value
        return unless sidebar_min && main_min
        return unless WIDTH_RANGE.include?(main_min)
        return unless SIDEBAR_WIDTH_RANGE.include?(sidebar_min)

        container
      end

      def columns_from(tag_tree)
        tag_tree[:children].each_with_object([]) do |tag_data, tags_memo|
          next unless tag_data.is_a?(Hash)
          next unless tag_data[:tag].name == "div"

          classes = classes_from(tag_data[:tag])
          widths = Breakpoints.new

          classes.each do |cls|
            match = cls.match(/\Acol(?:-(xl|lg|md|sm))?-(\d{1,2})(?:-max)?\z/)
            next unless match

            breakpoint, width = match.captures
            breakpoint ||= :all
            widths.set(breakpoint.to_sym, width.to_i)
          end

          tags_memo << Column.new(widths, tag_data)
        end
      end

      def classes_from(tag)
        tag.attributes["class"]&.value&.split(" ") || []
      end
    end
  end
end
