# frozen_string_literal: true

require "lib/test_helper"
require "lib/erblint/support/basic_linter_shared_tests"
require "lib/erblint/support/autocorrectable_linter_shared_tests"

class ErblintTestCase < Minitest::Test
  def setup
    @linter = linter_class&.new(file_loader, linter_class.config_schema.new)
    @filename = "file.rb"
  end

  private

  def linter_class; end

  def default_tag; end

  def default_class; end

  def required_attributes; end

  def required_arguments; end

  def default_content
    linter_class.name.demodulize
  end

  def block_correction?
    true
  end

  def offenses
    @linter.offenses
  end

  def file_loader
    ERBLint::FileLoader.new(".")
  end

  def processed_source
    ERBLint::ProcessedSource.new(@filename, @file)
  end

  def tags
    processed_source.parser.nodes_with_type(:tag).map { |tag_node| BetterHtml::Tree::Tag.from_node(tag_node) }
  end

  def corrected_content
    @corrected_content ||= begin
      source = processed_source

      @linter.run(source)
      corrector = ERBLint::Corrector.new(source, offenses)

      corrector.corrected_content
    end
  end

  def linter_with_severity(severity)
    return unless linter_class

    config_with_severity = linter_class.config_schema.new({ severity: severity })
    linter_class.new(file_loader, config_with_severity)
  end

  def linter_with_override
    linter_class&.new(file_loader, linter_class.config_schema.new(override_ignores_if_correctable: true))
  end
end
