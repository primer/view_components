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

        SIZE_ATTRIBUTES = %i[height width size].freeze
        VALID_ATTRIBUTES = [*SIZE_ATTRIBUTES, :class].freeze
        INVALID_CLASSES = -1

        def on_send(node)
          return unless node.method_name == :octicon
          return unless node.arguments?

          kwargs = node.arguments.last
          attributes = kwargs.keys.map(&:value)

          # Don't convert unknown attributes
          return unless (attributes - VALID_ATTRIBUTES).empty?
          # Can't convert size
          return if (SIZE_ATTRIBUTES & attributes).any? && octicon_size(kwargs).nil?

          # find class pair
          classes = classes(kwargs)

          return if classes == INVALID_CLASSES

          # check if classes are convertible
          if classes.present?
            system_arguments = ::Primer::Classify::Utilities.classes_to_hash(classes)

            # no classes are fixable
            return if system_arguments[:classes] == classes
          end

          add_offense(node, message: INVALID_MESSAGE)
        end

        def autocorrect(node)
          lambda do |corrector|
            icon = node.arguments.first.source
            kwargs = node.arguments.last

            # Converting arguments for the component
            classes = classes(kwargs)
            size = transform_size(kwargs)
            args = arguments_as_string(icon, size, classes)

            corrector.replace(node.loc.expression, "primer_octicon(#{args})")
          end
        end

        private

        def transform_size(kwargs)
          size = octicon_size(kwargs)

          return "" if size.between?(10, 16)
          return ":medium" if size.between?(22, 26)

          size
        end

        def octicon_size(kwargs)
          size = nil

          kwargs.pairs.each do |pair|
            if SIZE_ATTRIBUTES.include?(pair.key.value) && (pair.value.type == :str || pair.value.type == :int)
              size = pair.value.source.to_i
              break
            end
          end

          size
        end

        def classes(kwargs)
          # find class pair
          class_arg = kwargs.pairs.find { |kwarg| kwarg.key.value == :class }

          return if class_arg.blank?
          return INVALID_CLASSES unless class_arg.value.type == :str

          class_arg.value.value
        end

        def arguments_as_string(icon, size, classes)
          args = icon

          args += ", size: #{size}" if size.present?

          return args if classes.blank?

          system_args = ::Primer::Classify::Utilities.classes_to_args(classes)

          "#{args}, #{system_args}"
        end
      end
    end
  end
end
