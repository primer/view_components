# frozen_string_literal: true

require_relative "./test_helper"
Dir["app/components/**/*.rb"].each { |file| require_relative "../../#{file}" }

# Test Component Specific Selectors
# ----
# ensure all css rules that are added to a component specific css file, are
# are present in a preview. selectors that do not show up in a preview can be
# ignored by modifying the above `IGNORED_SELECTORS` constant.
#
class ComponentSpecificSelectorsTest < Minitest::Test
  include Primer::ComponentTestHelpers
  include Primer::RenderPreview

  IGNORED_SELECTORS = {
    :global => [/^\d/, ":"],
    Primer::Alpha::ActionList => [/^to/],
    Primer::Alpha::Banner => [".Banner .Banner-close"],
    Primer::Alpha::SegmentedControl => [".Button-withTooltip"],
    Primer::Beta::Button => ["summary.Button"],
    Primer::Beta::Counter => ["Counter .octicon"]
  }.freeze

  # these test methods are created dynamically so we can see all failures for
  # all components and not error after the first component failure
  Primer::Component.descendants.each do |component_class|
    class_test_name = component_class.name.downcase.gsub("::", "_")
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

      remaining_selectors = (selectors - matched_selectors.flatten.uniq) || []
      assert remaining_selectors.empty?, no_preview_for_selectors_message(preview_class, remaining_selectors)
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
    filter_selectors(component_class, css_data["selectors"])
  end

  def no_preview_for_selectors_message(preview_class, selectors)
    class_name = preview_class.name
    selector_list = selectors.join("\n")

    msg = []
    msg << "PVC Preview Class '#{class_name}' does not render a preview for these selectors:"
    msg << ""
    msg << selector_list
    msg << ""
    msg << "Selectors without a preview may be ignored by updating 'IGNORED_SELECTORS' in #{__FILE__}"

    msg.join("\n")
  end

  def filter_selectors(component_class, selectors)
    filtered = (selectors || []).reject do |selector|
      global_ignored = IGNORED_SELECTORS[:global].any? { |pattern| selector.match(pattern) }

      component_filter = IGNORED_SELECTORS[component_class]
      component_ignored = component_filter ? component_filter.any? { |pattern| selector.match(pattern) } : false

      global_ignored || component_ignored
    end

    filtered.flatten.uniq
  end
end
