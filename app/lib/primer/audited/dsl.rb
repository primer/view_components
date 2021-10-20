# frozen_string_literal: true

require "active_support/concern"

module Primer
  # :nodoc:
  module Audited
    # DSL to register when a component has passed an accessibility audit.
    #
    # Example:
    #
    # class MyComponent < ViewComponent::Base
    #   include Primer::Audited::Dsl
    #   audited_at 'YYYY-MM-DD'
    # end
    module Dsl
      extend ActiveSupport::Concern

      included do
        class_attribute :audit_date, instance_writer: false
      end

      class_methods do
        def audited_at(datestring = nil)
          return audit_date if datestring.nil?

          self.audit_date = Date.parse(datestring)
        end
      end
    end
  end
end
