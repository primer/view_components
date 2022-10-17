# frozen_string_literal: true

require "test_helper"

class PreviewTest < Minitest::Test
  def setup
    @previews = Dir.glob("previews/**/*.rb").reject { |f| f.include?("forms_preview.rb") || f.include?("/docs/") }
  end

  def test_previews_exist
    refute_empty(@previews)
  end

  def test_previews_have_default_method
    @previews.each do |preview|
      assert_includes(File.read(preview), "def default", "The preview `#{preview}` does not have a default method. Please include at one `def default` method")
    end
  end
end
