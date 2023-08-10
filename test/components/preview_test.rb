# frozen_string_literal: true

require "components/test_helper"

class PreviewTest < Minitest::Test
  def setup
    @previews = Dir.glob("previews/**/*_preview.rb").reject { |f| f.end_with?("forms_preview.rb") }
  end

  def test_previews_exist
    refute_empty(@previews)
  end

  def test_previews_have_default_preview
    missing_previews = []
    @previews.each do |preview|
      contents = File.read(preview)
      missing_previews << preview unless contents.include?("def default")
    end
    assert(missing_previews.empty?, "The following previews are missing a default preview method: \n\n - #{missing_previews.join("\n - ")}\n")
  end

  def test_previews_have_playground_preview
    missing_previews = []
    @previews.each do |preview|
      contents = File.read(preview)
      missing_previews << preview unless contents.include?("def playground")
    end
    assert(missing_previews.empty?, "The following previews are missing a playground preview method: \n\n - #{missing_previews.join("\n - ")}")
  end

  def test_preview_labels_are_sentence_case
    lowercase_labels = []
    @previews.each do |preview|
      contents = File.read(preview).split("\n")
      contents.each_with_index do |line, index|
        lowercase_labels << "#{preview}:#{index + 1}: #{line}" if /# @label [a-z]/.match?(line)
      end
    end
    assert(lowercase_labels.empty?, "Preview labels should use sentence case: \n\n - #{lowercase_labels.join("\n - ")}")
  end
end
