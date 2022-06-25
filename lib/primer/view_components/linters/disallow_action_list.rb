# frozen_string_literal: true

require_relative "helpers/rubocop_helpers"

module ERBLint
  module Linters
    # Replaces calls to `super` with calls to `render_parent`.
    class DisallowActionList < Linter
      include ERBLint::LinterRegistry
      include Helpers::RubocopHelpers
      include TagTreeHelpers

      class ConfigSchema < LinterConfig
        property :ignore_files, accepts: array_of?(String), default: -> { [] }
      end
      self.config_schema = ConfigSchema

      def run(processed_source)
        return if ignored?(processed_source.filename)

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

      def ignored?(filename)
        begin
          relative_filename = Pathname(filename).relative_path_from(Dir.getwd)
        rescue ArgumentError
          return false
        end

        @config.ignore_files.any? { |pattern| relative_filename.fnmatch?(pattern) }
      end
    end
  end
end
