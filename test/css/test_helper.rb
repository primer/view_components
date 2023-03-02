# frozen_string_literal: true

require "components/test_helper"

module Primer::RenderPreview
  def get_preview_class(component_class)
    name = component_class.name.gsub("Component", "")
    prevew_name = "#{name}Preview"
    Object.const_defined?(prevew_name) ? prevew_name.constantize : nil
  end

  def get_component_selectors(component_class, ignore_list = {})
    css_file = Object.const_source_location(component_class.to_s)[0].gsub(".rb", ".css.json")
    css_data = File.exist?(css_file) ? JSON.parse(File.read(css_file)) : {}
    filter_selectors(component_class, css_data["selectors"], ignore_list)
  end

  def filter_selectors(component_class, selectors, ignore_list)
    ignore_list ||= {}

    filtered = (selectors || []).reject do |selector|
      global_list = ignore_list[:global] || []
      global_ignored = global_list.any? { |pattern| selector.match(pattern) }

      component_filter = ignore_list[component_class]
      component_ignored = component_filter ? component_filter.any? { |pattern| selector.match(pattern) } : false

      global_ignored || component_ignored
    end

    filtered.flatten.uniq
  end
end
