# frozen_string_literal: true

require_relative "helpers/rubocop_helpers"

module ERBLint
  module Linters
    # Replaces calls to `super` with calls to `render_parent`.
    class DisallowActionList < Linter
      PVC_PATTERNS = %w[
        app/components/primer/*.html.erb
        app/components/primer/**/*.html.erb
      ].freeze

      include ERBLint::LinterRegistry
      include Helpers::RubocopHelpers
      include TagTreeHelpers

      def run(processed_source)
        # PVCs are exempt
        return if pvc_template?(processed_source.filename)

        class_regex = /ActionList[\w-]*/
        tags, * = build_tag_tree(processed_source)

        tags.each do |tag|
          next if tag.closing?

          classes =
            if (class_attrib = tag.attributes["class"])
              loc = class_attrib.value_node.loc
              loc.source_buffer.source[loc.begin_pos...loc.end_pos]
            else
              ""
            end

          indices = [].tap do |results|
            classes.scan(class_regex) do
              results << Regexp.last_match.offset(0)
            end
          end

          next if indices.empty?

          indices.each do |(start_idx, end_idx)|
            new_loc = class_attrib.value_node.loc.with(
              begin_pos: class_attrib.value_node.loc.begin_pos + start_idx,
              end_pos: class_attrib.value_node.loc.begin_pos + end_idx
            )

            add_offense(
              new_loc,
              "ActionList classes are only designed to be used by Primer View Components and " \
                "should be considered private."
            )
          end
        end
      end

      private

      def pvc_template?(path)
        PVC_PATTERNS.any? { |pattern| File.fnmatch?(pattern, path) }
      end
    end
  end
end
