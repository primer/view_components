# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module OpenProject
    # @label ZenModeButton
    class ZenModeButtonPreview < ViewComponent::Preview
      def playground()
        render(Primer::OpenProject::ZenModeButton.new())
      end
    # @label Default
      def default()
        render(Primer::OpenProject::ZenModeButton.new())
      end
    end
  end
end
