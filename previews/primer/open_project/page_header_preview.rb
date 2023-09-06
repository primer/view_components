# frozen_string_literal: true

module Primer
  module OpenProject
    # @logical_path primer/OpenProject
    # @component Primer::Beta::AutoComplete::Item
    # @label Page Header
    class PageHeaderPreview < ViewComponent::Preview
      # @label Default
      # @snapshot
      def default
        render(Primer::OpenProject::PageHeader.new) do |header|
          header.with_title { "Hello" }
          header.with_description { "Last updated 5 minutes ago by XYZ." }
        end
      end


      # @label Playground
      #
      def playground
        render(Primer::OpenProject::PageHeader.new) do |header|
          header.with_title { "Hello" }
          header.with_description { "Last updated 5 minutes ago by XYZ." }
        end
      end

      # @label With actions
      def actions
        render_with_template(locals: {})
      end
    end
  end
end
