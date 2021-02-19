# frozen_string_literal: true

require "active_support/concern"

module Primer
  module DSL
    module ViewHelper
      extend ActiveSupport::Concern

      class ViewHelperAlreadyDefined < StandardError; end
      class ViewHelperNotFound < StandardError; end

      included do
        class_attribute :helpers, instance_writer: false, default: {}
      end

      class_methods do
        def view_helper(name)
          raise ViewHelperAlreadyDefined if helpers[name].present?

          helpers[name] = self
        end
      end

      def primer(name, **component_args, &block)
        component = helpers[name]

        raise ViewHelperNotFound if component.blank?

        render component.new(**component_args), &block
      end
    end
  end
end
