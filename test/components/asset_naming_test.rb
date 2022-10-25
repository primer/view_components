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

  # TODO: Remove this when we fix the naming of these files
  FIX_ME = %w[
    app/components/primer/alpha/tool_tip.ts
    app/components/primer/alpha/modal_dialog.ts
    app/components/primer/beta/auto_complete/auto_complete.ts
    app/components/primer/beta/x_banner.ts
  ]

  def test_js_naming_matches_component
    Dir["app/components/**/*.ts"].each do |file|
      next if file.include?("primer.ts") || file.include?(".d.ts") || FIX_ME.include?(file)

      component_file = file.sub(".ts", ".rb")

      assert File.exist?(component_file), "TS file #{file} does not have a corresponding component file. The file should be named to match the component."
    end
  end
end
