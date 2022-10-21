# frozen_string_literal: true

require_relative "base"

module ERBLint
  module Linters
    module ArgumentMappers
      # Maps classes in a flash element to arguments for the Flash component.
      class Flash < Base
        SCHEME_MAPPINGS = {
          "flash-success" => ":success",
          "flash-warn" => ":warning",
          "flash-error" => ":danger"
        }.freeze

        def classes_to_args(classes)
          classes.each_with_object({ classes: [] }) do |class_name, acc|
            next if class_name == "flash"

            if SCHEME_MAPPINGS[class_name] && acc[:scheme].nil?
              acc[:scheme] = SCHEME_MAPPINGS[class_name]
            elsif class_name == "flash-full"
              acc[:full] = true
            else
              acc[:classes] << class_name
            end
          end
        end
      end
    end
  end
end
