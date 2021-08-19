# frozen_string_literal: true

module Primer
  # Extend this module to test basic linter behavior. You must define the following methods:
  #
  # * `default_tag` - returns the default tag to be matched by the linter
  # * `default_class` - returns the class to be matched by the linter. Return `nil` if no class is necessary.
  # * `required_attributes` - returns the HTML attributes required for the linter to run.
  module AutocorrectableLinterSharedTests
    def test_suggests_how_to_use_the_component_with_aria_arguments
      @file = <<~HTML
        <#{default_tag} class="#{default_class}" #{required_attributes} aria-label=\"Some label\">
          #{linter_class.name.demodulize}
        </#{default_tag}>
      HTML

      expected = <<~HTML
        <%= render #{linter_class::COMPONENT}.new(\"aria-label\": \"Some label\") do %>
          #{linter_class.name.demodulize}
        <% end %>
      HTML

      assert_equal expected, corrected_content
    end

    def test_suggests_how_to_use_the_component_with_data_arguments
      @file = <<~HTML
        <#{default_tag} class="#{default_class}" #{required_attributes} data-confirm=\"Some confirmation\">
          #{linter_class.name.demodulize}
        </#{default_tag}>
      HTML

      expected = <<~HTML
        <%= render #{linter_class::COMPONENT}.new(\"data-confirm\": \"Some confirmation\") do %>
          #{linter_class.name.demodulize}
        <% end %>
      HTML

      assert_equal expected, corrected_content
    end

    def test_ignores_if_using_unsupported_arguments
      @file = <<~HTML
        <#{default_tag} class="#{default_class}" #{required_attributes} invalid-attr>
          #{linter_class.name.demodulize}
        </#{default_tag}>
      HTML

      expected = "<%# erblint:counter #{linter_class.name.demodulize} 1 %>\n#{@file}"

      assert_equal expected, corrected_content
    end

    def test_ignores_if_cannot_convert_class
      @file = <<~HTML
        <#{default_tag} class="#{default_class} text-center" #{required_attributes}>
          #{linter_class.name.demodulize}
        </#{default_tag}>
      HTML

      expected = "<%# erblint:counter #{linter_class.name.demodulize} 1 %>\n#{@file}"

      assert_equal expected, corrected_content
    end

    def test_does_not_autocorrects_when_ignores_are_correct
      @file = <<~HTML
        <%# erblint:counter #{linter_class.name.demodulize} 2 %>
        <#{default_tag} class="#{default_class}" #{required_attributes}>
          #{linter_class.name.demodulize}
        </#{default_tag}>
        <#{default_tag} class="#{default_class}" #{required_attributes}>
          #{linter_class.name.demodulize}
        </#{default_tag}>
      HTML

      assert_equal @file, corrected_content
    end

    def test_autocorrects_ignore_counts_if_override_enabled
      @linter = linter_with_override
      @file = <<~HTML
        <%# erblint:counter #{linter_class.name.demodulize} 2 %>
        <#{default_tag} class="#{default_class}" #{required_attributes}>
          #{linter_class.name.demodulize}
        </#{default_tag}>
        <#{default_tag} class="#{default_class}" #{required_attributes} invalid-attr>
          #{linter_class.name.demodulize}
        </#{default_tag}>
      HTML

      expected = <<~HTML
        <%# erblint:counter #{linter_class.name.demodulize} 1 %>
        <%= render #{linter_class::COMPONENT}.new do %>
          #{linter_class.name.demodulize}
        <% end %>
        <#{default_tag} class="#{default_class}" #{required_attributes} invalid-attr>
          #{linter_class.name.demodulize}
        </#{default_tag}>
      HTML

      assert_equal expected, corrected_content
    end

    def test_autocorrects_if_ignore_is_incorrect
      @file = <<~HTML
        <%# erblint:counter #{linter_class.name.demodulize} 3 %>
        <#{default_tag} class="#{default_class}" #{required_attributes}>
          #{linter_class.name.demodulize}
        </#{default_tag}>
        <#{default_tag} class="#{default_class}" #{required_attributes} invalid-attr>
          #{linter_class.name.demodulize}
        </#{default_tag}>
      HTML

      expected = <<~HTML
        <%# erblint:counter #{linter_class.name.demodulize} 1 %>
        <%= render #{linter_class::COMPONENT}.new do %>
          #{linter_class.name.demodulize}
        <% end %>
        <#{default_tag} class="#{default_class}" #{required_attributes} invalid-attr>
          #{linter_class.name.demodulize}
        </#{default_tag}>
      HTML

      assert_equal expected, corrected_content
    end

    def test_autocorrects_known_system_arguments
      @file = <<~HTML
        <#{default_tag} class="#{default_class} mr-1 p-3 d-none d-md-block anim-fade-in" #{required_attributes}>
          #{linter_class.name.demodulize}
        </#{default_tag}>
      HTML

      expected = <<~HTML
        <%= render #{linter_class::COMPONENT}.new(mr: 1, p: 3, display: [:none, nil, :block], animation: :fade_in) do %>
          #{linter_class.name.demodulize}
        <% end %>
      HTML

      assert_equal expected, corrected_content
    end

    def test_autocorrects_with_custom_classes
      @file = <<~HTML
        <#{default_tag} class="#{default_class} mr-1 p-3 d-none d-md-block anim-fade-in custom-1 custom-2" #{required_attributes}>
          #{linter_class.name.demodulize}
        </#{default_tag}>
      HTML

      expected = <<~HTML
        <%= render #{linter_class::COMPONENT}.new(mr: 1, p: 3, display: [:none, nil, :block], animation: :fade_in, classes: "custom-1 custom-2") do %>
          #{linter_class.name.demodulize}
        <% end %>
      HTML

      assert_equal expected, corrected_content
    end
  end
end
