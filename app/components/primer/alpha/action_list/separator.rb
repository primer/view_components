# frozen_string_literal: true

module Primer
  module Alpha
    class ActionList
      # Section heading rendered above the section contents.
      class Separator < Primer::Component
        # @param filled [Boolean] Whether or not the section is filled, i.e. has a colored background.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(filled: false, **system_arguments)
          @system_arguments = system_arguments
          @system_arguments[:tag] = :li
          @system_arguments[:role] = :separator
          @system_arguments[:'aria-hidden'] = true
          @system_arguments[:classes] = class_names(
            "ActionList-sectionDivider",
            filled ? "ActionList-sectionDivider--filled" : ""
          )
        end

        def call
          render(Primer::BaseComponent.new(**@system_arguments)) { "" }
        end
      end
    end
  end
end
