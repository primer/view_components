# frozen_string_literal: true

require "lib/erblint_test_case"

class IncludeFragmentComponentMigrationCounterTest < ErblintTestCase
  include Primer::BasicLinterSharedTests
  include Primer::AutocorrectableLinterSharedTests

  def test_suggests_how_to_use_the_component_with_arguments
    @file = "<include-fragment src=\"/some/path\" loading=\"lazy\">IncludeFragment</include-fragment>"
    @linter.run(processed_source)

    assert_includes(offenses.first.message, "render Primer::Alpha::IncludeFragment.new(src: \"/some/path\", loading: \"lazy\")")
  end

  def test_autocorrects
    @file = <<~HTML
      <include-fragment src="/some/path" loading="lazy">
        IncludeFragment 1
        <include-fragment src="/some/path" loading="lazy" invalid-attr>
          Can\'t be autocorrected
        </include-fragment>
        <include-fragment src="/some/path" loading="lazy">
          IncludeFragment 2
          <a>not a IncludeFragment</a>
        </include-fragment>
      </include-fragment>
    HTML

    expected = <<~HTML
      <%# erblint:counter IncludeFragmentComponentMigrationCounter 1 %>
      <%= render Primer::Alpha::IncludeFragment.new(src: "/some/path", loading: "lazy") do %>
        IncludeFragment 1
        <include-fragment src="/some/path" loading="lazy" invalid-attr>
          Can\'t be autocorrected
        </include-fragment>
        <%= render Primer::Alpha::IncludeFragment.new(src: "/some/path", loading: "lazy") do %>
          IncludeFragment 2
          <a>not a IncludeFragment</a>
        <% end %>
      <% end %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_with_class_and_data_attributes
    @file = <<~HTML
      <include-fragment class="custom-class" data-target="some-target">
        include-fragment
      </include-fragment>
    HTML

    expected = <<~HTML
      <%= render Primer::Alpha::IncludeFragment.new(classes: "custom-class", "data-target": "some-target") do %>
        include-fragment
      <% end %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_basic_erb_interpolation
    @file = <<~HTML
      <include-fragment src="<%= some_call %>" loading="lazy">
        include-fragment
      </include-fragment>
    HTML

    expected = <<~HTML
      <%= render Primer::Alpha::IncludeFragment.new(src: some_call, loading: "lazy") do %>
        include-fragment
      <% end %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_interpolation_with_string
    @file = <<~HTML
      <include-fragment src="string-<%= some_call %>" loading="lazy">
        include-fragment
      </include-fragment>
    HTML

    expected = <<~'HTML'
      <%= render Primer::Alpha::IncludeFragment.new(src: "string-#{ some_call }", loading: "lazy") do %>
        include-fragment
      <% end %>
    HTML

    assert_equal expected, corrected_content
  end

  def test_autocorrects_multiple_interpolations
    @file = <<~HTML
      <include-fragment src="string-<%= some_call %><%= other_call %>-more-<%= another_call %>" loading="lazy">
        include-fragment
      </include-fragment>
    HTML

    expected = <<~'HTML'
      <%= render Primer::Alpha::IncludeFragment.new(src: "string-#{ some_call }#{ other_call }-more-#{ another_call }", loading: "lazy") do %>
        include-fragment
      <% end %>
    HTML

    assert_equal expected, corrected_content
  end

  private

  def linter_class
    ERBLint::Linters::IncludeFragmentComponentMigrationCounter
  end

  def default_tag
    "include-fragment"
  end
end
