# frozen_string_literal: true

require "test_helper"

class PreviewTest < Minitest::Test
  def setup
    @previews = Dir.glob("previews/**/*.rb").reject { |f| f.include?("forms_preview.rb") || f.include?("/docs/") }
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
end
