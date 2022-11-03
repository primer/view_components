# frozen_string_literal: true

require "components/css/test_helper"

class CssSelectorTest < Minitest::Test
  include Primer::ComponentTestHelpers
  include Primer::RenderPreview

  IGNORED_SELECTORS = [":root", ":before", ":hover", ":active", ":disabled", ":focus"]

  def test_all_selectors_are_previewed
    css = JSON.parse(File.read("app/components/primer/beta/button.css.json"))
    require_relative "../../../previews/primer/beta/button_preview"
    preview_class = Primer::Beta::ButtonPreview

    previews = preview_class.instance_methods(false)
    filtered_selectors = filter_selectors(css["selectors"])

    matched_selectors = []
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

    assert_empty(remaining_selectors, no_preview_for_selectors_message(preview_class, remaining_selectors))
  end

  private

  def no_preview_for_selectors_message(preview_class, selectors)
    "PVC Preview Class `#{preview_class.name}` does not render a preview for these selectors. Selectors without a preview may be ignored by updating `IGNORED_SELECTORS` in #{__FILE__}\n#{selectors.join("\n")}"
  end

  def filter_selectors(selectors)
    selectors.select do |selector|
      !IGNORED_SELECTORS.any?{ |pattern| selector.match(pattern) }
    end
  end
end
