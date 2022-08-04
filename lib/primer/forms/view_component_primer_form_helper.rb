# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    module ViewComponentPrimerFormHelper
      # Delegate to the original view context so the form builder object will use the
      # correct context to emit form elements. Prevents out-of-order rendering problems.
      def primer_form_with(*args, **kwargs, &block)
        helpers.primer_form_with(*args, **kwargs, &block)
      end
    end
  end
end
