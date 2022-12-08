# frozen_string_literal: true

require "components/test_helper"

class ComponentCssTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_css_gets_compiled
    assert File.exist?("app/assets/styles/primer_view_components.css"), "Compiled CSS file not found"
  end

  def test_css_is_compiled_correctly
    Dir["app/components/**/*.css"].each do |file|
      css = File.read(file)

      # remove comments
      css.gsub!(%r{/\*((?!\*/).)*\*/}m, "")

      refute(css.include?("@import"), "CSS files should not import other CSS files:\n#{file} contains @import")
      refute(css.include?("&"), "CSS Nesting wasn't compiled correctly:\n#{file} contains &")
      refute(css.include?("$"), "Sass variable(s) detected:\n#{file} contains $")
    end
  end
end
