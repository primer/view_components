# frozen_string_literal: true

module Primer
  module Forms
    class ToggleSwitchForm < Primer::Forms::Base
      class << self
        def set_name(name)
          @name = name
          redefine_form
        end

        def set_label(label)
          @label = label
          redefine_form
        end

        def redefine_form
          return unless @label && @name

          name = @name
          label = @label

          form do |f|
            f.check_box(
              name: name,
              label: label
            )
          end
        end
      end
    end
  end
end
