# frozen_string_literal: true

require_relative "./test_helper"
Dir["app/components/**/*.rb"].each { |file| require_relative "../../#{file}" }

IGNORED_SELECTORS = {
  :global => ["preview-wrap"],
  Primer::Alpha::Layout => ["Layout"]
}.freeze

# Test CSS Selectors Used By Components
# ----
# 
# ensure all of the classes used by components are valid, checking against the
# available selectors in component-specific CSS
class ComponentSelectorUseTest < Minitest::Test
  include Primer::ComponentTestHelpers
  include Primer::RenderPreview

  COMPONENT_SELECTORS = Dir["app/{components,lib/primer}/**/*.css.json"].map do |file| 
    data = JSON.parse(File.read(file))
    data["selectors"].map { |sel| sel.gsub('\n', "").strip }
  end.flatten.uniq

  # these test methods are created dynamically so we can see all failures for
  # all components and not error after the first component failure
  # Primer::Component.descendants.each do |component_class|
  [Primer::Alpha::Layout].each do |component_class|
    class_test_name = component_class.name.downcase.gsub("::", "_")
    define_method("test_selectors_used_by_#{class_test_name}_are_valid") do
      preview_class = get_preview_class(component_class)
      next unless preview_class

      previews = preview_class.instance_methods(false)
      previews.each do |preview|
        preview_page = render_preview(preview, preview_klass: preview_class)
        preview_selectors = find_selectors(component_class, preview_page).map { |sel| ".#{sel}" }

        unmatched_selectors = (preview_selectors - COMPONENT_SELECTORS).sort
        assert unmatched_selectors.empty?, unmatched_selectors_message(component_class, unmatched_selectors)
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
    filter_selectors(component_class, flat_list, IGNORED_SELECTORS)
  end

  def unmatched_selectors_message(component_class, selectors)
    class_name = component_class.name
    selector_list = selectors.join("\n")

    msg = []
    msg << "PVC Component '#{class_name}' uses CSS selectors that are not found in the PVC source:"
    msg << ""
    msg << selector_list
    msg << ""
    msg << "CSS selectors not provided by PVC may be ignored by updating 'IGNORED_SELECTORS' in #{__FILE__}"

    msg.join("\n")
  end
end
