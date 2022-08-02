# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class FormList
      extend ActsAsComponent

      renders_template File.join(__dir__, "form_list.html.erb")

      def initialize(*forms)
        @forms = forms
      end

      def perform_render(&_block)
        self.class.compile!
        render_form_list
      end
    end
  end
end
