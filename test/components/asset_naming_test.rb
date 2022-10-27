# frozen_string_literal: true

require "components/test_helper"

class AssetNamingTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_css_naming_matches_component
    Dir["app/components/**/*.pcss"].each do |file|
      next if file.include?("primer.pcss")

      component_file = file.sub(".pcss", ".rb")

      assert File.exist?(component_file), "CSS file #{file} does not have a corresponding component file. The file should be named to match the component."
    end
  end
end
