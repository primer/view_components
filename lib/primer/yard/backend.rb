# frozen_string_literal: true

module Primer
  module YARD
    class Backend
      include DocsHelper

      private

      def pretty_default_value(tag, component)
        params = tag.object.parameters.find { |param| [tag.name.to_s, "#{tag.name}:"].include?(param[0]) }
        default = tag.defaults&.first || params&.second

        return "N/A" unless default

        constant_name = "#{component.name}::#{default}"
        constant_value = default.safe_constantize || constant_name.safe_constantize

        return pretty_value(default) if constant_value.nil?

        pretty_value(constant_value)
      end

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
