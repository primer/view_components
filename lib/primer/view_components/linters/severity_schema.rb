# frozen_string_literal: true

require "erb_lint/utils/severity_levels"

module ERBLint
  module Linters
    class SeveritySchema < LinterConfig
      property :severity, accepts: ERBLint::Utils::SeverityLevels::SEVERITY_NAMES, default: :fatal, reader: :severity
    end
  end
end
