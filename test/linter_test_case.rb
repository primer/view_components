# frozen_string_literal: true

require "test_helper"
require "erb_lint"
require "primer/view_components/linters"

class LinterTestCase < Minitest::Test
  def setup
    @linter = linter_class.new(file_loader, linter_class.config_schema.new)
  end

  def file_loader
    ERBLint::FileLoader.new(".")
  end

  def processed_source
    ERBLint::ProcessedSource.new("file.rb", @file)
  end

  def corrector
    ERBLint::Corrector.new(processed_source, @linter.offenses)
  end

  delegate :corrected_content, to: :corrector
end
