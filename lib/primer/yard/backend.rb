# frozen_string_literal: true

require "primer/yard/docs_helper"

module Primer
  module YARD
    class Backend
      include DocsHelper

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
