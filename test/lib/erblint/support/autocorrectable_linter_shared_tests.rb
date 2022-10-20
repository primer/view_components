# frozen_string_literal: true

module Primer
  # Extend this module to test basic linter behavior. You must define the following methods:
  #
  # * `default_tag` - returns the default tag to be matched by the linter
  # * `default_class` - returns the class to be matched by the linter. Return `nil` if no class is necessary.
  # * `required_attributes` - returns the HTML attributes required for the linter to run.
  # * `required_arguments` - returns base arguments used by autocorrection.
  module AutocorrectableLinterSharedTests
    def test_suggests_how_to_use_the_component_with_aria_arguments
      @file = <<~HTML
        <#{default_tag} class="#{default_class}" #{required_attributes} aria-value=\"Some value\">
          #{default_content}
        </#{default_tag}>
      HTML

      expected = if block_correction?
                   <<~HTML
                     <%= render #{linter_class::COMPONENT}.new(#{"#{required_arguments}, " if required_arguments}\"aria-value\": \"Some value\") do %>
                       #{default_content}
                     <% end %>
                   HTML
                 else
                   <<~HTML
                     <%= render #{linter_class::COMPONENT}.new(#{"#{required_arguments}, " if required_arguments}\"aria-value\": \"Some value\") %>
                   HTML
                 end

      assert_equal expected, corrected_content
    end

    def test_suggests_how_to_use_the_component_with_data_arguments
      @file = <<~HTML
        <#{default_tag} class="#{default_class}" #{required_attributes} data-confirm=\"Some confirmation\">
          #{default_content}
        </#{default_tag}>
      HTML

      expected = if block_correction?
                   <<~HTML
                     <%= render #{linter_class::COMPONENT}.new(#{"#{required_arguments}, " if required_arguments}\"data-confirm\": \"Some confirmation\") do %>
                       #{default_content}
                     <% end %>
                   HTML
                 else
                   <<~HTML
                     <%= render #{linter_class::COMPONENT}.new(#{"#{required_arguments}, " if required_arguments}\"data-confirm\": \"Some confirmation\") %>
                   HTML
                 end

      assert_equal expected, corrected_content
    end

    def test_ignores_if_using_unsupported_arguments
      @file = <<~HTML
        <#{default_tag} class="#{default_class}" #{required_attributes} invalid-attr>
          #{default_content}
        </#{default_tag}>
      HTML

      expected = "<%# erblint:counter #{linter_class.name.demodulize} 1 %>\n#{@file}"

      assert_equal expected, corrected_content
    end

    def test_ignores_if_cannot_convert_class
      @file = <<~HTML
        <#{default_tag} class="#{default_class} text-fuzzy-waffle" #{required_attributes}>
          #{default_content}
        </#{default_tag}>
      HTML

      expected = "<%# erblint:counter #{linter_class.name.demodulize} 1 %>\n#{@file}"

      assert_equal expected, corrected_content
    end

    def test_does_not_autocorrects_when_ignores_are_correct
      @file = <<~HTML
        <%# erblint:counter #{linter_class.name.demodulize} 2 %>
        <#{default_tag} class="#{default_class}" #{required_attributes}>
          #{default_content}
        </#{default_tag}>
        <#{default_tag} class="#{default_class}" #{required_attributes}>
          #{default_content}
        </#{default_tag}>
      HTML

      assert_equal @file, corrected_content
    end

    def test_autocorrects_ignore_counts_if_override_enabled
      @linter = linter_with_override
      @file = <<~HTML
        <%# erblint:counter #{linter_class.name.demodulize} 2 %>
        <#{default_tag} class="#{default_class}" #{required_attributes}>
          #{default_content}
        </#{default_tag}>
        <#{default_tag} class="#{default_class}" #{required_attributes} invalid-attr>
          #{default_content}
        </#{default_tag}>
      HTML

      expected = if block_correction?
                   <<~HTML
                     <%# erblint:counter #{linter_class.name.demodulize} 1 %>
                     <%= render #{linter_class::COMPONENT}.new#{"(#{required_arguments})" if required_arguments} do %>
                       #{default_content}
                     <% end %>
                     <#{default_tag} class="#{default_class}" #{required_attributes} invalid-attr>
                       #{default_content}
                     </#{default_tag}>
                   HTML
                 else
                   <<~HTML
                     <%# erblint:counter #{linter_class.name.demodulize} 1 %>
                     <%= render #{linter_class::COMPONENT}.new#{"(#{required_arguments})" if required_arguments} %>
                     <#{default_tag} class="#{default_class}" #{required_attributes} invalid-attr>
                       #{default_content}
                     </#{default_tag}>
                   HTML
                 end

      assert_equal expected, corrected_content
    end

    def test_autocorrects_if_ignore_is_incorrect
      @file = <<~HTML
        <%# erblint:counter #{linter_class.name.demodulize} 3 %>
        <#{default_tag} class="#{default_class}" #{required_attributes}>
          #{default_content}
        </#{default_tag}>
        <#{default_tag} class="#{default_class}" #{required_attributes} invalid-attr>
          #{default_content}
        </#{default_tag}>
      HTML

      expected = if block_correction?
                   <<~HTML
                     <%# erblint:counter #{linter_class.name.demodulize} 1 %>
                     <%= render #{linter_class::COMPONENT}.new#{"(#{required_arguments})" if required_arguments} do %>
                       #{default_content}
                     <% end %>
                     <#{default_tag} class="#{default_class}" #{required_attributes} invalid-attr>
                       #{default_content}
                     </#{default_tag}>
                   HTML
                 else
                   <<~HTML
                     <%# erblint:counter #{linter_class.name.demodulize} 1 %>
                     <%= render #{linter_class::COMPONENT}.new#{"(#{required_arguments})" if required_arguments} %>
                     <#{default_tag} class="#{default_class}" #{required_attributes} invalid-attr>
                       #{default_content}
                     </#{default_tag}>
                   HTML
                 end

      assert_equal expected, corrected_content
    end

    def test_autocorrects_known_system_arguments
      @file = <<~HTML
        <#{default_tag} class="#{default_class} mr-1 p-3 d-none d-md-block anim-fade-in color-fg-default" #{required_attributes}>
          #{default_content}
        </#{default_tag}>
      HTML

      expected = if block_correction?
                   <<~HTML
                     <%= render #{linter_class::COMPONENT}.new(mr: 1, p: 3, display: [:none, nil, :block], animation: :fade_in, color: :default#{", #{required_arguments}" if required_arguments}) do %>
                       #{default_content}
                     <% end %>
                   HTML
                 else
                   <<~HTML
                     <%= render #{linter_class::COMPONENT}.new(mr: 1, p: 3, display: [:none, nil, :block], animation: :fade_in, color: :default#{", #{required_arguments}" if required_arguments}) %>
                   HTML
                 end

      assert_equal expected, corrected_content
    end

    def test_autocorrects_with_custom_classes
      @file = <<~HTML
        <#{default_tag} class="#{default_class} mr-1 p-3 d-none d-md-block anim-fade-in color-fg-default custom-1 custom-2" #{required_attributes}>
          #{default_content}
        </#{default_tag}>
      HTML

      expected = if block_correction?
                   <<~HTML
                     <%= render #{linter_class::COMPONENT}.new(mr: 1, p: 3, display: [:none, nil, :block], animation: :fade_in, color: :default, classes: "custom-1 custom-2"#{", #{required_arguments}" if required_arguments}) do %>
                       #{default_content}
                     <% end %>
                   HTML
                 else
                   <<~HTML
                     <%= render #{linter_class::COMPONENT}.new(mr: 1, p: 3, display: [:none, nil, :block], animation: :fade_in, color: :default, classes: "custom-1 custom-2"#{", #{required_arguments}" if required_arguments}) %>
                   HTML
                 end

      assert_equal expected, corrected_content
    end
  end
end
