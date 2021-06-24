# frozen_string_literal: true

require "test_helper"

class LinterTestCase < Minitest::Test
  def setup
    @linter = linter_class&.new(file_loader, linter_class.config_schema.new)
  end

  def linter_class; end

  def offenses
    @linter.offenses
  end

  def file_loader
    ERBLint::FileLoader.new(".")
  end

  def processed_source
    ERBLint::ProcessedSource.new("file.rb", @file)
  end

  def tags
    processed_source.parser.nodes_with_type(:tag).map { |tag_node| BetterHtml::Tree::Tag.from_node(tag_node) }
  end

  def corrected_content
    source = processed_source

    @linter.run(source)
    corrector = ERBLint::Corrector.new(source, offenses)

    corrector.corrected_content
  end
end
