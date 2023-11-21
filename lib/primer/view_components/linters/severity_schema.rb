# frozen_string_literal: true

require "erb_lint/utils/severity_levels"

module ERBLint
  module Linters
    # :nodoc:
    class SeveritySchema < LinterConfig
      # SEVERITY_NAMES :info, :refactor, :convention, :warning, :error, :fatal
      # see https://github.com/Shopify/erb-lint/blob/main/lib/erb_lint/utils/severity_levels.rb

      property :severity, accepts: ERBLint::Utils::SeverityLevels::SEVERITY_NAMES, default: nil, reader: :severity
    end
  end
end
