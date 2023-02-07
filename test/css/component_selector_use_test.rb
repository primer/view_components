# frozen_string_literal: true

require "system/test_case"

require_relative "./test_helper"
Dir["app/components/**/*.rb"].each { |file| require_relative "../../#{file}" }

# rubocop:disable Style/WordArray
IGNORED_SELECTORS = {
  # these are all provided by primer/css
  :global => ["octicon", "btn-octicon", "btn", "btn-primary", "btn-danger", "btn-outline"],
  Primer::Alpha::AutoComplete => ["form-control", "ActionList"],
  Primer::Alpha::HiddenTextExpander => ["ellipsis-expander", "hidden-text-expander"],
  Primer::Beta::ButtonGroup => ["BtnGroup", "BtnGroup-item"],
  Primer::Beta::CloseButton => ["close-button"],
  Primer::Beta::Details => ["details-overlay"],
  Primer::Beta::Markdown => ["markdown-body"],

  # AutoComplete uses a pre-release version of the ActionList styles from primer/css.
  # The .ActionList class does not exist in PVC.
  Primer::Beta::AutoComplete => ["ActionList"]
}.freeze
# rubocop:enable Style/WordArray

# Test CSS Selectors Used By Components
# ----
#
# ensure all of the classes used by components are valid, checking against the
# available selectors in component-specific CSS
class ComponentSelectorUseTest < System::TestCase
  parallelize workers: 4

  extend Primer::RenderPreview
  include Primer::RenderPreview

  COMPONENT_SELECTORS = Dir["app/{components,lib/primer}/**/*.css.json"].flat_map do |file|
    data = JSON.parse(File.read(file))
    data["selectors"]
  end.uniq

  # these test methods are created dynamically so we can see all failures for
  # all components and not error after the first component failure
  Primer::Component.descendants.each do |component_class|
    preview_class = get_preview_class(component_class)
    next unless preview_class

    previews = preview_class.instance_methods(false)
    component_uri = preview_class.to_s.underscore.gsub("_preview", "")

    previews.each do |preview|
      define_method("test_selectors_used_by_#{component_uri.parameterize(separator: '_')}_#{preview}_are_valid") do
        visit("/rails/view_components/#{component_uri}/#{preview}")

        global_ignored_selectors = IGNORED_SELECTORS.fetch(:global, [])
        ignored_selectors = IGNORED_SELECTORS.fetch(component_class, [])

        unmatched_selectors = driver.evaluate_async_script(<<~JS, COMPONENT_SELECTORS, global_ignored_selectors, ignored_selectors)
          const [componentSelectors, globalIgnoredSelectors, ignoredSelectors, callback] = arguments;
          const root = document.querySelector('.preview-wrap > *');

          const ignoreClass = (className) => {
            return(
              globalIgnoredSelectors.includes(className) ||
                ignoredSelectors.includes(className) ||
                className.startsWith('octicon-')
            );
          };

          const ignoreNode = (node) => {
            for (let i = 0; i < node.classList.length; i ++) {
              if (!ignoreClass(node.classList[i])) {
                return false;
              }
            }

            return true;
          };

          const findEachNode = (node, cb) => {
            if (!ignoreNode(node)) {
              cb(node)
            }

            for (const child of node.children) {
              findEachNode(child, cb);
            }
          };

          const nodeMatchesAtLeastOneComponentSelector = (node) => {
            for (const componentSelector of componentSelectors) {
              if (node.matches(componentSelector) || node.querySelectorAll(`:scope > ${componentSelector}`).length > 0) {
                return true;
              }
            }

            return false;
          }

          let unmatchedClasses = [];

          findEachNode(root, (node) => {
            if (!nodeMatchesAtLeastOneComponentSelector(node)) {
              for (className of node.classList) {
                if (!ignoreClass(className)) {
                  unmatchedClasses.push(className);
                }
              }
            }
          });

          const result = Array.from(new Set(unmatchedClasses));
          callback(result);
        JS

        assert unmatched_selectors.empty?, unmatched_selectors_message(component_class, unmatched_selectors)
      end
    end
  end

  private

  def unmatched_selectors_message(component_class, selectors)
    class_name = component_class.name
    selector_list = selectors.compact.sort.join("\n")

    msg = []
    msg << "PVC Component '#{class_name}' uses CSS classes that are not selected by any rule in the PVC source:"
    msg << ""
    msg << selector_list
    msg << ""
    msg << "If these CSS classes are not provided by PVC, they may be ignored by updating 'IGNORED_SELECTORS' in #{__FILE__}"

    msg.join("\n")
  end
end
