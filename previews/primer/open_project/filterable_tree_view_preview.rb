# frozen_string_literal: true

module Primer
  module OpenProject
    # @label FilterableTreeView
    class FilterableTreeViewPreview < ViewComponent::Preview
      # @label Playground
      #
      # @snapshot interactive
      # @param expanded [Boolean] toggle
      def playground(expanded: true)
        render_with_template(locals: {
          expanded: coerce_bool(expanded)
        })
      end

      # @label Default
      #
      # @snapshot interactive
      # @param expanded [Boolean] toggle
      def default(expanded: true)
        render_with_template(locals: {
          expanded: coerce_bool(expanded)
        })
      end

      # @label Form input
      #
      # @param expanded [Boolean] toggle
      def form_input(expanded: true)
        render_with_template(locals: {
          expanded: coerce_bool(expanded)
        })
      end

      private

      def coerce_bool(value)
        case value
        when true, false
          value
        when "true"
          true
        when "false"
          false
        else
          false
        end
      end
    end
  end
end
