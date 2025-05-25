# frozen_string_literal: true

module Primer
  module ViewComponents
    # :nodoc:
    class IncludeFragmentController < ApplicationController
      layout false

      def landing; end

      def deferred
        render "primer/view_components/include_fragment/deferred"
      end
    end
  end
end
