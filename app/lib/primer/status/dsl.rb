# frozen_string_literal: true

require "active_support/concern"

module Primer
  # :nodoc:
  module Status
    # DSL to allow components to register their status.
    #
    # Example:
    #
    # class MyComponent < ViewComponent::Base
    #   include Primer::Status::Dsl
    #   status :beta
    # end
    module Dsl
      extend ActiveSupport::Concern

      STATUSES = {
        alpha: :alpha,
        beta: :beta,
        stable: :stable,
        deprecated: :deprecated,
        experimental: :experimental
      }.freeze

      class UnknownStatusError < StandardError; end

      included do
        class_attribute :component_status, instance_writer: false, default: STATUSES[:alpha]
      end

      class_methods do
        def status(status = nil)
          return component_status if status.nil?

          raise UnknownStatusError, "status #{status} does not exist" if STATUSES[status].nil?

          self.component_status = STATUSES[status]
        end
      end
    end
  end
end
