# frozen_string_literal: true

require "rubocop"
require "primer/classify/utilities"
require "primer/classify/validation"

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

        SIZE_ATTRIBUTES = %w[height width size].freeze
        STRING_ATTRIBUTES = %w[aria- data-].freeze
        VALID_ATTRIBUTES = [*SIZE_ATTRIBUTES, *STRING_ATTRIBUTES, "class"].freeze

        STRING_ATTRIBUTE_REGEX = Regexp.union(STRING_ATTRIBUTES).freeze
        ATTRIBUTE_REGEX = Regexp.union(VALID_ATTRIBUTES).freeze
        INVALID_ATTRIBUTE = -1

        def on_send(node)
          return unless node.method_name == :octicon
          return unless node.arguments?

          kwargs = kwargs(node)

          return unless kwargs.type == :hash

          attributes = kwargs.keys.map(&:value)

          # Don't convert unknown attributes
          return unless attributes.all? { |attribute| attribute.match?(ATTRIBUTE_REGEX) }
          # Can't convert size
          return if octicon_size_attributes(kwargs) == INVALID_ATTRIBUTE

          # find class pair
          classes = classes(kwargs)

          return if classes == INVALID_ATTRIBUTE

          # check if classes are convertible
          if classes.present?
            system_arguments = ::Primer::Classify::Utilities.classes_to_hash(classes)
            invalid_classes = (system_arguments[:classes]&.split(" ") || []).select { |class_name| ::Primer::Classify::Validation.invalid?(class_name) }

            # Uses system argument that can't be converted
            return if invalid_classes.present?
          end

          add_offense(node, message: INVALID_MESSAGE)
        end

        def autocorrect(node)
          lambda do |corrector|
            kwargs = kwargs(node)

            # Converting arguments for the component
            classes = classes(kwargs)
            size_attributes = transform_sizes(kwargs)
            args = arguments_as_string(node, size_attributes, classes)

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
            next unless SIZE_ATTRIBUTES.include?(pair.key.value.to_s)

            # We only support string or int values.
            case pair.value.type
            when :int
              h[pair.key.value] = pair.value.source.to_i
            when :str
              h[pair.key.value] = pair.value.value.to_i
            else
              return INVALID_ATTRIBUTE
            end
          end
        end

        def classes(kwargs)
          # find class pair
          class_arg = kwargs.pairs.find { |kwarg| kwarg.key.value == :class }

          return if class_arg.blank?
          return INVALID_ATTRIBUTE unless class_arg.value.type == :str

          class_arg.value.value
        end

        def arguments_as_string(node, size_attributes, classes)
          args = icon(node.arguments.first)
          size_args = size_attributes_to_string(size_attributes)
          string_args = string_args_to_string(node)

          args = "#{args}, #{size_attributes_to_string(size_attributes)}" if size_args.present?
          args = "#{args}, #{utilities_args(classes)}" if classes.present?
          args = "#{args}, #{string_args}" if string_args.present?

          args
        end

        def utilities_args(classes)
          args = ::Primer::Classify::Utilities.classes_to_hash(classes)

          color = case args[:color]
                  when :text_white
                    :text_white
                  when :text_link
                    :icon_info
                  else
                    args[:color].to_s.gsub("text_", "icon_").to_sym
                  end

          args[:color] = color

          ::Primer::Classify::Utilities.hash_to_args(args)
        end

        def size_attributes_to_string(size_attributes)
          # No arguments if they map to the default size
          return if size_attributes.blank? || size_attributes.values.all?(&:blank?)
          # Return mapped argument to `size`
          return "size: :medium" if size_attributes.values.any?(":medium")

          size_attributes.map do |key, value|
            "#{key}: #{value}"
          end.join(", ")
        end

        def string_args_to_string(node)
          kwargs = kwargs(node)

          args = kwargs.pairs.each_with_object([]) do |pair, acc|
            next unless pair.key.value.to_s.match?(STRING_ATTRIBUTE_REGEX)

            key =  pair.key.value.to_s == "data-test-selector" ? "test_selector" : "\"#{pair.key.value}\""
            acc << "#{key}: #{pair.value.source}"
          end

          args.join(",")
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
