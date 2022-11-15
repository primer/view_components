# frozen_string_literal: true

require_relative "./test_helper"
Dir["app/components/**/*.rb"].each { |file| require_relative "../../#{file}" }

IGNORED_SELECTORS = {
  global: ["preview-wrap"]
}.freeze

# Test CSS Selectors Used By Components
# ----
# 
# ensure all of the classes used by components are valid, checking against the
# available selectors in component-specific CSS
class ComponentSelectorUseTest < Minitest::Test
  include Primer::ComponentTestHelpers
  include Primer::RenderPreview

  COMPONENT_SELECTORS = Dir["app/components/**/*.css.json"].map { |file| 
    data = JSON.parse(File.read(file))
    data["selectors"].map { |sel| sel.gsub('\n', "").strip.downcase }
  }.flatten.uniq

  # these test methods are created dynamically so we can see all failures for
  # all components and not error after the first component failure
  Primer::Component.descendants.each do |component_class|
    class_test_name = component_class.name.downcase.gsub("::", "_")
    define_method("test_selectors_used_by_#{class_test_name}_are_valid") do
      preview_class = get_preview_class(component_class)
      next unless preview_class

      previews = preview_class.instance_methods(false)
      previews.each do |preview|
        preview_page = render_preview(preview, preview_klass: preview_class)
        preview_selectors = find_selectors(component_class, preview_page)

        preview_selectors.each do |selector|
          assert COMPONENT_SELECTORS.include?(".#{selector.downcase}"), "Could not find .#{selector.downcase} in the PVC component-specific selectors"
        end
      end
    end
  end

  private

  def find_selectors(component_class, node)
    selectors = node.classes || []

    child_selectors = node.elements.map do |el| 
      find_selectors(component_class, el)
    end

    flat_list = selectors.concat(child_selectors).flatten.uniq
    filtered_selectors = filter_selectors(component_class, flat_list, IGNORED_SELECTORS)

    # puts "              Node: #{node.name}"
    # puts "    Node Selectors: #{selectors}"
    # puts "   Child Selectors: #{child_selectors}"
    # puts "Combined Selectors: #{flat_list}"
    # puts "Filtered Selectors: #{filtered_selectors}"
    # puts ""

    filtered_selectors
  end
end
