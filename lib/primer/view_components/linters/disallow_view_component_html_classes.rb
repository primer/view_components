# frozen_string_literal: true

require 'better_html'

require_relative "helpers/rubocop_helpers"

module ERBLint
  module Linters
    # Finds usages of ViewComponent-reserved HTML classes
    class DisallowViewComponentHtmlClasses < Linter
      include LinterRegistry

      RESERVED_HTML_CLASSES = JSON.parse(
        File.read(
          File.join(__dir__, "..", "..", "..", "..", "static", "classes.json")
        )
      ).freeze

      def run(processed_source)
        processed_source
          .parser
          .nodes_with_type(:tag)
          .each do |node|
            tag = BetterHtml::Tree::Tag.from_node(node)

            tag.attributes["class"]&.value&.split(/\s+/)&.each do |class_name|
              if RESERVED_HTML_CLASSES.include? class_name
                add_offense(
                  processed_source.to_source_range(tag.loc),
                  "HTML class \"#{class_name}\" is reserved for Primer ViewComponents. It might disappear or have different styles in the future."
                )
              end
            end
          end
      end
    end
  end
end
