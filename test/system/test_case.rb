# frozen_string_literal: true

require "system/test_helper"
require "capybara/rails"
require "capybara/minitest"

require "axe/matchers/be_axe_clean"
require "axe/expectation"

require "test_helpers/cuprite_setup"
require "test_helpers/retry"

module System
  class TestCase < ActionDispatch::SystemTestCase
    driven_by :cuprite, using: :chrome, screen_size: [1400, 1400], options: { process_timeout: 240, timeout: 240 }

    # Skip `:region` which relates to preview page structure rather than individual component.
    # Skip `:color-contrast` which requires primer design-level change.
    # Skip `:aria-required-children` is broken in 4.5: https://github.com/dequelabs/axe-core/issues/3758
    AXE_RULES_TO_SKIP = [:region, :'color-contrast', :'color-contrast-enhanced', :'aria-required-children'].freeze

    def visit_preview(preview_name, params = {})
      component_name = self.class.name.gsub("Test", "").gsub("Integration", "")
      match = /^(Alpha|Beta)([A-Z])/.match(component_name)
      status = match ? match[1] : ""
      status_path = match ? "#{status.downcase}/" : ""
      component_name = component_name.gsub(/^Beta|^Alpha/, "") if match
      component_uri = component_name.underscore

      url = +"/rails/view_components/primer/#{status_path}#{component_uri}/#{preview_name}"
      query_string = params.map { |k, v| "#{k}=#{CGI.escape(v.to_s)}" }.join("&")
      url << "?#{query_string}" if query_string.present?

      visit(url)

      assert_accessible
    end

    def format_accessibility_errors(violations)
      results = violations.map.with_index do |summary, index|
        summary["nodes"].map do |node|
          violations = node["any"] + node["all"]
          <<~OUTPUT
                        #{index + 1}) #{summary['id']}: #{summary['description']} (#{summary['impact']})
                        #{summary['helpUrl']}
            #{'            '}
                          The following #{violations.size} node violate this rule:
                          #{violations.map do |_violation|
                            <<~OUTPUT
                              Selector: #{node['target'].join(', ')}
                                HTML: #{node['html']}
                                #{node['failureSummary']}
                            OUTPUT
                          end.join}
          OUTPUT
        end.join
      end.join
      <<~OUTPUT
        Found #{violations.size} accessibility violations:
          #{results}
      OUTPUT
    end

    def assert_accessible
      axe_exists = page.driver.evaluate_script "!!window.axe"

      results = page.driver.evaluate_async_script <<~JS
        const callback = arguments[arguments.length - 1];
        #{File.read('node_modules/axe-core/axe.min.js') unless axe_exists}

        const rulesToRun = axe
          .getRules(["wcag2a", "wcag21a", "wcag2aa", "wcag2aaa", "wcag21aa", "wcag21aaa"])
          .map(rule => rule.ruleId)
          .filter(id => ![#{AXE_RULES_TO_SKIP.map { |id| "'#{id}'" }.join(', ')}].includes(id))

        const options = {
          elementRef: true,
          resultTypes: ['violations', 'incomplete'],
          runOnly: {
            type: 'rule',
            values: rulesToRun
          }
        }
        axe.run(document.body, options).then(res => JSON.parse(JSON.stringify(res))).then(callback);
      JS

      violations = (results["violations"] + results["incomplete"].filter { |item| item["impact"] != "serious" && item["impact"] != "critical" })

      message = format_accessibility_errors(violations)

      assert violations.empty?, message
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
    end
end
