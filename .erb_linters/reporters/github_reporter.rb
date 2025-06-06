# frozen_string_literal: true

require "erb_lint/reporters/compact_reporter"

module ERBLint
  module Reporters
    SEVERITY_DEFAULT = "::error"

    SEVERITY_MAP = {
       "info" => "::notice",
       "refactor" => "::notice",
       "convention" => "::notice",
       "warning" => "::warning",
       "error" => "::error",
       "fatal" => "::error"
    }.freeze

    # :nodoc:
    class GithubReporter < CompactReporter
      def preview; end

      def show
        processed_files.each do |filename, offenses|
          offenses.each do |offense|
            puts format_offense(filename, offense)
          end
        end
      end

      private

      def format_offense(filename, offense)
        report_level = SEVERITY_MAP[offense.severity] || SEVERITY_DEFAULT

        [
          report_level,
          [
            "file=#{filename}",
            "line=#{offense.line_number}",
            "col=#{offense.column}"
          ].join(","),
          "::",
          "#{offense.linter.class.simple_name}: ",
          offense.message.to_s
        ].join
      end
    end
  end
end
