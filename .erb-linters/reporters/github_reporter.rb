# frozen_string_literal: true

require "erb_lint/reporters/compact_reporter"

module ERBLint
  module Reporters
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
        [
          "::error ",
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
