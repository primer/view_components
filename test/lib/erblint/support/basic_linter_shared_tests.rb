# frozen_string_literal: true

module Primer
  # Extend this module to test basic linter behavior. You must define the following methods:
  #
  # * `default_tag` - returns the default tag to be matched by the linter
  # * `default_class` - returns the class to be matched by the linter. Return `nil` if no class is necessary.
  # * `required_attributes` - returns the HTML attributes required for the linter to run.
  module BasicLinterSharedTests
    def test_warns_if_there_is_a_html_element
      @file = <<~HTML
        <#{default_tag} class="#{default_class}" #{required_attributes}>
          #{linter_class.name.demodulize}
        </#{default_tag}>
      HTML

      @linter.run(processed_source)

      refute_empty @linter.offenses
    end

    def test_suggests_ignoring_with_correct_number_of_elements
      @file = <<~HTML
        <#{default_tag} class="#{default_class}" #{required_attributes} invalid-attr>
          #{linter_class.name.demodulize}
        </#{default_tag}>
        <#{default_tag} class="#{default_class}" #{required_attributes} invalid-attr>
          #{linter_class.name.demodulize}
        </#{default_tag}>
        <a-random-tag>
          #{linter_class.name.demodulize}
        </a-random-tag>
      HTML

      assert_equal "<%# erblint:counter #{linter_class.name.demodulize} 2 %>\n#{@file}", corrected_content
    end

    def test_suggests_updating_the_number_of_ignored_elements
      @file = <<~HTML
        <%# erblint:counter #{linter_class.name.demodulize} 1 %>
        <#{default_tag} class="#{default_class}" #{required_attributes} invalid-attr>
          #{linter_class.name.demodulize}
        </#{default_tag}>
        <#{default_tag} class="#{default_class}" #{required_attributes} invalid-attr>
          #{linter_class.name.demodulize}
        </#{default_tag}>
        <a-random-tag>
          #{linter_class.name.demodulize}
        </a-random-tag>
      HTML

      @linter.run(processed_source)

      assert_equal "<%# erblint:counter #{linter_class.name.demodulize} 2 %>", offenses.last.context
    end

    def test_does_not_warn_if_wrong_tag
      skip if linter_class::TAGS.empty?

      @file = <<~HTML
        <a-random-tag class="#{default_class}" #{required_attributes}>#{linter_class.name.demodulize}</a-random-tag>"
      HTML

      @linter.run(processed_source)

      assert_empty @linter.offenses
    end
  end
end
