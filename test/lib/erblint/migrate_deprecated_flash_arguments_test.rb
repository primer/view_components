# frozen_string_literal: true

require "lib/erblint_test_case"

class MigrateDeprecatedFlashArgumentsTest < ErblintTestCase
  def test_no_offenses_when_no_deprecated_args
    @file = "<%= render(Primer::Beta::Flash.new(dismissible: true)) %>"
    @linter.run(processed_source)

    assert_empty @linter.offenses
  end

  def test_identifies_spacious_argument
    @file = "<%= render(Primer::Beta::Flash.new(dismissible: true, spacious: true)) %>"
    @linter.run(processed_source)

    refute_empty @linter.offenses
  end

  def test_replaces_spacious_argument_when_true
    @file = <<~ERB
      <%= render(Primer::Beta::Flash.new(dismissible: true, spacious: true)) do |c| %>
        Some content
      <% end %>
    ERB

    expected = <<~ERB
      <%= render(Primer::Beta::Flash.new(dismissible: true, mb: 4)) do |c| %>
        Some content
      <% end %>
    ERB

    assert_equal expected, corrected_content
  end

  def test_removes_spacious_argument_when_false
    @file = <<~ERB
      <%= render(Primer::Beta::Flash.new(dismissible: true, spacious: false)) { |c| %>
        Some content
      <% } %>
    ERB

    expected = <<~ERB
      <%= render(Primer::Beta::Flash.new(dismissible: true)) { |c| %>
        Some content
      <% } %>
    ERB

    assert_equal expected, corrected_content
  end

  private

  def linter_class
    ERBLint::Linters::MigrateDeprecatedFlashArguments
  end
end
