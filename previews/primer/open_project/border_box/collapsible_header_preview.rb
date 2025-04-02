# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module OpenProject
    module BorderBox
      # @label CollapsibleHeader
      class CollapsibleHeaderPreview < ViewComponent::Preview
        # @label Playground
        # @param title [String]
        # @param description [String]
        # @param collapsed toggle
        # @param count [Integer]
        def playground(
          title: "Backlog",
          description: "This backlog is unique to this one-time meeting. You can drag items in and out to add or remove them from the meeting agenda.",
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
          render_with_template(
            template: "primer/open_project/border_box/collapsible_header_preview/playground",
            locals: {
              title: "Backlog",
              description: nil,
              count: nil,
              collapsed: false
            }
          )
        end

        # @label With counter
        # @snapshot
        def with_count
          render_with_template(
            template: "primer/open_project/border_box/collapsible_header_preview/playground",
            locals: {
              title: "Backlog",
              description: nil,
              count: 42,
              collapsed: false
            }
          )
        end

        # @label With description text
        # @snapshot
        def with_description
          render_with_template(
            template: "primer/open_project/border_box/collapsible_header_preview/playground",
            locals: {
              title: "Backlog",
              description: "This backlog is unique to this one-time meeting. You can drag items in and out to add or remove them from the meeting agenda.",
              count: nil,
              collapsed: false
            }
          )
        end

        # @label Collapsed initially
        # @snapshot
        def collapsed
          render_with_template(
            template: "primer/open_project/border_box/collapsible_header_preview/playground",
            locals: {
              title: "Backlog",
              description: "This backlog is unique to this one-time meeting. You can drag items in and out to add or remove them from the meeting agenda.",
              count: nil,
              collapsed: true
            }
          )
        end
      end
    end
  end
end
