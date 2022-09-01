# frozen_string_literal: true

module Primer
  module Responsive
    # argument space helper
    module ArgumentsDefinitionHelper
      RESPONSIVE_VARIANTS_MAP = Primer::Responsive::ResponsiveConfig::RESPONSIVE_VARIANTS_MAP
      RESPONSIVE_VARIANTS = Primer::Responsive::ResponsiveConfig::RESPONSIVE_VARIANTS
      REQUIRED_RESPONSIVE_VARIANTS = Primer::Responsive::ResponsiveConfig::REQUIRED_RESPONSIVE_VARIANTS

      private_constant :RESPONSIVE_VARIANTS_MAP, :RESPONSIVE_VARIANTS, :REQUIRED_RESPONSIVE_VARIANTS

      # NOTE: optional responsive variants are skipped
      # when calculating style classes and when validating missgin values
      # RESPONSIVE_VARIANTS_MAP = {
      #   v_narrow: {
      #     style_class_modifier: "whenNarrow"
      #   },
      #   v_regular: {
      #     style_class_modifier: "whenRegular"
      #   },
      #   v_wide: {
      #     optional: true,
      #     style_class_modifier: "whenWide"
      #   }
      # }.freeze

      # RESPONSIVE_VARIANTS = RESPONSIVE_VARIANTS_MAP.keys.freeze
      # REQUIRED_RESPONSIVE_VARIANTS = RESPONSIVE_VARIANTS_MAP.reject { |_, c| c[:optional] }.keys.freeze

      ARGUMENT_IDENTIFIER_KEY = :__argument_definition

      # Error raised when the a argument definition declaration is invalid
      InvalidArgumentDefinitionError = Class.new(StandardError)

      # Error when an invalid/inexistent argument is added to the arguments hash of a component
      InvalidArgumentError = Class.new(StandardError)

      # Error result of validating a argument value that doesn't comply with its definition
      InvalidArgumentValueError = Class.new(StandardError)

      def arguments_definition_builder(all_arguments_definition_hash = {}, namespace = "")
        namespace = "#{namespace}.".to_sym unless namespace.empty?

        arguments = {}
        all_arguments_definition_hash.each do |name, definition|
          arguments[name] = if definition.key?(ARGUMENT_IDENTIFIER_KEY)
                              ArgumentDefinition.new(
                                name: "#{namespace}#{name}".to_sym,
                                **definition[ARGUMENT_IDENTIFIER_KEY]
                              )
                            else
                              arguments_definition_builder(definition, name)
                            end
        end

        arguments
      end

      # "flag" a argument definition hash to be created as a arger ArgumentDefinition
      # allowing for argument namespacing
      def arg(argument_definition = {})
        { ARGUMENT_IDENTIFIER_KEY =>  argument_definition }
      end

      # Validates each argument in arguments definition
      # If the argument is exclusively responsive, the argument value cannot be set as a base
      # value after the arguments values are normalized with its default values
      #
      # @param arguments_definition [Hash] definition of the arguments available to the component
      # @param arguments [Hash] names params of the components
      def validate_argument_values(arguments_definition:, argument_values: {})
        arguments_definition.each do |arg, possible_definition|
          unless possible_definition.is_a? ArgumentDefinition
            validate_argument_values(
              arguments_definition: possible_definition,
              argument_values: argument_values.fetch(arg, {})
            )
            next
          end

          definition = possible_definition
          if definition.deprecated_value?(argument_values[arg])
            definition.deprecation.deprecation_warn(argument_values[arg])
            next
          end

          if definition.required? && !definition.responsive?(:yes)
            raise InvalidArgumentValueError, <<~MSG
              #{definition.invalid_value_base_message(argument_values[arg])}
              Argument value is required.
            MSG
          end

          # if definition.responsive == :yes && argument_values.key?(arg)
          #   raise InvalidArgumentValueError, <<~MSG
          #     #{definition.invalid_value_base_message(argument_values[arg])}
          #     Exclusively responsive argument can't have value outside of responsive variants.
          #   MSG
          # end

          definition.validate_value(argument_values[arg]) if argument_values.key?(arg)
          RESPONSIVE_VARIANTS.each do |variant|
            next unless argument_values.key?(variant)

            definition.validate_value(argument_values[variant][arg], variant)
          end
        end
      end

      # if a value is missing from the argument_values hash, it will be set to the default
      # value of the argument definition, if it has a default.
      #
      # @param arguments_definition [Hash] a map with the arguments part of the component API
      # @param argument_values [Hash] a map with the same structure of the definition holding component's current values
      # @param fallback_to_default [Boolean] if a value is not valid, it'll fallback to default if a default exists
      def fill_missing_values_with_default(arguments_definition:, argument_values: {}, fallback_to_default: false)
        arguments_definition.each do |arg, possible_definition|
          unless possible_definition.is_a? ArgumentDefinition
            argument_values[arg] = fill_missing_values_with_default(
              arguments_definition: possible_definition,
              argument_values: argument_values[arg] || {},
              fallback_to_default: fallback_to_default
            )
            next unless argument_values[arg].is_a? Hash

            # moving responsive args to the base variants hash.
            # since this method is recursive, it'll create responsive variants
            # into every recursive hash and it needs to be bubbled up til
            # the "root" level hash
            RESPONSIVE_VARIANTS.each do |variant|
              next unless argument_values[arg].key? variant

              argument_values[variant] = {} unless argument_values.key? variant
              argument_values[variant][arg] = argument_values[arg][variant]
            end

            # cleanup
            argument_values[arg].except!(*RESPONSIVE_VARIANTS)
            argument_values.delete(arg) if argument_values[arg].empty?
            next
          end

          definition = possible_definition
          has_to_fallback = fallback_to_default && !definition.valid_value?(argument_values[arg])
          next unless !argument_values.key?(arg) || argument_values[arg].nil? || has_to_fallback

          if definition.responsive?
            base_value = argument_values[arg] if argument_values.key? arg

            if definition.responsive?(:transitional) && !base_value.nil?
              argument_values[arg] = definition.default_value
              next
            end

            RESPONSIVE_VARIANTS_MAP.each do |responsive_variant, responsive_variant_config|
              argument_values[responsive_variant] = {} unless argument_values.key? responsive_variant

              has_defined_variant = argument_values[responsive_variant].key?(arg)
              responsive_value = has_defined_variant ? argument_values[responsive_variant][arg] : base_value

              has_to_fallback ||= (fallback_to_default && !definition.valid_value?(responsive_value, responsive_variant))

              next if has_defined_variant && !has_to_fallback
              next if responsive_variant_config[:transitional] && !definition.defined_default?(responsive_variant)

              argument_values[responsive_variant][arg] = responsive_value.nil? || has_to_fallback ? definition.default_value(responsive_variant) : responsive_value
            end
          elsif definition.defined_default?
            argument_values[arg] = definition.default_value
          end
        end

        argument_values
      end

      # if a value is missing from the argument_values hash, it will be set to the default
      # value of the argument definition, if it has a default.
      #
      # @param arguments_definition [Hash] a map with the arguments part of the component API
      # @param argument_values [Hash] a map with the same structure of the definition holding component's current values
      # @param fallback_to_default [Boolean] if a value is not valid, it'll fallback to default if a default exists
      def normalize_argument_values!(arguments_definition:, argument_values: {}, fallback_to_default: true)
        arguments_definition.each do |arg, possible_definition|
          # normalize recursive argument structure
          unless possible_definition.is_a? ArgumentDefinition
            nested_argument_values = argument_values[arg] || {}
            RESPONSIVE_VARIANTS.each do |variant|
              next unless argument_values.key? variant

              nested_argument_values[variant] = argument_values[variant][arg] if argument_values[variant].key? arg
            end

            argument_values[arg] = normalize_argument_values!(
              arguments_definition: possible_definition,
              argument_values: nested_argument_values,
              fallback_to_default: fallback_to_default
            )
            next unless argument_values[arg].is_a? Hash

            # moving responsive args to the base responsive variants hash.
            # since this method is recursive, it'll create responsive variants
            # into every recursive hash and it needs to be bubbled up til
            # the "root" level hash
            RESPONSIVE_VARIANTS.each do |variant|
              next unless argument_values[arg].key? variant

              argument_values[variant] = {} unless argument_values.key? variant
              argument_values[variant][arg] = argument_values[arg][variant]
            end

            # cleanup
            argument_values[arg].except!(*RESPONSIVE_VARIANTS)
            argument_values.delete(arg) if argument_values[arg].empty?
            next
          end

          definition = possible_definition
          is_base_value_set = argument_values.key?(arg)
          is_base_value_valid = definition.valid_value?(argument_values[arg])
          has_responsive_values = any_defined_responsive_values?(argument_values, arg)

          # transitional arguments accept base value in a non-responsive fashion
          if definition.responsive?(:no) || (definition.responsive?(:transitional) && (is_base_value_set || definition.defined_default?) && !has_responsive_values)
            has_to_fallback = fallback_to_default && !is_base_value_valid
            argument_values[arg] = definition.default_value if !is_base_value_set || has_to_fallback
            next
          end

          base_value = argument_values[arg] if is_base_value_set
          argument_values.delete(arg)

          # responsive variants will be added to spread the argument value if they're set as base value
          RESPONSIVE_VARIANTS_MAP.each do |responsive_variant, responsive_variant_config|
            next if !argument_values.key?(responsive_variant) && !definition.defined_default?(responsive_variant) && responsive_variant_config[:optional]

            argument_values[responsive_variant] = {} unless argument_values.key?(responsive_variant)

            has_defined_variant = argument_values[responsive_variant].key?(arg)
            responsive_value = has_defined_variant ? argument_values[responsive_variant][arg] : base_value
            is_responsive_value_valid = definition.valid_value?(responsive_value, responsive_variant)

            has_to_fallback = fallback_to_default && has_defined_variant && !is_responsive_value_valid
            argument_values[responsive_variant][arg] = has_to_fallback || responsive_value.nil? ? definition.default_value(responsive_variant) : responsive_value
          end
        end

        argument_values
      end

      def any_defined_responsive_values?(argument_values, argument_name)
        RESPONSIVE_VARIANTS_MAP.each_key do |responsive_variant|
          next unless argument_values.key?(responsive_variant)
          return true if argument_values[responsive_variant].key? argument_name
        end

        false
      end

      def production_env?
        Rails.env.production?
      end
      module_function :production_env?
    end
  end
end
