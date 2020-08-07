# frozen_string_literal: true

module Primer
  class Component < ViewComponent::Base
    include ClassNameHelper
    include FetchOrFallbackHelper
    include OcticonsHelper

    if Rails.env.development?
      include ActiveSupport::Dependencies
      unloadable

      def self.inherited(subclass)
        subclass.unloadable
        super
      end
    end
  end
end
