# frozen_string_literal: true

require_relative "helpers/deprecated_components_helpers"
require_relative "severity_schema"

require "erblint-github/linters/custom_helpers"

module ERBLint
  module Linters
    # Lints against deprecated components
    class DeprecatedComponentsCounter < Linter
      include CustomHelpers
      include ERBLint::LinterRegistry
      include Helpers::DeprecatedComponentsHelpers

      self.config_schema = SeveritySchema

      def run(processed_source)
        processed_source.ast.descendants(:erb).each do |erb_node|
          _, _, code_node = *erb_node
          code = code_node.children.first.strip

          next unless code.include?("Primer::")

          deprecated_components.each do |component|
            next unless code.include?(component)

            add_offense(erb_node.loc, message(component))
          end
        end

        counter_correct?(processed_source)
      end

      def autocorrect(processed_source, offense)
        return unless offense.context

        lambda do |corrector|
          if processed_source.file_content.include?("erblint:counter #{self.class.name.gsub('ERBLint::Linters::', '')}")
            # update the counter if exists
            corrector.replace(offense.source_range, offense.context)
          else
            # add comment with counter if none
            corrector.insert_before(processed_source.source_buffer.source_range, "#{offense.context}\n")
          end
        end
      end

      # this override is necessary because of the github/erblint-github `CustomHelpers`
      # module. `counter_correct?` is provided by this module, and calls `add_offense`
      # directly. there is no simple way to modify this without updating the gem and
      # creating what would likely be an API that is non-standard and/or difficult to use
      #
      # https://github.com/github/erblint-github/blob/main/lib/erblint-github/linters/custom_helpers.rb
      def add_offense(source_range, message, context = nil, severity = nil)
        super(source_range, message, context, severity || @config.severity)
      end
    end
  end
end
