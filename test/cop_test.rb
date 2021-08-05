# frozen_string_literal: true

require "test_helper"
require "rubocop/cop/primer"

class CopTest < MiniTest::Test
  def cop_class
    raise NotImplementedError
  end

  attr_reader :cop

  def setup
    config = RuboCop::Config.new
    @cop = cop_class.new(config)
  end

  def investigate(cop, src, filename = nil)
    processed_source = RuboCop::ProcessedSource.new(src, RUBY_VERSION.to_f, filename)
    commissioner = RuboCop::Cop::Commissioner.new([cop], [], raise_error: true)
    commissioner.investigate(processed_source)
    commissioner
  end
end
