# frozen_string_literal: true

require "components/test_helper"

module Primer::RenderPreview
  def render_preview(name, preview_klass: nil, params: {})
    if preview_klass.nil?
      begin
        if respond_to?(:described_class)
          raise "`render_preview` expected a described_class, but it is nil." if described_class.nil?

          preview_klass = "#{described_class}Preview"
        else
          preview_klass = self.class.name.gsub("Test", "Preview")
        end
        preview_klass = preview_klass.constantize
      rescue NameError
        raise NameError, "`render_preview` expected to find #{preview_klass}, but it does not exist."
      end
    end

    previews_controller = build_controller(Rails.application.config.view_component.preview_controller.constantize)

    # From what I can tell, it's not possible to overwrite all request parameters
    # at once, so we set them individually here.
    params.each do |k, v|
      previews_controller.request.params[k] = v
    end

    previews_controller.request.params[:path] = "#{preview_klass.preview_name}/#{name}"
    previews_controller.response = ActionDispatch::Response.new
    result = previews_controller.previews

    @rendered_content = result

    Nokogiri::HTML.fragment(@rendered_content)
  end

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
      ignore_class?(selector, component_class, ignore_list)
    end

    filtered.flatten.uniq
  end

  def ignore_class?(css_class, component_class, ignore_list)
    global_list = ignore_list[:global] || []
    global_ignored = global_list.any? { |pattern| css_class.match(pattern) }

    component_filter = ignore_list[component_class]
    component_ignored = component_filter ? component_filter.any? { |pattern| css_class.match(pattern) } : false

    global_ignored || component_ignored
  end
end
