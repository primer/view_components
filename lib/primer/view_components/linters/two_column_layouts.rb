# frozen_string_literal: true

require_relative "tag_tree_helpers"

module ERBLint
  module Linters
    # Identifies two column layouts using col-* CSS classes instead of the layout component.
    class TwoColumnLayouts < Linter
      include LinterRegistry
      include TagTreeHelpers

      SIDEBAR_WIDTH_DEFAULT = :default
      GUTTER_DEFAULT = :default
      STACKING_BREAKPOINT_DEFAULT = :md
      FIRST_IN_SOURCE_DEFAULT = :sidebar
      WIDTH_DEFAULT = :full

      WIDTH_RANGE = (8..11).freeze
      SIDEBAR_WIDTH_RANGE = (1..4).freeze

      CONTAINER_CLASSES = %w[container-xl container-lg container-md container-sm].freeze
      MESSAGE = "We are migrating two-column layouts to use [Primer::Alpha::Layout](https://primer.style/view-components/components/layout), please use that instead of raw HTML."

      class Breakpoints
        LABELS = %i(all sm md lg xl)

        def initialize
          @map = {}
        end

        def empty?
          @map.empty?
        end

        def set(breakpoint, value)
          @map[breakpoint] = value
        end

        def get(breakpoint)
          @map[breakpoint]
        end

        def min
          LABELS.find { |label| @map[label] } || :all
        end

        def min_value
          @map[min]
        end
      end

      class Column
        attr_reader :widths, :floats, :tag_tree

        def initialize(widths, floats, tag_tree)
          @widths = widths
          @floats = floats
          @tag_tree = tag_tree
        end

        def content
          start_pos = tag_tree[:tag].node.location.end_pos + 1
          end_pos = tag_tree[:closing].node.location.begin_pos - 1
          tag_tree[:tag].node.location.source_buffer.slice(start_pos..end_pos)
        end

        def tag
          tag_tree[:tag]
        end

        def closing
          tag_tree[:closing]
        end
      end

      class Container
        attr_reader :columns, :gutters, :tag_tree

        def initialize(columns, gutters, tag_tree)
          @columns = columns
          @gutters = gutters
          @tag_tree = tag_tree
        end

        def tag
          tag_tree[:tag]
        end

        def closing
          tag_tree[:closing]
        end

        def sidebar
          sorted_columns.first
        end

        def main
          sorted_columns.last
        end

        def sorted_columns
          @sorted_columns ||= columns.sort_by do |col|
            col.widths.min_value || 0
          end
        end

        def stacking_breakpoint
          @stacking_breakpoint ||= begin
            breakpoint = columns
              .map { |col| col.widths.min }
              .min_by { |breakpoint| Breakpoints::LABELS.index(breakpoint) }

            # :sm is the lowest breakpoint Layout allows
            breakpoint == :all ? :sm : breakpoint
          end
        end

        def first_in_source
          @first_in_source ||= columns.index(sidebar) < columns.index(main) ? :sidebar : :main
        end

        def main_width
          # nothing else really makes sense
          :full
        end

        def sidebar_width
          @sidebar_width ||= case sidebar.widths.min_value
            when 1..2
              :narrow
            when 4
              :wide
            else
              SIDEBAR_WIDTH_DEFAULT
          end
        end

        def gutter
          @gutter ||= if gutters.empty?
            :none
          else
            if (gtr = gutters.min_value)
              gtr.to_sym
            else
              GUTTER_DEFAULT
            end
          end
        end
      end

      class ContainerArgs
        delegate_missing_to :@container

        attr_reader :container

        def initialize(container)
          @container = container
        end

        def stacking_breakpoint
          container.stacking_breakpoint.tap do |breakpoint|
            return if breakpoint == STACKING_BREAKPOINT_DEFAULT
          end
        end

        def gutter
          container.gutter.tap do |gtr|
            return if gtr == GUTTER_DEFAULT
          end
        end

        def first_in_source
          container.first_in_source.tap do |fis|
            return if fis == FIRST_IN_SOURCE_DEFAULT
          end
        end

        def main_width
          container.main_width.tap do |width|
            return if width == WIDTH_DEFAULT
          end
        end

        def sidebar_width
          container.sidebar_width.tap do |width|
            return if width == SIDEBAR_WIDTH_DEFAULT
          end
        end

        def component_args
          @component_args ||= {}.tap do |args|
            if (breakpoint = stacking_breakpoint)
              args[:stacking_breakpoint] = breakpoint
            end

            if (gtr = gutter)
              args[:gutter] = gtr
            end

            if (fis = first_in_source)
              args[:first_in_source] = fis
            end
          end
        end

        def main_args
          @main_args ||= {}.tap do |args|
            if (width = main_width)
              args[:width] = width
            end
          end
        end

        def sidebar_args
          @sidebar_args ||= {}.tap do |args|
            if (width = sidebar_width)
              args[:width] = width
            end
          end
        end
      end

      def run(processed_source)
        tags, tag_tree = build_tag_tree(processed_source)

        tags.each do |tag|
          next if tag.closing?
          next unless tag.name == "div"

          classes = classes_from(tag)
          next unless CONTAINER_CLASSES.any? { |c| classes.include?(c) }

          metadata = metadata_from(tag_tree[tag])
          next unless metadata

          add_offenses_for(
            metadata.container,
            "<%= render Primer::Alpha::Layout.new#{hash_as_args(metadata.component_args)} do |component| %>"
          )

          add_offenses_for(
            metadata.container.sidebar,
            "<% component.sidebar#{hash_as_args(metadata.sidebar_args)} %>"
          )

          add_offenses_for(
            metadata.container.main,
            "<% component.main#{hash_as_args(metadata.main_args)} %>"
          )
        end
      end

      def autocorrect(_processed_source, offense)
        return unless offense.context

        lambda do |corrector|
          corrector.replace(offense.source_range, offense.context)
        end
      end

      private

      def add_offenses_for(element, replacement)
        add_offense(element.tag.node.location, MESSAGE, replacement)
        add_offense(element.closing.loc, MESSAGE, "<% end %>")
      end

      def metadata_from(tag_tree)
        tags = tag_tree[:children].select { |c| c.is_a?(Hash) }

        if d_flex?(tags)
          args_from(tag_tree, tags.first)
        else
          args_from(tag_tree, tag_tree)
        end
      end

      def d_flex?(tags)
        tags.size == 1 && classes_from(tags.first[:tag]).include?("d-flex")
      end

      def args_from(container_tag_tree, columns_tag_tree)
        columns = columns_from(columns_tag_tree)
        return unless columns.size == 2

        gutters = gutters_from(container_tag_tree[:tag])
        container = Container.new(columns, gutters, container_tag_tree)

        main_min = container.main.widths.min_value
        sidebar_min = container.sidebar.widths.min_value
        return unless sidebar_min && main_min
        return unless WIDTH_RANGE.include?(main_min)
        return unless SIDEBAR_WIDTH_RANGE.include?(sidebar_min)

        ContainerArgs.new(container)
      end

      def hash_as_args(hash)
        hash.empty? ? "" : "(#{symbolize_hash(hash)})"
      end

      def symbolize_hash(hash)
        hash.map { |k, v| "#{k}: #{v.inspect}" }.join(", ")
      end

      def columns_from(tag_tree)
        tag_tree[:children].each_with_object([]) do |tag_data, tags_memo|
          next unless tag_data.is_a?(Hash)
          next unless tag_data[:tag].name == "div"

          classes = classes_from(tag_data[:tag])
          col_sizes = Breakpoints.new
          floats = Breakpoints.new

          classes.each do |cls|
            if (match = cls.match(/\Acol(?:-(xl|lg|md|sm))?-(\d{1,2})(?:-max)?\z/))
              breakpoint, width = match.captures
              breakpoint ||= :all
              col_sizes.set(breakpoint.to_sym, width.to_i)
            end

            if (match = cls.match(/\Afloat(?:-(xl|lg|md|sm))?-(\d{1,2})\z/))
              breakpoint, width = match.captures
              breakpoint ||= :all
              floats.set(breakpoint.to_sym, width.to_i)
            end
          end

          tags_memo << Column.new(col_sizes, floats, tag_data)
        end
      end

      def gutters_from(tag)
        Breakpoints.new.tap do |gutters|
          classes_from(tag).each do |cls|
            if (match = cls.match(/\Agutter(?:-(xl|lg|md|sm))?(?:-(condensed|spacious))?\z/))
              breakpoint, width = match.captures
              breakpoint ||= :all
              gutters.set(breakpoint.to_sym, width)
            end
          end
        end
      end

      def classes_from(tag)
        tag.attributes["class"]&.value&.split(" ") || []
      end
    end
  end
end
