# frozen_string_literal: true

require "components/css/test_helper"

class CssSelectorTest < Minitest::Test
  include Primer::ComponentTestHelpers
  include Primer::RenderPreview

  IGNORED_SELECTORS = [":root", ":before", ":hover", ":active", ":disabled", ":focus"]

  def test_selectors_match
    css = JSON.parse(File.read("app/components/primer/beta/button.css.json"))
    require_relative "../../../previews/primer/beta/button_preview"

    preview_class = Primer::Beta::ButtonPreview
    previews = Primer::Beta::ButtonPreview.instance_methods(false)
    puts "Previews: #{previews}"
    matched_selectors = []
    filtered_selectors = filter_selectors(css["selectors"])

    previews.each do |preview|
      preview_page = render_preview(preview, preview_klass: preview_class)

      filtered_selectors.each do |selector|
        result = preview_page.css(selector)
        matched_selectors << selector unless result.empty?
      end
    end

    filtered_selectors = filtered_selectors.flatten.uniq
    matched_selectors = matched_selectors.flatten.uniq
    remaining_selectors = (filtered_selectors - matched_selectors).uniq

    puts "unfiltered count: #{css["selectors"].count}"
    puts "  filtered count: #{filtered_selectors.count}"
    puts "   matched count: #{matched_selectors.count}"
    puts " remaining count: #{remaining_selectors.count}"
    puts "remaining selectors:"

    assert_empty(remaining_selectors, "Component for #{preview_class.name} does not have previews for the following selectors: #{remaining_selectors}")
  end

  private

  def filter_selectors(selectors)
    selectors.select do |selector|
      !IGNORED_SELECTORS.any?{ |pattern| selector.match(pattern) }
    end
  end
end
