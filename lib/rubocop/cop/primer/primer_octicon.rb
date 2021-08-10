# frozen_string_literal: true

require "rubocop"
require "primer/classify/utilities"

# :nocov:
module RuboCop
  module Cop
    module Primer
      # This cop ensures that components use System Arguments instead of CSS classes.
      #
      # bad
      # octicon(:icon)
      # octicon("icon")
      # octicon("icon-with-daashes")
      # octicon(@ivar)
      # octicon(condition > "icon" : "other-icon")
      #
      # good
      # primer_octicon(:icon)
      # primer_octicon(:"icon-with-daashes")
      # primer_octicon(@ivar)
      # primer_octicon(condition > "icon" : "other-icon")
      class PrimerOcticon < RuboCop::Cop::Cop
        INVALID_MESSAGE = <<~STR
          Replace the octicon helper with primer_octicon. See https://primer.style/view-components/components/octicon for details.
        STR

        SIZE_ATTRIBUTES = %i[height width size].freeze
        VALID_ATTRIBUTES = [*SIZE_ATTRIBUTES, :class].freeze
        INVALID_ATTRIBUTE = -1

        def on_send(node)
          return unless node.method_name == :octicon
          return unless node.arguments?

          kwargs = kwargs(node)

          return unless kwargs.type == :hash

          attributes = kwargs.keys.map(&:value)

          # Don't convert unknown attributes
          return unless (attributes - VALID_ATTRIBUTES).empty?
          # Can't convert size
          return if octicon_size_attributes(kwargs) == INVALID_ATTRIBUTE

          # find class pair
          classes = classes(kwargs)

          return if classes == INVALID_ATTRIBUTE

          # check if classes are convertible
          if classes.present?
            system_arguments = ::Primer::Classify::Utilities.classes_to_hash(classes)

            # Uses custom classes
            return if system_arguments[:classes].present?
          end

          add_offense(node, message: INVALID_MESSAGE)
        end

        def autocorrect(node)
          lambda do |corrector|
            icon_node = node.arguments.first
            kwargs = kwargs(node)

            # Converting arguments for the component
            classes = classes(kwargs)
            size_attributes = transform_sizes(kwargs)
            args = arguments_as_string(icon_node, size_attributes, classes)

            corrector.replace(node.loc.expression, "primer_octicon(#{args})")
          end
        end

        private

        def transform_sizes(kwargs)
          attributes = octicon_size_attributes(kwargs)

          attributes.transform_values do |size|
            if size.between?(10, 16)
              ""
            elsif size.between?(22, 26)
              ":medium"
            else
              size
            end
          end
        end

        def octicon_size_attributes(kwargs)
          kwargs.pairs.each_with_object({}) do |pair, h|
            next unless SIZE_ATTRIBUTES.include?(pair.key.value)

            # We only support string or int values.
            return INVALID_ATTRIBUTE if pair.value.type != :str && pair.value.type != :int

            h[pair.key.value] = pair.value.source.to_i
          end
        end

        def classes(kwargs)
          # find class pair
          class_arg = kwargs.pairs.find { |kwarg| kwarg.key.value == :class }

          return if class_arg.blank?
          return INVALID_ATTRIBUTE unless class_arg.value.type == :str

          class_arg.value.value
        end

        def arguments_as_string(icon_node, size_attributes, classes)
          args = icon(icon_node)

          size_args = size_attributes_to_string(size_attributes)
          args = "#{args}, #{size_args}" if size_args.present?

          return args if classes.blank?

          system_args = ::Primer::Classify::Utilities.classes_to_args(classes)
          "#{args}, #{system_args}"
        end

        def size_attributes_to_string(size_attributes)
          # No arguments if they map to the default size
          return if size_attributes.blank? || size_attributes.values.all?(&:blank?)
          # Return mapped argument to `size`
          return "size: :medium" if size_attributes.values.any? { |val| val == ":medium" }

          size_attributes.map do |key, value|
            "#{key}: #{value}"
          end.join(", ")
        end

        def kwargs(node)
          return node.arguments.last if node.arguments.size > 1

          OpenStruct.new(keys: [], pairs: [], type: :hash)
        end

        def icon(node)
          return node.source unless node.type == :str
          return ":#{node.value}" unless node.value.include?("-")

          # If the icon contains `-` we need to cast the string as a symbole
          # E.g: `arrow-down` becomes `:"arrow-down"`
          ":#{node.source}"
        end
      end
    end
  end
end
