# frozen_string_literal: true

module Primer
  module ViewHelper
    extend ActiveSupport::Concern

    def primer(name, **component_args, &block)
      component = Primer::Component.helpers[name]

      raise ViewHelperNotFound if component.blank?

      render component.new(**component_args), &block
    end
  end
end
