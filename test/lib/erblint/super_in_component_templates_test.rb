# frozen_string_literal: true

require "lib/erblint_test_case"

class SuperInComponentTemplatesTest < ErblintTestCase
  def test_identifies_super_calls
    @file = "<div><% super %></div>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_identifies_echoed_super_calls
    @file = "<div><%= super %></div>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_replaces_super_with_render_parent
    @file = <<~ERB
      <div>
        <% super %>
      </div>
    ERB

    expected = <<~ERB
      <div>
        <% render_parent %>
      </div>
    ERB

    assert_equal expected, corrected_content
  end

  def test_replaces_echoed_super_with_render_parent
    @file = <<~ERB
      <div>
        <%= super %>
      </div>
    ERB

    expected = <<~ERB
      <div>
        <%= render_parent %>
      </div>
    ERB

    assert_equal expected, corrected_content
  end

  def test_replaces_super_when_nested
    @file = <<~ERB
      <div>
        <% 3.times { |_i| super } %>
      </div>
    ERB

    expected = <<~ERB
      <div>
        <% 3.times { |_i| render_parent } %>
      </div>
    ERB

    assert_equal expected, corrected_content
  end

  private

  def linter_class
    ERBLint::Linters::SuperInComponentTemplates
  end
end
