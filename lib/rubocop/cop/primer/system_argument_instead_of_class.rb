# frozen_string_literal: true

require "rubocop"
require "primer/classify/utilities"
require "primer/view_components/statuses"

module RuboCop
  module Cop
    module Primer
      # This cop ensures that components use System Arguments instead of CSS classes.
      #
      # bad
      # Component.new(classes: "mr-1")
      #
      # good
      # Component.new(mr: 1)
      class SystemArgumentInsteadOfClass < RuboCop::Cop::Cop
        INVALID_MESSAGE = <<~STR
          Avoid using CSS classes when you can use System Arguments: https://primer.style/view-components/system-arguments.
        STR

        def on_send(node)
          return unless node.method_name == :new
          return unless ::Primer::ViewComponents::STATUSES.key?(node.receiver.const_name)
          return unless node.arguments?

          # we are looking for hash arguments and they are always last
          kwargs = node.arguments.last

          return unless kwargs.type == :hash

          # find classes pair
          classes_arg = kwargs.pairs.find { |kwarg| kwarg.key.value == :classes }

          return if classes_arg.nil?
          return unless classes_arg.value.type == :str

          # get actual classes
          classes = classes_arg.value.value

          system_arguments = ::Primer::Classify::Utilities.classes_to_hash(classes)

          # no classes are fixable
          return if system_arguments[:classes] == classes

          add_offense(classes_arg, message: INVALID_MESSAGE)
        end

        def autocorrect(node)
          lambda do |corrector|
            args = ::Primer::Classify::Utilities.classes_to_args(node.value.value)
            corrector.replace(node.loc.expression, args)
          end
        end
      end
    end
  end
end
