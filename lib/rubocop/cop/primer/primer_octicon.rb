# frozen_string_literal: true

require "rubocop"
require "primer/classify/utilities"

module RuboCop
  module Cop
    module Primer
      # This cop ensures that components use System Arguments instead of CSS classes.
      #
      # bad
      # octicon("icon")
      #
      # good
      # primer_octicon("icon")
      class PrimerOcticon < RuboCop::Cop::Cop
        INVALID_MESSAGE = <<~STR
          Replace the octicon helper with primer_octicon. See https://primer.style/view-components/components/octicon for details.
        STR

        VALID_ATTRIBUTES = %i[height width size class].freeze

        def on_send(node)
          return unless node.method_name == :octicon
          return unless node.arguments?

          kwargs = node.arguments.last
          attributes = kwargs.keys.map(&:value)

          # Don't convert unknown attributes
          return unless (attributes - VALID_ATTRIBUTES).empty?

          # find class pair
          class_arg = kwargs.pairs.find { |kwarg| kwarg.key.value == :class }

          if class_arg.present?
            return unless class_arg.value.type == :str

            # get actual classes
            classes = class_arg.value.value

            system_arguments = ::Primer::Classify::Utilities.classes_to_hash(classes)

            # no classes are fixable
            return if system_arguments[:classes] == classes
          end

          add_offense(node, message: INVALID_MESSAGE)
        end

        # def autocorrect(node)
        #   lambda do |corrector|
        #     system_arguments = ::Primer::Classify::Utilities.classes_to_hash(node.value.value)
        #     corrector.replace(node.loc.expression, arguments_as_string(system_arguments))
        #   end
        # end

        private

        def arguments_as_string(system_arguments)
          system_arguments.map do |key, value|
            val = case value
                  when Symbol
                    ":#{value}"
                  when String
                    value.to_json
                  else
                    value
                  end

            "#{key}: #{val}"
          end.join(", ")
        end
      end
    end
  end
end
