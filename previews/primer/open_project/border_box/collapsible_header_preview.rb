# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module OpenProject
    module BorderBox
      # @label BorderBox::CollapsibleHeader
      class CollapsibleHeaderPreview < ViewComponent::Preview
        # @label Playground
        # @param title [String]
        # @param description [String]
        # @param collapsed toggle
        # @param count [Integer]
        def playground(
          title: "Title text",
          description: "Long description text goes here.",
          count: 42,
          collapsed: false
        )
          render_with_template(locals: {
            title: title,
            description: description,
            count: count,
            collapsed: collapsed
          })
        end

        # @label Default
        # @snapshot
        def default
          render_with_template
        end

        # @label With counter
        # @snapshot
        def with_count
          render_with_template
        end

        # @label With description text
        # @snapshot
        def with_description
          render_with_template
        end

        # @label Collapsed initially
        # @snapshot
        def collapsed
          render_with_template
        end
      end
    end
  end
end
