# frozen_string_literal: true

# :nocov:

require "primer/yard/docs_helper"

module Primer
  module YARD
    # Shared functionality for generating documentation from YARD comments.
    class Backend
      include DocsHelper

      private

      def view_context
        @view_context ||= begin
          # Rails controller for rendering arbitrary ERB
          vc = ApplicationController.new.tap { |c| c.request = ActionDispatch::TestRequest.create }.view_context
          vc.singleton_class.include(DocsHelper)
          vc.singleton_class.include(Primer::ViewHelper)
          vc
        end
      end
    end
  end
end
# :nocov:
