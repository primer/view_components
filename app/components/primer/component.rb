# frozen_string_literal: true

module Primer
  class Component < ViewComponent::Base
    include ClassNameHelper
    include FetchOrFallbackHelper
    include OcticonsHelper

    class << self
      ##
      # Creates a `deprecations` class attribute for each child
      # This will ensure deprecations between different components
      # won't clash
      def inherited(base)
        base.class_eval do
          class_attribute :deprecations, instance_writer: false
          self.deprecations = {}
        end

        super
      end

      def deprecated_options_for(opt, *args)
        deprecations[opt] = args
      end
    end

    def before_render
      deprecations.each do |(opt, values)|
        val = instance_variable_get("@#{opt}")
        Primer::Deprecation.warn("option `#{val}` for `#{opt}` is deprecated and should not be used") if val.present? && val.in?(values)
      end
    end
  end
end
