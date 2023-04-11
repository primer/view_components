# frozen_string_literal: true

require_relative "../base_linter"

# Load all the other linters so we can filter out their restricted
# CLASSES—they will be responsible for complaining about the use of
# those HTML classes.
Dir[File.join(__dir__, "../*.rb")].sort.each do |file|
  require file unless file == __FILE__
end

module ERBLint
  module Linters
    module Primer
      # Counts the number of times a class reserved for ViewComponents is used
      class DisallowComponentCss < BaseLinter
        CLASSES_COVERED_BY_OTHER_LINTERS =
          BaseLinter.subclasses.reduce([]) do |html_classes, klass|
            html_classes.concat(klass.const_get(:CLASSES))
          end

        CLASSES = (
          JSON.parse(
            File.read(
              File.join(__dir__, "..", "..", "..", "..", "..", "static", "classes.json")
            )
          ).reject do |html_class, _ruby_classes|
            CLASSES_COVERED_BY_OTHER_LINTERS.include?(html_class)
          end
        ).freeze

        def run(processed_source)
          @total_offenses = 0
          @offenses_not_corrected = 0

          processed_source
            .parser
            .nodes_with_type(:tag)
            .each do |node|
              tag = BetterHtml::Tree::Tag.from_node(node)

              tag.attributes["class"]&.value&.split(/\s+/)&.each do |class_name|
                if CLASSES.key? class_name
                  @total_offenses += 1
                  @offenses_not_corrected += 1
                  add_offense(
                    processed_source.to_source_range(tag.loc),
                    format_message(class_name)
                  )
                end
              end
            end

          dump_data(processed_source) if ENV["DUMP_LINT_DATA"] == "1"
        end

        private

        def format_message(class_name)
          "HTML class \"#{class_name}\" is reserved for Primer ViewComponents. It might disappear or have different styles in the future. Instead use #{CLASSES[class_name].join(', ')} from Primer ViewComponents instead."
        end
      end
    end
  end
end
