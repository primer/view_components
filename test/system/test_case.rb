# frozen_string_literal: true

require "system/test_helper"
require "capybara/rails"
require "capybara/minitest"

require "test_helpers/cuprite_setup"
require "test_helpers/retry"

module System
  class TestCase < ActionDispatch::SystemTestCase
    driven_by :primer_cuprite, using: :chrome, screen_size: [1400, 1400], options: { process_timeout: 240, timeout: 240 }

    def visit_preview(scenario_name, params = {})
      component_name = self.class.name.gsub("Test", "").gsub("Integration", "")

      component = begin
        Kernel.const_get("Primer::#{component_name}")
      rescue NameError
        nil
      end

      match = /^(Alpha|Beta)([A-Z])/.match(component_name)
      status = match ? match[1] : ""
      status_path = match ? "#{status.downcase}/" : ""
      component_name = component_name.gsub(/^Beta|^Alpha/, "") if match
      component_uri = component_name.underscore

      url = +"/rails/view_components/primer/#{status_path}#{component_uri}/#{scenario_name}"
      query_string = params.map { |k, v| "#{k}=#{CGI.escape(v.to_s)}" }.join("&")
      url << "?#{query_string}" if query_string.present?

      visit(url)

      assert_accessible(
        excludes: Primer::Accessibility.axe_rules_to_skip(
          component: component,
          scenario_name: scenario_name,
          flatten: true
        )
      )
    end

    def format_accessibility_errors(violations)
      index = 0
      results = violations.map do |summary|
        summary["nodes"].map do |node|
          index += 1
          %{
    #{index}) #{summary['id']}: #{summary['description']} (#{summary['impact']})
    #{summary['helpUrl']}
    The following #{node['any'].size} node violate this rule:
      #{node['any'].map do |_violation|
        items = node['failureSummary'].sub('Fix any of the following:', '').split("\n")
        %(Selector: #{node['target'].join(', ')}
      HTML: #{node['html']}
      Fix any of the following:
      #{items.map { |item| "- #{item.strip}" }.join}
    )
      end.join}
            }
        end.join
      end.join
      %(
    Found #{violations.size} accessibility violations:
    #{results}
      )
    end

    def assert_accessible(excludes: nil)
      excludes ||= Set.new(Primer::Accessibility.axe_rules_to_skip)

      axe_exists = driver.evaluate_async_script <<~JS
        const callback = arguments[arguments.length - 1];
        callback(!!window.axe)
      JS

      results = driver.evaluate_async_script <<~JS
        const callback = arguments[arguments.length - 1];
        #{File.read('node_modules/axe-core/axe.min.js') unless axe_exists}
        #{File.read('node_modules/@github/axe-github/dist/configure-browser/configure-browser.js') unless axe_exists}
        // Remove cyclic references
        // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Errors/Cyclic_object_value#examples
        const getCircularReplacer = () => {
          const seen = new WeakSet();
          return (key, value) => {
            if (typeof value === "object" && value !== null) {
              if (seen.has(value)) {
                return;
              }
              seen.add(value);
            }
            return value;
          };
        };
        const excludedRulesConfig = {};
        for (const rule of [#{excludes.map { |id| "'#{id}'" }.join(', ')}]) {
          excludedRulesConfig[rule] = { enabled: false };
        }
        const options = {
          elementRef: true,
          resultTypes: ['violations'],
          rules: {
            ...excludedRulesConfig
          }
        }
        axe.run(document.body, options).then(res => JSON.parse(JSON.stringify(res, getCircularReplacer()))).then(callback);
      JS

      violations = results["violations"]

      message = format_accessibility_errors(violations)

      assert violations.size.zero?, message
    end

    # Capybara Overrides to run accessibility checks when UI changes.
    def fill_in(locator = nil, **kwargs)
      super

      assert_accessible
    end

    def click_button(locator = nil, **kwargs)
      super

      assert_accessible
    end

    private

    def driver
      page.driver
    end
  end
end
