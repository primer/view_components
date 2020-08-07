# frozen_string_literal: true

module Primer
  module Unloadable
    if Rails.env.development?
      include ActiveSupport::Dependencies
      unloadable

      def self.included(subclass)
        subclass.unloadable
        super
      end
    end
  end
end
