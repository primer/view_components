# frozen_string_literal: true

require "primer/class_name_helper"

module Primer
  module Forms
    # Wraps Primer::BaseComponent.
    class PrimerBaseComponentWrapper < BaseComponent
      include Primer::ClassNameHelper

      def initialize(**system_arguments)
        @system_arguments = system_arguments

        # Extract class and classes so they can be passed to Primer::BaseComponent
        # as classes:. The class: argument is expected by Rails, but Primer expects
        # classes:, reminiscent of HashWithIndifferentAccess shenanigans.
        @classes = class_names(
          system_arguments.delete(:classes),
          system_arguments.delete(:class)
        )
      end
    end
  end
end
