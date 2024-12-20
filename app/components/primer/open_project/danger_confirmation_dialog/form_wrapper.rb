# frozen_string_literal: true

module Primer
  module OpenProject
    class DangerConfirmationDialog
      # Utility component for wrapping DangerConfirmationDialog in a form
      class FormWrapper < Primer::Component
        def initialize(builder: nil, action: nil, **form_arguments)
          raise ArgumentError, "Pass in either a :builder or :action argument, not both." if builder && action

          @builder = builder
          @action = action
          @form_arguments = deny_tag_argument(**form_arguments)
        end

        def renders_form?
          !@builder && @action
        end

        def shows_form?
          @builder || @action
        end
      end
    end
  end
end
