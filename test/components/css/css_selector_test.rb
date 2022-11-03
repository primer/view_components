# frozen_string_literal: true

require "components/css/test_helper"
Dir["app/components/**/*.rb"].each {|file| require_relative "../../../#{file}" }

class CssSelectorTest < Minitest::Test
  include Primer::ComponentTestHelpers
  include Primer::RenderPreview

  IGNORED_SELECTORS = [/^\d/, ":is", ":root", ":before", ":after", ":hover", ":active", ":disabled", ":focus"]

  Primer::Component.descendants.each do |component_class|
    class_test_name = component_class.name.camelize
    define_method("test_all_selectors_are_previewed_for_#{class_test_name}") do
      preview_class = get_preview_class(component_class)
      next unless preview_class

      selectors = get_component_selectors(component_class)
      previews = preview_class.instance_methods(false)

      matched_selectors = []
      previews.each do |preview|
        preview_page = render_preview(preview, preview_klass: preview_class)

        selectors.each do |selector|
          result = preview_page.css(selector)
          matched_selectors << selector unless result.empty?
        end
      end

      remaining_selectors = (selectors - matched_selectors.flatten.uniq).uniq || []
      assert_empty(remaining_selectors, no_preview_for_selectors_message(preview_class, remaining_selectors))
    end
  end

  private

  def get_preview_class(component_class)
    name = component_class.name.gsub("Component", "")
    prevew_name = "#{name}Preview"
    Object.const_defined?(prevew_name) ? prevew_name.constantize : nil
  end

  def get_component_selectors(component_class)
    css_file = Object.const_source_location(component_class.to_s)[0].gsub(".rb", ".css.json")
    css_data = File.exist?(css_file) ? JSON.parse(File.read(css_file)) : {}
    filter_selectors(css_data["selectors"])
  end

  def no_preview_for_selectors_message(preview_class, selectors)
    "PVC Preview Class `#{preview_class.name}` does not render a preview for these selectors. Selectors without a preview may be ignored by updating `IGNORED_SELECTORS` in #{__FILE__}\n#{selectors.join("\n")}"
  end

  def filter_selectors(selectors)
    filtered = (selectors || []).select do |selector|
      !IGNORED_SELECTORS.any?{ |pattern| selector.match(pattern) }
    end

    filtered.flatten.uniq
  end
end
