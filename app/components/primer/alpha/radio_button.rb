# frozen_string_literal: true

module Primer
  module Alpha
    RadioButton = Primer::FormComponents.from_input(Primer::Forms::Dsl::RadioButtonInput)

    class RadioButton < Primer::Component
      status :alpha

      # @!method initialize
      #
      # @param foo [String]
    end
  end
end
